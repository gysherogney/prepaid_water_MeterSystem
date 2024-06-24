<?php
use App\Routers\Mikrotik;

if (!function_exists('routerClient')) {
    function routerClient()
    {
        return Mikrotik::getClient('41.59.112.185', 'admin', '@ASTRONOVA1905n');

    }
}


if (!function_exists('logMeIn')) {
    function logMeIn($client, $user)
    {
        $client = routerClient();
        Mikrotik::logMeIn($client, $user->phone, $user->password, $user->ip, $user->mac);
    }
}

if (!function_exists('convertPhoneNumber')) {

    function convertPhoneNumber($phone)
    {
        // Check if the phone number is 10 digits and starts with '0'
        if (strlen($phone) == 10 && strpos($phone, '0') === 0) {
            // Remove the first character ('0') and prepend '255'
            return '255' . substr($phone, 1);
        } else {
            // Return the original phone number if it doesn't meet the criteria
            return $phone;
        }
    }
}
