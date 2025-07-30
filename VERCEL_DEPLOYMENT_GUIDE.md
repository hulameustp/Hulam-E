# 🚀 Vercel + Railway Deployment Guide

## Overview
This guide will help you deploy your Hulame project with:
- **Frontend (React)**: Deployed on Vercel
- **Backend (Laravel)**: Deployed on Vercel
- **Database**: MySQL on Railway

## Prerequisites
- GitHub account
- Vercel account
- Railway account
- Git installed locally

## Step 1: Prepare Your Code

### 1.1 Update Environment Variables
Update your backend `.env` file for Vercel deployment:

```env
APP_NAME=Hulame
APP_ENV=production
APP_KEY=base64:2uGMbwjzgq2B/Lu7zyc1SxpF/8cDZl1l/6D10pyXF60=
APP_DEBUG=false
APP_URL=https://your-backend-domain.vercel.app

DB_CONNECTION=mysql
DB_HOST=your-railway-mysql-host
DB_PORT=3306
DB_DATABASE=your-railway-database-name
DB_USERNAME=your-railway-username
DB_PASSWORD=your-railway-password

CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_DRIVER=sync
```

### 1.2 Update Frontend Environment
Update your frontend `.env` file:

```env
REACT_APP_API_URL=https://your-backend-domain.vercel.app/api
REACT_APP_ENV=production
```

## Step 2: Set Up Railway MySQL Database

### 2.1 Create Railway Account
1. Go to [Railway.app](https://railway.app)
2. Sign up with your GitHub account

### 2.2 Create MySQL Database
1. In Railway dashboard, click "Start a New Project"
2. Select "Database" → "MySQL"
3. This will create a MySQL database service
4. Note down the database credentials from the "Variables" tab

### 2.3 Get Database Credentials
From Railway dashboard, copy these values:
- `MYSQLHOST`
- `MYSQLPORT`
- `MYSQLDATABASE`
- `MYSQLUSER`
- `MYSQLPASSWORD`

## Step 3: Deploy Backend on Vercel

### 3.1 Create Vercel Account
1. Go to [Vercel.com](https://vercel.com)
2. Sign up with your GitHub account

### 3.2 Deploy Backend
1. In Vercel dashboard, click "New Project"
2. Import your GitHub repository: `hulameustp/Hulam-E`
3. Configure the project:
   - **Framework Preset**: Other
   - **Root Directory**: `back`
   - **Build Command**: Leave empty (Vercel will auto-detect)
   - **Output Directory**: Leave empty

### 3.3 Set Environment Variables
In your Vercel backend project settings, add:

```
APP_NAME=Hulame
APP_ENV=production
APP_KEY=base64:2uGMbwjzgq2B/Lu7zyc1SxpF/8cDZl1l/6D10pyXF60=
APP_DEBUG=false
APP_URL=https://your-backend-domain.vercel.app

DB_CONNECTION=mysql
DB_HOST=your-railway-mysql-host
DB_PORT=3306
DB_DATABASE=your-railway-database-name
DB_USERNAME=your-railway-username
DB_PASSWORD=your-railway-password

CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_DRIVER=sync
```

**Replace the database values** with your actual Railway MySQL credentials.

## Step 4: Deploy Frontend on Vercel

### 4.1 Deploy Frontend
1. In Vercel dashboard, click "New Project"
2. Import your GitHub repository: `hulameustp/Hulam-E`
3. Configure the project:
   - **Framework Preset**: Create React App
   - **Root Directory**: `front`
   - **Build Command**: `npm run build`
   - **Output Directory**: `build`

### 4.2 Set Environment Variables
In your Vercel frontend project settings, add:
```
REACT_APP_API_URL=https://your-backend-domain.vercel.app/api
REACT_APP_ENV=production
```

**Replace `your-backend-domain`** with your actual Vercel backend domain.

## Step 5: Run Database Migrations

### 5.1 Using Vercel CLI
1. Install Vercel CLI: `npm i -g vercel`
2. Login: `vercel login`
3. Navigate to backend: `cd back`
4. Link project: `vercel link`
5. Run migrations: `vercel env pull .env.local && php artisan migrate --force`

### 5.2 Using Railway Shell
1. In Railway dashboard, go to your MySQL service
2. Click "Connect" → "MySQL Shell"
3. Run your migration SQL manually

## Step 6: Update CORS Configuration

Update your Laravel CORS configuration to allow your Vercel frontend domain:

```php
// config/cors.php
'allowed_origins' => [
    'http://localhost:3000', 
    'http://localhost:3001', 
    'https://*.vercel.app'
],
```

## Step 7: Test Your Deployment

### 7.1 Test Backend API
Visit: `https://your-backend-domain.vercel.app/api`

### 7.2 Test Frontend
Visit your Vercel frontend URL and ensure it can communicate with the backend.

## Final URLs

After deployment, you should have:
- **Frontend**: `https://your-frontend-app.vercel.app`
- **Backend**: `https://your-backend-app.vercel.app`
- **API**: `https://your-backend-app.vercel.app/api`
- **Database**: Railway MySQL (managed)

## Troubleshooting

### Common Issues:

1. **Database Connection Failed**
   - Check database credentials in Vercel environment variables
   - Ensure Railway MySQL service is running

2. **CORS Errors**
   - Update CORS configuration in Laravel
   - Check allowed origins

3. **Build Failures**
   - Check build logs in Vercel
   - Ensure all dependencies are installed

4. **Environment Variables**
   - Double-check all environment variables are set correctly
   - Redeploy after updating variables

## Benefits of This Approach

✅ **Cost Effective**: Only pay for Railway MySQL database
✅ **Simplified**: Both frontend and backend on Vercel
✅ **Better Performance**: Vercel's global CDN
✅ **Easier Management**: Single platform for both apps
✅ **Automatic Scaling**: Vercel handles scaling automatically

---

**Remember**: Never commit sensitive information like API keys or database passwords to your repository. Always use environment variables for production deployments. 