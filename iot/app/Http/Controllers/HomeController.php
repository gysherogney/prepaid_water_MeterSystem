<?php

namespace App\Http\Controllers;

use App\Models\UserWatter;
use App\Models\UserWatterUsage;
use Carbon\Carbon;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */



     public function index(Request $request)
     {

         if (auth()->user()->is_admin) {
             return view('home');
         }
         $userId = auth()->id();
         $dailyUsage = [];
         $labels = [];
         // Iterate through the past 7 days
         for ($i = 0; $i < 7; $i++) {
             $startOfDay = Carbon::now()->subDays($i)->startOfDay();
             $endOfDay = Carbon::now()->subDays($i)->endOfDay();
            $date = Carbon::now()->subDays($i);
            $labels[] = $date->format('d D'); // Format the date as desired (e.g., "May 01")
             // Query user water usage for each day
             $usages = UserWatterUsage::where('user_id', $userId)
                                      ->whereBetween('created_at', [$startOfDay, $endOfDay]);
            if($request->meter_id){
                $usages =$usages->where('user_watter_id',$request->meter_id);
            }
            $usages = $usages
            ->sum('usage');
             // Store the daily usages in the array
             $dailyUsage[] = $usages;
         }
         $dailyUsage = Collect($dailyUsage);
         $dailyUsage = $dailyUsage->reverse();
          $dailyUsage = $dailyUsage->toArray();
          $dailyUsage =  array_values($dailyUsage);

          //reverse labels
          $labels = Collect($labels);
          $labels = $labels->reverse();
           $labels = $labels->toArray();
           $labels =  array_values($labels);
           $meters = UserWatter::where('user_id',auth()->id())->get();

         return view('user', compact('dailyUsage','labels','meters'));
     }




    public function getgaugedata(Request $request){

        if($request->meter_id){
            $meter = UserWatter::where([['id',$request->meter_id],['user_id',auth()->id()]])->first();
            $total =$meter->total;
            $balance =$meter->balance;
        }
        else {
             $meter = UserWatter::where('user_id',auth()->id())->get();
            $total =$meter->sum('total');
            $balance =$meter->sum('balance');
        }

        return response()->json([
            'totalWater' => $total,
            'remainingWater' =>  $balance,
        ]);
    }

    public function purchase(){
        return view('buy');
    }
}
