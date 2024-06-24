<?php

namespace App\Console\Commands;

use App\Models\User;
use App\Routers\Mikrotik;
use Illuminate\Console\Command;
use App\Models\UserRecharge;
use Carbon\Carbon;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

// Import other necessary classes

class CronJobManager extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'cron:manage';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Manages cron jobs for the application';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $notifications = $this->checkSubscriptions();
        $this->sendMessage($notifications);
        $this->info('Subscription checks complete.');
    }



    private function checkSubscriptions()
    {
        $intervals = ['7 days', '5 days', '1 day', '5 hours', 'expired'];
        $notifications = [];

        foreach ($intervals as $interval) {
            if ($interval == 'expired') {
                $subscriptions = UserRecharge::whereRaw('TIMESTAMP(expiration, time) < ?', [Carbon::now()])
                    ->where('expiration_notified', false)
                    ->get();
            } else {
                $dateToCheck = Carbon::now()->add($interval);

                $subscriptions = UserRecharge::whereRaw('TIMESTAMP(expiration, time) = ?', [$dateToCheck])
                    ->where(function ($query) {
                        $query->whereNull('last_notification_sent_at')
                            ->orWhereDate('last_notification_sent_at', '<', Carbon::today());
                    })
                    ->get();
            }

            foreach ($subscriptions as $subscription) {
                $expirationDateTime = Carbon::createFromFormat('Y-m-d H:i:s', $subscription->expiration . ' ' . $subscription->time);
                $message = $interval == 'expired' ? "Ndugu {$subscription->user->name},kifurushi chako kimekwisha muda wake. Asante kwa kutumia Momo Internet services. Kwa maelezo zaidi piga 0752771650" : "Ndugu {$subscription->user->name}, kifurushi chako kitakwisha muda wake {$expirationDateTime->format('Y-m-d H:i:s')}. Asante kwa kutumia Momo Internet services. Kwa maelezo zaidi piga 0752771650";

                if ($interval == 'expired' || $this->shouldSendNotification($subscription, $interval)) {

                    $notifications[] = ['phone' => $subscription->user->phone, 'message' => $message];

                    // Update notification time and flag
                    if ($interval != 'expired') {
                        $subscription->last_notification_sent_at = Carbon::now();
                    } else {
                        $subscription->expiration_notified = true;
                        $subscription->status = 'off';
                        $client = Mikrotik::getClient('41.59.112.185', 'admin', '@ASTRONOVA1905n');
                        Mikrotik::removeHotspotActiveUser($client, $subscription->user->phone);
                        Mikrotik::removeHotspotUser($client, $subscription->user->phone);
                    }
                    $subscription->save();
                }
            }
        }

        return $notifications;
    }

    private function shouldSendNotification($subscription, $interval)
    {
        // Add logic to determine if a notification should be sent
        // For example, check if the last_notification_sent_at is null or before today
        return is_null($subscription->last_notification_sent_at) ||
            $subscription->last_notification_sent_at->isBefore(Carbon::today());
    }


    private function formatPhoneNumber($phoneNumber)
    {
        return '255' . ltrim($phoneNumber, '0');
    }


    private function sendMessage($notifications)
    {
        foreach ($notifications as $notification) {
            // Implement the logic to send a message
            // Example: SomeSMSProvider::send($notification['phone'], $notification['message']);
            $this->info("Message sent to {$notification['phone']} - {$notification['message']}");

            $api_key = "2|hQixqykmEy5XAdeK2emgekSDypXNwXlCIoXg0OYb";
            $url = "https://portal.zepsonsms.co.tz/api/v3/sms/send";
            $phone = $notification['phone'];
            $phone = substr($phone, 1);
            $phone = "255" . $phone;

            $response = Http::withHeaders([
                "Authorization" => "Bearer " . $api_key,
                "Content-Type" => "application/json",
            ])->post($url, [
                        "recipient" => $phone,
                        "sender_id" => "MOMO NET",
                        "type" => "plain",
                        "message" => $notification['message']
                    ]);



            return $response;
        }
    }

}
