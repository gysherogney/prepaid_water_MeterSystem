<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class IpAndMac
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {

        if (auth()->check()) {
            $user = auth()->user();
            if (isset($_SESSION['nux-mac']) && isset($_SESSION['nux-ip']) && $user->mac != $_SESSION['nux-mac'] && $user->ip != $_SESSION['nux-ip'])
                $data = [
                    'ip' => $_SESSION['nux-ip'],
                    'mac' => $_SESSION['nux-mac']
                ];

            $user->update(
                $data
            );
        }

        return $next($request);
    }
}
