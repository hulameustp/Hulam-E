# 🚀 Railway Deployment Guide - Hulame Rental Project

This guide will help you deploy your Laravel backend and React frontend to Railway.

## 📋 Prerequisites

1. **Railway Account**: Sign up at [railway.app](https://railway.app)
2. **GitHub Repository**: Your code should be pushed to GitHub
3. **Environment Ready**: Both `back/` and `front/` folders have their Dockerfiles

## 🏗️ Architecture Overview

- **Backend**: Laravel 12 + PHP 8.2 + MySQL (Railway Database)
- **Frontend**: React 19 + Nginx 
- **Database**: Railway MySQL Plugin
- **File Storage**: Laravel local storage (can be upgraded to S3)

## 📂 Project Structure

```
hulame/
├── back/           # Laravel Backend
│   ├── Dockerfile
│   └── railway.json
├── front/          # React Frontend  
│   ├── Dockerfile
│   ├── nginx.conf
│   └── .env
└── RAILWAY_DEPLOYMENT_GUIDE.md
```

## 🚀 Deployment Steps

### Step 1: Prepare Your Repository

1. **Commit all the deployment files we just created:**
   ```bash
   git add .
   git commit -m "Add Railway deployment configuration"
   git push origin main
   ```

### Step 2: Deploy Backend (Laravel)

1. **Go to Railway Dashboard**:
   - Visit [railway.app](https://railway.app)
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose your repository

2. **Configure Backend Service**:
   - Railway will detect your repository
   - Click "Add Service" → "GitHub Repo"
   - Set **Root Directory**: `back`
   - Railway will automatically use the Dockerfile

3. **Add MySQL Database**:
   - In your project dashboard, click "New"
   - Select "Database" → "Add MySQL"
   - Railway will provide connection details

4. **Set Environment Variables** (in Railway dashboard):
   ```env
   APP_NAME=HulameRental
   APP_ENV=production
   APP_KEY=base64:YOUR_APP_KEY_HERE
   APP_DEBUG=false
   APP_URL=https://your-backend-domain.railway.app

   DB_CONNECTION=mysql
   DB_HOST=${{MySQL.MYSQL_HOST}}
   DB_PORT=${{MySQL.MYSQL_PORT}}
   DB_DATABASE=${{MySQL.MYSQL_DATABASE}}
   DB_USERNAME=${{MySQL.MYSQL_USER}}
   DB_PASSWORD=${{MySQL.MYSQL_PASSWORD}}

   SESSION_DRIVER=cookie
   CACHE_DRIVER=file
   QUEUE_CONNECTION=sync

   MAIL_MAILER=smtp
   MAIL_HOST=smtp.mailtrap.io
   MAIL_PORT=2525
   MAIL_USERNAME=your_username
   MAIL_PASSWORD=your_password
   MAIL_ENCRYPTION=tls
   ```

5. **Generate APP_KEY**:
   - After first deployment, go to your service
   - Open "Deployments" tab
   - Click on the latest deployment
   - Run: `php artisan key:generate --show`
   - Copy the generated key and update APP_KEY variable

### Step 3: Deploy Frontend (React)

1. **Add Frontend Service**:
   - In your Railway project, click "New"
   - Select "GitHub Repo" 
   - Choose the same repository
   - Set **Root Directory**: `front`

2. **Set Environment Variables**:
   ```env
   REACT_APP_API_URL=https://your-backend-domain.railway.app/api
   REACT_APP_APP_NAME=HulameRental
   ```

   **Important**: Replace `your-backend-domain.railway.app` with your actual backend URL from Step 2.

### Step 4: Configure CORS (Backend)

1. **Update CORS configuration** in your backend:
   - Go to your backend service in Railway
   - Update the environment variables to include:
   ```env
   FRONTEND_URL=https://your-frontend-domain.railway.app
   ```

2. **Update Laravel CORS config** (if needed):
   - Check `back/config/cors.php`
   - Ensure frontend URL is allowed

### Step 5: Domain Configuration

1. **Backend Domain**:
   - Go to your backend service → Settings → Networking
   - Generate domain or add custom domain
   - Copy the domain URL

2. **Frontend Domain**:
   - Go to your frontend service → Settings → Networking  
   - Generate domain or add custom domain
   - Update frontend environment variable `REACT_APP_API_URL`

3. **Update Frontend Environment**:
   - In frontend service environment variables
   - Update `REACT_APP_API_URL` with the real backend URL
   - Redeploy frontend service

## 🔧 Post-Deployment Configuration

### Database Setup

1. **Run Migrations**:
   - Backend service → Deployments → Latest deployment
   - Open terminal and run:
   ```bash
   php artisan migrate --force
   ```

2. **Seed Database** (optional):
   ```bash
   php artisan db:seed --class=AdminUserSeeder
   ```

### File Storage Setup

1. **Storage Link**:
   ```bash
   php artisan storage:link
   ```

2. **Set Storage Permissions**:
   ```bash
   chmod -R 775 storage/
   chmod -R 775 bootstrap/cache/
   ```

## 🔍 Verification Steps

### Backend Verification
1. Visit: `https://your-backend-domain.railway.app`
2. Check: `https://your-backend-domain.railway.app/api/health` (if you have a health endpoint)

### Frontend Verification  
1. Visit: `https://your-frontend-domain.railway.app`
2. Test login functionality
3. Check browser console for API connection errors

### Database Verification
1. Test user registration
2. Check if data persists
3. Verify file uploads work

## 🐛 Troubleshooting

### Common Issues

1. **"CORS Error"**:
   - Ensure backend CORS is configured for frontend domain
   - Check environment variables are set correctly

2. **"Database Connection Failed"**:
   - Verify MySQL plugin is connected
   - Check DB environment variables use Railway references

3. **"APP_KEY Not Set"**:
   - Generate app key: `php artisan key:generate --show`
   - Update APP_KEY environment variable

4. **"Storage Permission Denied"**:
   - Run: `chmod -R 775 storage bootstrap/cache`
   - Ensure Docker user has write permissions

5. **"Frontend Shows Blank Page"**:
   - Check build logs for errors
   - Verify nginx.conf is correct
   - Check environment variables

### Checking Logs

**Backend Logs**:
```bash
# In Railway backend deployment terminal
tail -f storage/logs/laravel.log
```

**Frontend Logs**:
- Check Railway deployment logs
- Use browser developer tools

## 🔐 Security Checklist

- [ ] APP_DEBUG is set to `false` in production
- [ ] APP_KEY is generated and set
- [ ] Database credentials are using Railway variables
- [ ] CORS is properly configured
- [ ] HTTPS is enabled (Railway provides this automatically)
- [ ] Environment variables don't contain sensitive data in plain text

## 📈 Performance Optimization

1. **Laravel Optimizations**:
   ```bash
   php artisan config:cache
   php artisan route:cache
   php artisan view:cache
   ```

2. **Frontend Optimizations**:
   - Build includes automatic optimization
   - Nginx serves static files efficiently
   - Gzip compression enabled

## 🔄 CI/CD Setup

Railway automatically deploys when you push to your main branch. To customize:

1. **Railway Project Settings** → **Service Settings** → **Source**
2. Configure branch and build settings
3. Set up deployment triggers

## 📞 Support

If you encounter issues:
1. Check Railway deployment logs
2. Review Laravel logs in `storage/logs/`
3. Use browser developer tools for frontend issues
4. Consult Railway documentation: [docs.railway.app](https://docs.railway.app)

---

**Happy Deploying! 🎉**

Your Hulame Rental application should now be live and accessible worldwide! 