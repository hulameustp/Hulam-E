<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class CorsMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        // Determine origin (for dynamic allow when not using credentials)
        $origin = $request->headers->get('Origin', '*');

        // If this is a preflight request, return immediately with the CORS headers
        if ($request->getMethod() === 'OPTIONS') {
            $preflight = response('', 204);
            $preflight->headers->set('Access-Control-Allow-Origin', '*');
            $preflight->headers->set('Access-Control-Allow-Methods', 'GET, POST, PUT, PATCH, DELETE, OPTIONS');
            $preflight->headers->set('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Requested-With, Accept, Origin');
            $preflight->headers->set('Access-Control-Expose-Headers', 'Content-Length, Content-Range');
            // Do NOT set Access-Control-Allow-Credentials unless it is true
            // Add Vary to ensure caches respect per-origin responses
            $preflight->headers->set('Vary', 'Origin');
            return $preflight;
        }

        $response = $next($request);

        $response->headers->set('Access-Control-Allow-Origin', '*');
        $response->headers->set('Access-Control-Allow-Methods', 'GET, POST, PUT, PATCH, DELETE, OPTIONS');
        $response->headers->set('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Requested-With, Accept, Origin');
        $response->headers->set('Access-Control-Expose-Headers', 'Content-Length, Content-Range');
        // Do NOT set Access-Control-Allow-Credentials when false; omit the header entirely
        $response->headers->set('Vary', 'Origin');

        return $response;
    }
}
