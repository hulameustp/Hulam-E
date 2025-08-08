# Deployment Quick Reference

## Railway (Backend) Environment Variables

```env
APP_NAME=Hulam-E
APP_ENV=production
APP_KEY=base64:your-generated-key
APP_DEBUG=false
APP_URL=https://your-app-name.up.railway.app

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

CORS_ALLOWED_ORIGINS=https://hulam-e.vercel.app,https://*.vercel.app,https://*.railway.app

FILESYSTEM_DISK=public
LOG_CHANNEL=stack
LOG_LEVEL=error
CACHE_DRIVER=file
QUEUE_CONNECTION=sync

SANCTUM_STATEFUL_DOMAINS=hulam-e.vercel.app,*.vercel.app,*.railway.app
```

## Vercel (Frontend) Environment Variables

```env
REACT_APP_API_URL=https://your-railway-app-name.up.railway.app/api
REACT_APP_NAME=Hulam-E
REACT_APP_VERSION=1.0.0
REACT_APP_ENABLE_DEBUG=false
```

## Railway Commands

```bash
# Generate app key
php artisan key:generate

# Run migrations
php artisan migrate --force

# Create storage link
php artisan storage:link

# Seed admin user
php artisan db:seed --class=AdminUserSeeder

# Clear cache
php artisan config:clear
php artisan cache:clear
php artisan route:clear
```

## Build Commands

### Railway Build Command
```bash
composer install --no-dev --optimize-autoloader
```

### Railway Start Command
```bash
php artisan serve --host 0.0.0.0 --port $PORT
```

### Vercel Build Command
```bash
npm run build
```

## Important URLs

- **Frontend**: `https://hulam-e.vercel.app`
- **Backend**: `https://your-railway-app-name.up.railway.app`
- **API Base**: `https://your-railway-app-name.up.railway.app/api`

## CORS Configuration

The CORS configuration in `back/config/cors.php` should include:

```php
'allowed_origins' => [
    'http://localhost:3000', 
    'http://localhost:3001', 
    'https://hulam-e.vercel.app',
    'https://*.vercel.app',
    'https://hulame-backend.up.railway.app'
],
'allowed_origins_patterns' => [
    'https://*.vercel.app',
    'https://*.railway.app'
],
```

## Database Setup

1. Add MySQL database in Railway
2. Railway will auto-generate database environment variables
3. Run migrations: `php artisan migrate --force`
4. Seed admin user: `php artisan db:seed --class=AdminUserSeeder`

## Troubleshooting Commands

```bash
# Check Railway logs
railway logs

# Check Vercel deployment
vercel logs

# Test API endpoint
curl https://your-railway-app-name.up.railway.app/api/test

# Check CORS headers
curl -H "Origin: https://hulam-e.vercel.app" \
     -H "Access-Control-Request-Method: POST" \
     -H "Access-Control-Request-Headers: Content-Type" \
     -X OPTIONS \
     https://your-railway-app-name.up.railway.app/api/auth/register
```
