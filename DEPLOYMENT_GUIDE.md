# Deployment Guide for Hulame Project

## Overview
This guide will help you deploy your Hulame project with:
- **Frontend (React)**: Deployed on Vercel
- **Backend (Laravel)**: Deployed on Render
- **Database**: MySQL on Render

## Prerequisites
- GitHub account
- Vercel account
- Render account
- Git installed locally

## Step 1: Prepare Your Code

### 1.1 Initialize Git Repositories
```bash
# For Backend
cd back
git init
git add .
git commit -m "Initial backend commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/hulame-backend.git
git push -u origin main

# For Frontend
cd ../front
git init
git add .
git commit -m "Initial frontend commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/hulame-frontend.git
git push -u origin main
```

## Step 2: Deploy Backend on Render

### 2.1 Create Render Account
1. Go to [Render.com](https://render.com)
2. Sign up with your GitHub account

### 2.2 Create Database
1. In Render dashboard, click "New +"
2. Select "PostgreSQL" or "MySQL"
3. Choose "Free" plan
4. Name it: `hulame-database`
5. Note down the database credentials:
   - Host
   - Database name
   - Username
   - Password
   - Port

### 2.3 Deploy Backend Service
1. In Render dashboard, click "New +"
2. Select "Web Service"
3. Connect your GitHub repository
4. Configure the service:
   - **Name**: `hulam-backend`
   - **Root Directory**: `back` (if your repo contains both frontend and backend)
   - **Environment**: `PHP`
   - **Build Command**: `composer install --no-dev --optimize-autoloader`
   - **Start Command**: `php artisan serve --host 0.0.0.0 --port 10000`

### 2.4 Set Environment Variables
In your Render backend service, go to "Environment" and add these variables:

```
APP_NAME=Hulame
APP_ENV=production
APP_KEY=base64:2uGMbwjzgq2B/Lu7zyc1SxpF/8cDZl1l/6D10pyXF60=
APP_DEBUG=false
APP_URL=https://hulam-backend.onrender.com

DB_CONNECTION=mysql
DB_HOST=<your-render-db-host>
DB_PORT=3306
DB_DATABASE=<your-render-db-name>
DB_USERNAME=<your-render-db-username>
DB_PASSWORD=<your-render-db-password>

CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_DRIVER=sync
```

**Replace the database placeholders** with your actual Render database credentials.

### 2.5 Run Database Migrations
After deployment, in Render dashboard:
1. Go to your backend service
2. Click "Shell"
3. Run these commands:
```bash
php artisan migrate --force
php artisan db:seed --force
php artisan config:cache
```

## Step 3: Deploy Frontend on Vercel

### 3.1 Create Vercel Account
1. Go to [Vercel.com](https://vercel.com)
2. Sign up with your GitHub account

### 3.2 Deploy Frontend
1. In Vercel dashboard, click "New Project"
2. Import your GitHub repository
3. Configure the project:
   - **Framework Preset**: Create React App
   - **Root Directory**: `front` (if your repo contains both)
   - **Build Command**: `npm run build`
   - **Output Directory**: `build`

### 3.3 Set Environment Variables
In your Vercel project settings, add:
```
REACT_APP_API_URL=https://hulam-backend.onrender.com/api
REACT_APP_ENV=production
```

**Replace `hulam-backend`** with your actual Render backend service name.

## Step 4: Configure CORS

### 4.1 Update Laravel CORS Configuration
In your Laravel backend, ensure CORS is configured to allow your Vercel domain:

```php
// config/cors.php
return [
    'paths' => ['api/*'],
    'allowed_methods' => ['*'],
    'allowed_origins' => ['https://your-frontend-domain.vercel.app'],
    'allowed_origins_patterns' => [],
    'allowed_headers' => ['*'],
    'exposed_headers' => [],
    'max_age' => 0,
    'supports_credentials' => false,
];
```

## Step 5: Test Your Deployment

### 5.1 Test Backend API
Visit: `https://hulam-backend.onrender.com/api/health` (or any test endpoint)

### 5.2 Test Frontend
Visit your Vercel frontend URL and ensure it can communicate with the backend.

## Step 6: Update URLs

### 6.1 Update Frontend API URL
Once you have your actual backend URL, update the `REACT_APP_API_URL` in Vercel.

### 6.2 Update Backend APP_URL
Update the `APP_URL` in your Render backend environment variables.

## Troubleshooting

### Common Issues:

1. **Database Connection Failed**
   - Check database credentials in Render
   - Ensure database is created and accessible

2. **CORS Errors**
   - Update CORS configuration in Laravel
   - Check allowed origins

3. **Build Failures**
   - Check build logs in Vercel/Render
   - Ensure all dependencies are installed

4. **Environment Variables**
   - Double-check all environment variables are set correctly
   - Restart services after updating variables

## Final URLs

After deployment, you should have:
- **Frontend**: `https://your-app.vercel.app`
- **Backend**: `https://hulam-backend.onrender.com`
- **API**: `https://hulam-backend.onrender.com/api`

## Support

If you encounter issues:
1. Check the deployment logs in Vercel/Render
2. Verify environment variables are set correctly
3. Test API endpoints individually
4. Check CORS configuration

---

**Remember**: Never commit sensitive information like API keys or database passwords to your repository. Always use environment variables for production deployments. 