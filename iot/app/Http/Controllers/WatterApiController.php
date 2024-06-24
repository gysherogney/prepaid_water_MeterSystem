<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\UserOrder;
use App\Models\UserWatter;
use App\Models\UserWatterUsage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class WatterApiController extends Controller
{
    public function balance(Request $req){

        $req->validate([
            'meter_no'=> 'required',
        ]);

        $balance = UserWatter::where('meter_no',$req->meter_no)->first();

        if($balance==null){
            return response()->json([
                'success' => false,
                'balance' => 0
            ],404);
        }


        return response()->json([
            'success' => true,
            'balance' => $balance->balance<0?0:$balance->balance
        ]);
    }

    public function usage(Request $req){

         $req->validate([
            'meter_no'=> 'required',
            'usage' => 'required'
        ]);
        $usage_to_litter = ($req->usage)/1000;

        $meter = UserWatter::where('meter_no',$req->meter_no)->first();

        if($meter==null){
            return response()->json([
                'success' => false,
                'balance' => 0
            ],404);
        }
        $current_balance = $meter->balance - $usage_to_litter;
        $meter->balance = $current_balance;
        $meter->save();
        $usage = new UserWatterUsage();
        $usage->user_id = $meter->user_id;
        $usage->user_watter_id = $meter->id;
        $usage->usage = $usage_to_litter;
        $usage->save();
        $current_remaining_percentage = ($current_balance/($meter->total))*100;

        if($current_remaining_percentage<=75){
            //send sms
            $mteja = User::findOrFail($meter->user_id);
            $this->sendSmsSingle($mteja,"Ndugu {$mteja->name} ,Maji yako ni chini ya asilimia 75, Tafadhali ongeza maji kabla hayajaisha. Asante kwa kutumia Maji Portal. sponsored by zepsonsms.co.tz");

        }

        return response()->json([
            'success' => true,
            'balance' => $meter->balance<0?0:$meter->balance
        ]);
    }

    public function callback(Request $request){

        $order = UserOrder::where('reff',$request->vendor_reff)->first();
        if($order == null){
            abort(404);
        }
        $order->status = $request->status;
        $order->save();
        if($request->status == 'complete'){
            $meter = UserWatter::where('id',$order->user_water_id)->first();
            $meter->total =  $meter->total + $order->quantiry;
            $meter->balance =  $meter->balance + $order->quantiry;
            $meter->save();

        }
    }

    public function sendSmsSingle($mteja, $message)
    {
        $api_key = "2|hQixqykmEy5XAdeK2emgekSDypXNwXlCIoXg0OYb";
        $url = "https://portal.zepsonsms.co.tz/api/v3/sms/send";
        $phone = substr($mteja->phone, 1);
        $phone = "255" . $phone;

        $response = Http::withHeaders([
            "Authorization" => "Bearer " . $api_key,
            "Content-Type" => "application/json",
        ])->withoutVerifying()->post($url, [
                    "recipient" => "$phone",
                    "sender_id" => "ZEPSONSMS",
                    "type" => "plain",
                    "message" => $message
                ]);



        return $response;
    }
}
