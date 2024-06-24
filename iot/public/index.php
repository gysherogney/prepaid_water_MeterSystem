<?php

use Illuminate\Contracts\Http\Kernel;
use Illuminate\Http\Request;

define('LARAVEL_START', microtime(true));

/*
|--------------------------------------------------------------------------
| Check If The Application Is Under Maintenance
|--------------------------------------------------------------------------
|
| If the application is in maintenance / demo mode via the "down" command
| we will load this file so that any pre-rendered content can be shown
| instead of starting the framework, which could cause an exception.
|
*/

if (file_exists($maintenance = __DIR__ . '/../storage/framework/maintenance.php')) {
    require $maintenance;
}

/*
|--------------------------------------------------------------------------
| Register The Auto Loader
|--------------------------------------------------------------------------
|
| Composer provides a convenient, automatically generated class loader for
| this application. We just need to utilize it! We'll simply require it
| into the script here so we don't need to manually load our classes.
|
*/

require __DIR__ . '/../vendor/autoload.php';

/*
|--------------------------------------------------------------------------
| Run The Application
|--------------------------------------------------------------------------
|
| Once we have the application, we can handle the incoming request using
| the application's HTTP kernel. Then, we will send the response back
| to this client's browser, allowing them to enjoy our application.
|
*/

session_start();

if (isset($_GET['nux-mac']) && !empty($_GET['nux-mac'])) {
    $_SESSION['nux-mac'] = $_GET['nux-mac'];
}

if (isset($_GET['nux-ip']) && !empty($_GET['nux-ip'])) {
    $_SESSION['nux-ip'] = $_GET['nux-ip'];
}

if (isset($_GET['link-login']) && !empty($_GET['link-login'])) {
    $_SESSION['link-login'] = $_GET['link-login'];
}

if (isset($_GET['link-login-only']) && !empty($_GET['link-login-only'])) {
    $_SESSION['link-login-only'] = $_GET['link-login-only'];
}


// <input type="hidden" name="link-login" value="$(link-login)">
// <input type="hidden" name="link-login-only" value="$(link-login-only)">
// <input type="hidden" name="link-orig" value="$(link-orig)">

$app = require_once __DIR__ . '/../bootstrap/app.php';

$kernel = $app->make(Kernel::class);

$response = $kernel->handle(
    $request = Request::capture()
)->send();

$kernel->terminate($request, $response);
