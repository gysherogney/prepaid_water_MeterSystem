<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Services\UserService; // Import your service

class CheckUserStatusCommand extends Command
{
    protected $signature = 'user:check-status';
    protected $description = 'Check user status and perform actions';

    public function __construct()
    {
        parent::__construct();
    }

    public function handle()
    {
        $userService = new UserService();
        $userService->checkUserStatus();

        $this->info('User status check completed.');
    }
}
