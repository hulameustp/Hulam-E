# Railway Deployment Guide

This guide will help you deploy the Hulam-E project (frontend, backend, and database) to Railway.

## Prerequisites

1. Create a Railway account at [railway.app](https://railway.app)
2. Install Railway CLI: `npm install -g @railway/cli`
3. Login to Railway: `railway login`

## Step 1: Create Railway Project

```bash
railway new hulam-e
cd hulam-e
```

## Step 2: Deploy MySQL Database

1. In Railway dashboard, click "Add Service" → "Database" → "MySQL"
2. Note the connection details (they will be auto-generated)
3. The database URL will be available as `DATABASE_URL` environment variable

## Step 3: Deploy Backend (Laravel API)

```bash
# Navigate to backend directory
cd back

# Initialize Railway in backend directory
railway init

# Set environment variables for backend
railway variables set APP_ENV=production
railway variables set APP_DEBUG=false
railway variables set APP_KEY=base64:your-app-key-here
railway variables set CACHE_DRIVER=file
railway variables set SESSION_DRIVER=file
railway variables set QUEUE_DRIVER=sync

# Database variables (Railway will auto-inject these if using Railway MySQL)
railway variables set DB_CONNECTION=mysql
railway variables set DB_HOST=${{MySQL.MYSQL_HOST}}
railway variables set DB_PORT=${{MySQL.MYSQL_PORT}}
railway variables set DB_DATABASE=${{MySQL.MYSQL_DATABASE}}
railway variables set DB_USERNAME=${{MySQL.MYSQL_USER}}
railway variables set DB_PASSWORD=${{MySQL.MYSQL_PASSWORD}}

# Deploy backend
railway up
```

## Step 4: Deploy Frontend (React)

```bash
# Navigate to frontend directory
cd ../front

# Initialize Railway in frontend directory
railway init

# Set the backend API URL (replace with your actual backend URL)
railway variables set REACT_APP_API_URL=https://your-backend-url.up.railway.app/api

# Deploy frontend
railway up
```

## Step 5: Run Database Migrations

After both services are deployed:

```bash
# Connect to your backend service
railway connect

# Run Laravel commands
php artisan migrate --force
php artisan db:seed --force
```

## Environment Variables Summary

### Backend Variables:
- `APP_ENV=production`
- `APP_DEBUG=false`
- `APP_KEY=` (generate with `php artisan key:generate --show`)
- `DB_CONNECTION=mysql`
- `DB_HOST=${{MySQL.MYSQL_HOST}}`
- `DB_PORT=${{MySQL.MYSQL_PORT}}`
- `DB_DATABASE=${{MySQL.MYSQL_DATABASE}}`
- `DB_USERNAME=${{MySQL.MYSQL_USER}}`
- `DB_PASSWORD=${{MySQL.MYSQL_PASSWORD}}`

### Frontend Variables:
- `REACT_APP_API_URL=https://your-backend-url.up.railway.app/api`

## Custom Domains (Optional)

1. Go to your service settings in Railway dashboard
2. Navigate to "Domains" tab
3. Add custom domain or use the generated Railway domain

## Database Setup

The MySQL database will be automatically provisioned by Railway. The connection details will be injected as environment variables into your backend service.

## Troubleshooting

1. **Backend not starting**: Check logs in Railway dashboard
2. **Database connection issues**: Verify environment variables are set correctly
3. **CORS issues**: The backend is already configured for CORS
4. **Frontend not loading**: Check if `REACT_APP_API_URL` is set correctly

## Monitoring

- Use Railway dashboard to monitor logs, metrics, and resource usage
- Set up alerts for service downtime or high resource usage
