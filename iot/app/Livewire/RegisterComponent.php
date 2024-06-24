<?php

namespace App\Livewire;

use App\Models\User;
use App\Models\UserWatter;
use Illuminate\Support\Facades\Http;
use Livewire\Component;
use Illuminate\Support\Facades\Hash;

class RegisterComponent extends Component
{
    public $name;
    public $phone;
    public $email;
    public $password;
    public $password_confirmation;

    public $show_adwater = false;
    public $user_id;
    public $meter_no;
    public $water_amount;


    public function showAddWaterForm($id){
        if($this->show_adwater ==  false){
            $user = User::findOrfail($id);
            $this->name = $user->name;
            $this->user_id = $user->id;

        }
        else {
            $this->name =null;

        }

        $this->show_adwater = !$this->show_adwater;
    }
    public function addWaterBalance(){
        $this->validate([
            'meter_no' => 'required|exists:user_watters,meter_no'
        ]);
        $meter = UserWatter::where('meter_no',$this->meter_no)->first();
        $meter->balance =  $meter->balance + $this->water_amount ;
        $meter->total =  $meter->total + $this->water_amount ;
        $meter->save();
        $this->reset();
    }


    public function sendSmsSingle($mteja, $password)
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
                    "message" => "Ndugu {$mteja->name} , Usajili umekamilika kwa maji portal. Tumia Email: {$mteja->email}, na neno siri: {$password} . Asante kwa kutumia Maji Portal. sponsored by zepsonsms.co.tz"
                ]);



        return $response;
    }
    public function register()
    {
        $user = $this->validate([
            'phone' => 'required|digits:10|unique:users',
             'name' => 'required',
            'email' => 'required|email'
        ]);
        $password =  random_int(1111,9999);
        $user['password'] = Hash::make($password);
        $mteja = User::create(
            $user
        );

         $this->sendSmsSingle($mteja, $password);
         $this->reset();
     }

     public function delete($id){
        $user = User::findOrFail($id);

        if($user->is_admin == 0){
            $user->delete();
        }
     }

     public function deleteMeter($id){
        $meter = UserWatter::findOrFail($id);
        $meter->delete();

     }

     public function generateMeter($id){
        $user = User::findOrFail($id);

         $meter = new UserWatter();
         $meter->user_id = $user->id;
         $meter->meter_no = time().random_int(11111,99999);
         $meter->save();
     }

    public function render()
    {
        return view('livewire.register-component',[
            'users' => User::all()
        ]);
    }
}
