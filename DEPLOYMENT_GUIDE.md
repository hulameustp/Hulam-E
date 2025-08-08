# Hulam-E Deployment Guide

This guide provides step-by-step instructions for deploying both the frontend (Vercel) and backend (Railway) components of the Hulam-E application.

## Prerequisites

- GitHub account
- Vercel account (free tier available)
- Railway account (free tier available)
- MySQL database (Railway provides this)

## Backend Deployment (Railway)

### Step 1: Prepare Railway Project

1. Go to [Railway.app](https://railway.app) and sign in with GitHub
2. Click "New Project" → "Deploy from GitHub repo"
3. Select your repository
4. Set the root directory to `back/`

### Step 2: Configure Environment Variables

In your Railway project dashboard, go to the "Variables" tab and add these environment variables:

```env
# Application Configuration
APP_NAME=Hulam-E
APP_ENV=production
APP_KEY=base64:your-generated-app-key
APP_DEBUG=false
APP_URL=https://your-railway-app-name.up.railway.app

# Database Configuration (Railway will auto-generate these)
DB_CONNECTION=mysql
DB_HOST=${MYSQLHOST}
DB_PORT=${MYSQLPORT}
DB_DATABASE=${MYSQLDATABASE}
DB_USERNAME=${MYSQLUSER}
DB_PASSWORD=${MYSQLPASSWORD}

# Mail Configuration (optional for now)
MAIL_MAILER=log
MAIL_HOST=localhost
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS=noreply@hulam-e.com
MAIL_FROM_NAME="Hulam-E"

# Session Configuration
SESSION_DRIVER=file
SESSION_LIFETIME=120
SESSION_DOMAIN=.railway.app

# CORS Configuration
CORS_ALLOWED_ORIGINS=https://hulam-e.vercel.app,https://*.vercel.app,https://*.railway.app

# File Storage
FILESYSTEM_DISK=public

# Logging
LOG_CHANNEL=stack
LOG_LEVEL=error

# Cache
CACHE_DRIVER=file

# Queue
QUEUE_CONNECTION=sync

# Sanctum Configuration
SANCTUM_STATEFUL_DOMAINS=hulam-e.vercel.app,*.vercel.app,*.railway.app
SESSION_DOMAIN=.railway.app
```

### Step 3: Add MySQL Database

1. In your Railway project, click "New" → "Database" → "MySQL"
2. Railway will automatically add the database environment variables
3. The database will be automatically linked to your application

### Step 4: Generate App Key

1. In your Railway project, go to the "Deployments" tab
2. Click on the latest deployment
3. Go to the "Logs" tab
4. Run this command in the terminal:
   ```bash
   php artisan key:generate
   ```
5. Copy the generated key and update the `APP_KEY` variable in your environment variables

### Step 5: Run Migrations

In the Railway terminal, run:
```bash
php artisan migrate --force
```

### Step 6: Create Storage Link

```bash
php artisan storage:link
```

### Step 7: Set Build Command

In your Railway project settings, set the build command to:
```bash
composer install --no-dev --optimize-autoloader
```

### Step 8: Set Start Command

Set the start command to:
```bash
php artisan serve --host 0.0.0.0 --port $PORT
```

## Frontend Deployment (Vercel)

### Step 1: Prepare Vercel Project

1. Go to [Vercel.com](https://vercel.com) and sign in with GitHub
2. Click "New Project"
3. Import your GitHub repository
4. Set the root directory to `front/`
5. Set the build command to: `npm run build`
6. Set the output directory to: `build`

### Step 2: Configure Environment Variables

In your Vercel project settings, go to "Environment Variables" and add:

```env
REACT_APP_API_URL=https://your-railway-app-name.up.railway.app/api
REACT_APP_NAME=Hulam-E
REACT_APP_VERSION=1.0.0
REACT_APP_ENABLE_DEBUG=false
```

### Step 3: Configure Domain

1. In your Vercel project settings, go to "Domains"
2. Add your custom domain or use the provided Vercel domain
3. Update the `REACT_APP_API_URL` to match your Railway backend URL

## Post-Deployment Configuration

### Step 1: Update CORS Settings

After both deployments are complete, update your Railway backend's CORS configuration to include your Vercel domain:

1. Go to your Railway project
2. Update the `CORS_ALLOWED_ORIGINS` environment variable to include your Vercel domain
3. Redeploy the backend

### Step 2: Test the Connection

1. Visit your Vercel frontend
2. Try to register a new user
3. Check the browser console for any CORS errors
4. If errors persist, check the Railway logs for backend issues

### Step 3: Create Admin User

In your Railway terminal, run:
```bash
php artisan db:seed --class=AdminUserSeeder
```

## Troubleshooting

### CORS Issues

If you're still getting CORS errors:

1. Check that your Railway domain is correctly added to the CORS allowed origins
2. Ensure the frontend is using the correct backend URL
3. Clear browser cache and try again
4. Check Railway logs for any backend errors

### Database Connection Issues

1. Verify all database environment variables are set correctly
2. Check that the MySQL database is running in Railway
3. Ensure migrations have been run successfully

### Build Issues

1. Check that all dependencies are properly installed
2. Verify the build commands are correct
3. Check the deployment logs for specific error messages

## Monitoring

### Railway Monitoring

- Check the "Deployments" tab for deployment status
- Monitor the "Logs" tab for runtime errors
- Use the "Metrics" tab to monitor performance

### Vercel Monitoring

- Check the "Deployments" tab for build status
- Monitor the "Functions" tab for serverless function logs
- Use the "Analytics" tab to monitor traffic

## Security Considerations

1. Never commit sensitive environment variables to your repository
2. Use strong, unique passwords for your database
3. Regularly update your dependencies
4. Monitor your application logs for suspicious activity
5. Consider implementing rate limiting for your API endpoints

## Cost Optimization

### Railway

- Use the free tier for development
- Monitor your usage in the "Usage" tab
- Consider upgrading only when necessary

### Vercel

- The free tier includes generous limits
- Monitor your usage in the "Usage" tab
- Consider upgrading for custom domains or increased limits

## Support

If you encounter issues:

1. Check the deployment logs in both Railway and Vercel
2. Review the troubleshooting section above
3. Check the application logs for specific error messages
4. Consider reaching out to the platform support teams
