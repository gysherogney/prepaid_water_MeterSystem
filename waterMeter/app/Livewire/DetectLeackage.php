<?php

namespace App\Livewire;

use App\Models\UserWatter;
use Carbon\Carbon;
use Livewire\Component;
use Illuminate\Support\Facades\DB as FacadesDB;

class DetectLeackage extends Component
{

    public $meterId;
    public $leackage = [
        'leakage' => false,
        'suspected_amount' => 0
    ];

    public function mount($meterId=null){
        if(auth()->user()->is_admin){
            $this->meterId = $meterId;
        }
        else {
            $this->meterId = $meterId??UserWatter::where('user_id',auth()->id())->first()->id;
        }
      
    }

              public  function detectLeakage()
            {
                  $meterId = $this->meterId;
                // Get the current time and the time 2 minutes ago
                $now = Carbon::now();
                $twoMinutesAgo = $now->copy()->subMinutes(2);

                // Query to get water usage records for the user for the last 2 minutes
                $usages = FacadesDB::table('user_watter_usages')
                    ->where('user_watter_id', $meterId)
                    ->where('created_at', '>=', $twoMinutesAgo)
                    ->orderBy('created_at', 'asc')
                    ->get();

                // If there are no usage records, return false
                if ($usages->isEmpty()) {
                    $this->leackage =  [
                        'leakage' => false,
                        'suspected_amount' => 0
                    ];

                    return ;
                }

                // Calculate the total usage in the last 2 minutes
                $totalUsage = $usages->sum('usage');

                // Check if the usage is continuous for more than 2 minutes
                $continuousUsage = $this->checkContinuousUsage($usages);

                if ($continuousUsage) {
                    $this->leackage =  [
                        'leakage' => true,
                        'suspected_amount' => $totalUsage
                    ];
                    return ;
                }

                $this->leackage =  [
                    'leakage' => false,
                    'suspected_amount' => 0
                ];
            }

            function checkContinuousUsage($usages): bool
            {
                $previousTimestamp = null;

                foreach ($usages as $usage) {
                    if ($previousTimestamp) {
                        $diffInSeconds = Carbon::parse($usage->created_at)->diffInSeconds($previousTimestamp);

                        if ($diffInSeconds > 120) {
                            return false;
                        }
                    }

                    $previousTimestamp = Carbon::parse($usage->created_at);
                }

                return true;
            }


    public function render()
    {
        return view('livewire.detect-leackage');
    }
}
