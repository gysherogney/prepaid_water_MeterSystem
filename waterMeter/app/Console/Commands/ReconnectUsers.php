<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\UserRecharge;
use App\Routers\Mikrotik;

class ReconnectUsers extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:reconnect-users';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {

        $subscriptions = UserRecharge::where('status', 'on')
            ->get();


        foreach ($subscriptions as $subscribe) {
            $user = $subscribe->user;
            $plan = $subscribe->plan;
            $client = Mikrotik::getClient('41.59.112.185', 'admin', '@ASTRONOVA1905n');
            Mikrotik::removeHotspotUser($client, $user->phone);
            Mikrotik::addHotspotUser($client, $plan, $user);
            if ($user->ip != null && $user->mac != null) {
                logMeIn($client, $user);
            }
        }
    }
}
