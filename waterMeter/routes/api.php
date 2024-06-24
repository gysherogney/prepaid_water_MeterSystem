<?php

use App\Http\Controllers\RouterController;
use App\Http\Controllers\WatterApiController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::post('balance', [WatterApiController::class, 'balance']);
Route::post('verify', [WatterApiController::class, 'verify']);
Route::post('usage', [WatterApiController::class, 'usage']);
Route::post('callback', [WatterApiController::class, 'callback'])->name('callback');
