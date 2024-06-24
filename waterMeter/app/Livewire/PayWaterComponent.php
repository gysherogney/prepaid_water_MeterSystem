<?php

namespace App\Livewire;

use App\Models\UserOrder;
use App\Models\UserWatter;
use Illuminate\Support\Facades\Http;
use Livewire\Component;

class PayWaterComponent extends Component
{

    public $water_amount = 5;
    public $meters;
    public $meter_id;
    public $reff;
    public $phone;
    private $base_url =  'https://pay.zepson.co.tz/api/';
    private $api_key = "304a5b65-acfd-4415-822e-69802e890cb5";
    private $api_secret = "4fc8136a-d38f-40a4-831e-01309599bfc4";
    public $message;
    public $is_loading = false;

    public $start_polling = false;

    public function mount(){
        $this->meters = UserWatter::where('user_id',auth()->id())->get();
        $this->meter_id = $this->meters->first()->id??null;
    }

    public function pay(){
        $this->validate([
            'phone' => 'required|digits:10'
        ]);
//CREATE ORDER ON MAJI DB
            $this->is_loading = true;
        $this->reff = time().random_int(1111,9999);
        $order = new UserOrder();
        $order->user_id = auth()->id();
        $order->user_water_id =$this->meter_id;
        $order->reff = $this->reff;
        $order->amount = $this->water_amount*env('PRICE_PER_LITER');
        $order->quantiry =$this->water_amount;
        $order->phone =$this->phone;
        $order->save();
//CREATE ORDER ON ZEPSONPAY
        $this->createOrder($order->amount);


//SEND PUSH TO USER
    }

    public function createOrder($amount){


        $order_array = [
            'api_key' =>   $this->api_key,
            'api_secret' =>  $this->api_secret ,
            'source' => 'MAJI PORTAL',
            'vendor_reff' => $this->reff,
            'amount' =>"$amount",
            'msisdn' => $this->phone,
            'first_name' => auth()->user()->name,
            'last_name' =>  auth()->user()->name,
            'webhook' =>  route('callback')
        ];

        $response = Http::withoutVerifying()
                          ->post($this->base_url."prepare-order",
                            $order_array);
        if($response->successful()){
            $this->message =  "<span class='text-success> Order Imetengenezwa kikamilifu , Tafadhali subiri </span>";
            $this->sendPush();
        }
    }


    public function sendPush(){

        $order_array = [
            'api_key' =>   $this->api_key,
            'api_secret' =>  $this->api_secret ,
            'vendor_reff' => $this->reff,
            'msisdn' => $this->phone
        ];

        $response = Http::withoutVerifying()
                          ->post($this->base_url."wallet-push",
                            $order_array);
                            $this->message =  "<span class='text-success>Tafadhali tazama simu yako kukamilisha malipo! </span>";
        $this->start_polling = true;


    }

    public function checkStatus(){
        $order = UserOrder::where('reff', $this->reff)->first();

        if($order->status == 'complete'){
            $this->dispatch('payment-complete');
        }
    }
    public function render()
    {
        return view('livewire.pay-water-component');
    }
}
