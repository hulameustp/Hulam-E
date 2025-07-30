# Deployment Guide for Hulame Project

## Overview
This guide will help you deploy your Hulame project with:
- **Frontend (React)**: Deployed on Vercel
- **Backend (Laravel)**: Deployed on Railway
- **Database**: MySQL on Railway

## Prerequisites
- GitHub account
- Vercel account
- Railway account
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

## Step 2: Deploy Backend on Railway

### 2.1 Create Railway Account
1. Go to [Railway.app](https://railway.app)
2. Sign up with your GitHub account

### 2.2 Create New Project
1. In Railway dashboard, click "Start a New Project"
2. Select "Deploy from GitHub repo"
3. Connect your GitHub repository
4. Name your project: `hulame-backend`

### 2.3 Add Database Service
1. In your Railway project, click "New Service"
2. Select "Database" → "MySQL"
3. This will automatically create a MySQL database
4. Note down the database credentials from the "Variables" tab

### 2.4 Configure Backend Service
1. In your Railway project, click "New Service"
2. Select "GitHub Repo"
3. Connect your repository
4. Set the **Root Directory** to `back`
5. Railway will automatically detect it's a PHP/Laravel app

### 2.5 Set Environment Variables
In your Railway backend service, go to "Variables" and add:

```
APP_NAME=Hulame
APP_ENV=production
APP_KEY=base64:2uGMbwjzgq2B/Lu7zyc1SxpF/8cDZl1l/6D10pyXF60=
APP_DEBUG=false
APP_URL=https://your-service-name.railway.app

DB_CONNECTION=mysql
DB_HOST=${MYSQLHOST}
DB_PORT=${MYSQLPORT}
DB_DATABASE=${MYSQLDATABASE}
DB_USERNAME=${MYSQLUSER}
DB_PASSWORD=${MYSQLPASSWORD}

CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_DRIVER=sync
```

**Note**: Railway automatically provides database environment variables, so you can use the `${VARIABLE}` syntax.

### 2.6 Deploy and Test
1. Railway will automatically deploy your service
2. Once deployed, note your service URL: `https://your-service-name.railway.app`
3. Test the API by visiting: `https://your-service-name.railway.app/api`

### 2.7 Run Database Migrations
1. In Railway dashboard, go to your backend service
2. Click "Deployments" → "Latest Deployment"
3. Click "View Logs" and then "Open Shell"
4. Run these commands:
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
REACT_APP_API_URL=https://your-service-name.railway.app/api
REACT_APP_ENV=production
```

**Replace `your-service-name`** with your actual Railway service name.

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
Visit: `https://your-service-name.railway.app/api/health` (or any test endpoint)

### 5.2 Test Frontend
Visit your Vercel frontend URL and ensure it can communicate with the backend.

## Step 6: Update URLs

### 6.1 Update Frontend API URL
Once you have your actual Railway service URL, update the `REACT_APP_API_URL` in Vercel.

### 6.2 Update Backend APP_URL
Update the `APP_URL` in your Railway backend environment variables.

## Troubleshooting

### Common Issues:

1. **Database Connection Failed**
   - Check database credentials in Railway
   - Ensure database service is created and connected

2. **CORS Errors**
   - Update CORS configuration in Laravel
   - Check allowed origins

3. **Build Failures**
   - Check build logs in Vercel/Railway
   - Ensure all dependencies are installed

4. **Environment Variables**
   - Double-check all environment variables are set correctly
   - Restart services after updating variables

## Final URLs

After deployment, you should have:
- **Frontend**: `https://your-app.vercel.app`
- **Backend**: `https://your-service-name.railway.app`
- **API**: `https://your-service-name.railway.app/api`

## Support

If you encounter issues:
1. Check the deployment logs in Vercel/Railway
2. Verify environment variables are set correctly
3. Test API endpoints individually
4. Check CORS configuration

---

**Remember**: Never commit sensitive information like API keys or database passwords to your repository. Always use environment variables for production deployments. 