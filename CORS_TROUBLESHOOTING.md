# CORS Troubleshooting Guide

## Current CORS Configuration

### Backend (Laravel) Configuration

**File: `back/config/cors.php`**
```php
<?php

return [
    'paths' => ['api/*', 'sanctum/csrf-cookie', 'storage/*'],
    'allowed_methods' => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    'allowed_origins' => ['*'],
    'allowed_origins_patterns' => [],
    'allowed_headers' => ['*'],
    'exposed_headers' => ['*'],
    'max_age' => 86400,
    'supports_credentials' => false,
];
```

**File: `back/app/Http/Middleware/CorsMiddleware.php`**
```php
<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class CorsMiddleware
{
    public function handle(Request $request, Closure $next)
    {
        $response = $next($request);

        $response->headers->set('Access-Control-Allow-Origin', '*');
        $response->headers->set('Access-Control-Allow-Methods', 'GET, POST, PUT, PATCH, DELETE, OPTIONS');
        $response->headers->set('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Requested-With, Accept, Origin');
        $response->headers->set('Access-Control-Expose-Headers', 'Content-Length, Content-Range');
        $response->headers->set('Access-Control-Allow-Credentials', 'false');

        return $response;
    }
}
```

### Frontend (React) Configuration

**File: `front/src/services/api.js`**
```javascript
const api = axios.create({
  baseURL: process.env.REACT_APP_API_URL || 'https://hulame-backend.up.railway.app/api',
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
  withCredentials: false,
  timeout: 10000,
});
```

## Deployment Steps

### 1. Railway Backend Deployment

1. **Set Environment Variables:**
   ```env
   APP_NAME=Hulam-E
   APP_ENV=production
   APP_KEY=base64:your-generated-key
   APP_DEBUG=false
   APP_URL=https://your-railway-app-name.up.railway.app
   
   DB_CONNECTION=mysql
   DB_HOST=${MYSQLHOST}
   DB_PORT=${MYSQLPORT}
   DB_DATABASE=${MYSQLDATABASE}
   DB_USERNAME=${MYSQLUSER}
   DB_PASSWORD=${MYSQLPASSWORD}
   
   MAIL_MAILER=log
   MAIL_HOST=localhost
   MAIL_PORT=1025
   MAIL_USERNAME=null
   MAIL_PASSWORD=null
   MAIL_ENCRYPTION=null
   MAIL_FROM_ADDRESS=noreply@hulam-e.com
   MAIL_FROM_NAME="Hulam-E"
   
   SESSION_DRIVER=file
   SESSION_LIFETIME=120
   SESSION_DOMAIN=.railway.app
   
   CORS_ALLOWED_ORIGINS=*
   CORS_ALLOWED_METHODS=GET,POST,PUT,PATCH,DELETE,OPTIONS
   CORS_ALLOWED_HEADERS=*
   CORS_EXPOSED_HEADERS=*
   CORS_SUPPORTS_CREDENTIALS=false
   
   FILESYSTEM_DISK=public
   LOG_CHANNEL=stack
   LOG_LEVEL=error
   CACHE_DRIVER=file
   QUEUE_CONNECTION=sync
   
   SANCTUM_STATEFUL_DOMAINS=*
   ```

2. **Run Commands:**
   ```bash
   php artisan key:generate
   php artisan migrate --force
   php artisan storage:link
   php artisan config:clear
   php artisan cache:clear
   php artisan route:clear
   ```

### 2. Vercel Frontend Deployment

1. **Set Environment Variables:**
   ```env
   REACT_APP_API_URL=https://your-railway-app-name.up.railway.app/api
   REACT_APP_NAME=Hulam-E
   REACT_APP_VERSION=1.0.0
   REACT_APP_ENABLE_DEBUG=false
   ```

## Testing CORS Configuration

### 1. Test Backend CORS

```bash
# Test OPTIONS request (preflight)
curl -X OPTIONS \
  -H "Origin: https://hulam-e.vercel.app" \
  -H "Access-Control-Request-Method: POST" \
  -H "Access-Control-Request-Headers: Content-Type" \
  https://your-railway-app-name.up.railway.app/api/cors-test

# Test POST request
curl -X POST \
  -H "Origin: https://hulam-e.vercel.app" \
  -H "Content-Type: application/json" \
  -d '{"test": "data"}' \
  https://your-railway-app-name.up.railway.app/api/cors-test
```

### 2. Test Registration Endpoint

```bash
# Test registration endpoint
curl -X POST \
  -H "Origin: https://hulam-e.vercel.app" \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com","password":"password123","password_confirmation":"password123"}' \
  https://your-railway-app-name.up.railway.app/api/auth/register
```

## Common Issues and Solutions

### Issue 1: "No 'Access-Control-Allow-Origin' header is present"

**Solution:**
1. Ensure the CORS middleware is properly registered in `Kernel.php`
2. Check that the custom `CorsMiddleware` is in the global middleware stack
3. Verify the CORS configuration in `config/cors.php`

### Issue 2: Preflight requests failing

**Solution:**
1. Add explicit OPTIONS route handling
2. Ensure all required CORS headers are set
3. Check that the middleware is applied to all API routes

### Issue 3: Credentials not working

**Solution:**
1. Set `supports_credentials` to `false` in CORS config
2. Set `withCredentials` to `false` in axios config
3. Use `*` for allowed origins instead of specific domains

### Issue 4: Railway deployment issues

**Solution:**
1. Check Railway logs for deployment errors
2. Ensure all environment variables are set correctly
3. Verify the build and start commands are correct

## Debugging Steps

### 1. Check Railway Logs

In Railway dashboard:
1. Go to your project
2. Click on the latest deployment
3. Check the "Logs" tab for errors

### 2. Test API Endpoints

```bash
# Test basic API functionality
curl https://your-railway-app-name.up.railway.app/api/test

# Test CORS headers
curl -I -X OPTIONS \
  -H "Origin: https://hulam-e.vercel.app" \
  https://your-railway-app-name.up.railway.app/api/auth/register
```

### 3. Browser Developer Tools

1. Open browser developer tools
2. Go to Network tab
3. Try to register a user
4. Check the request/response headers
5. Look for CORS-related errors in the console

### 4. Verify Environment Variables

Ensure all environment variables are set correctly in both Railway and Vercel.

## Final Checklist

- [ ] CORS middleware is registered in `Kernel.php`
- [ ] Custom `CorsMiddleware` is in global middleware stack
- [ ] CORS configuration allows all origins (`*`)
- [ ] Frontend axios config has `withCredentials: false`
- [ ] All environment variables are set correctly
- [ ] Railway deployment is successful
- [ ] Vercel deployment is successful
- [ ] API endpoints are accessible
- [ ] CORS headers are present in responses

## Emergency Fallback

If CORS issues persist, you can temporarily disable CORS checks by:

1. Adding this to your Laravel routes:
```php
Route::group(['middleware' => 'cors'], function () {
    // All your API routes
});
```

2. Or by adding this to your `public/index.php`:
```php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, Accept, Origin');
```

**Note:** This is not recommended for production but can help debug the issue.
