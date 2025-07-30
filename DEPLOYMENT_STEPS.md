# 🚀 Complete Deployment Guide - Vercel + Railway MySQL

## 📋 Prerequisites
- GitHub account
- Vercel account (free)
- Railway account (free tier available)
- Git installed locally

## 🎯 Deployment Strategy
- **Frontend (React)**: Deployed on Vercel
- **Backend (Laravel)**: Deployed on Vercel
- **Database**: MySQL on Railway

---

## Step 1: Set Up Railway MySQL Database

### 1.1 Create Railway Account
1. Go to [Railway.app](https://railway.app)
2. Click "Start a New Project"
3. Sign up with your GitHub account

### 1.2 Create MySQL Database
1. In Railway dashboard, click "New Service"
2. Select "Database" → "MySQL"
3. Name your service: `hulame-mysql`
4. Wait for the database to be created

### 1.3 Get Database Credentials
1. Click on your MySQL service
2. Go to "Variables" tab
3. Copy these values:
   - `MYSQLHOST`
   - `MYSQLPORT` (usually 3306)
   - `MYSQLDATABASE`
   - `MYSQLUSER`
   - `MYSQLPASSWORD`

### 1.4 Import Database Schema
1. In Railway dashboard, go to your MySQL service
2. Click "Connect" → "MySQL Shell"
3. Copy and paste the contents of `back/railway-mysql-setup.sql`
4. Press Enter to execute

---

## Step 2: Deploy Backend on Vercel

### 2.1 Create Vercel Account
1. Go to [Vercel.com](https://vercel.com)
2. Sign up with your GitHub account

### 2.2 Deploy Backend
1. In Vercel dashboard, click "New Project"
2. Import your GitHub repository: `hulameustp/Hulam-E`
3. Configure the project:
   - **Framework Preset**: Other
   - **Root Directory**: `back`
   - **Build Command**: Leave empty
   - **Output Directory**: Leave empty
4. Click "Deploy"

### 2.3 Set Environment Variables
In your Vercel backend project settings, go to "Environment Variables" and add:

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

MAIL_MAILER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="Hulame"
```

**Replace the database values** with your actual Railway MySQL credentials.

### 2.4 Redeploy Backend
After setting environment variables, redeploy your backend project.

---

## Step 3: Deploy Frontend on Vercel

### 3.1 Deploy Frontend
1. In Vercel dashboard, click "New Project"
2. Import your GitHub repository: `hulameustp/Hulam-E`
3. Configure the project:
   - **Framework Preset**: Create React App
   - **Root Directory**: `front`
   - **Build Command**: `npm run build`
   - **Output Directory**: `build`
4. Click "Deploy"

### 3.2 Set Environment Variables
In your Vercel frontend project settings, add:
```
REACT_APP_API_URL=https://your-backend-domain.vercel.app/api
REACT_APP_ENV=production
```

**Replace `your-backend-domain`** with your actual Vercel backend domain.

### 3.3 Redeploy Frontend
After setting environment variables, redeploy your frontend project.

---

## Step 4: Test Your Deployment

### 4.1 Test Backend API
Visit: `https://your-backend-domain.vercel.app/api`

You should see a JSON response or Laravel welcome page.

### 4.2 Test Frontend
Visit your Vercel frontend URL and ensure it can communicate with the backend.

### 4.3 Test Database Connection
You can test the database connection by visiting:
`https://your-backend-domain.vercel.app/api/users`

---

## Step 5: Update URLs and Final Configuration

### 5.1 Update CORS Configuration
The CORS configuration is already updated to allow Vercel domains.

### 5.2 Update Environment Variables
Make sure all environment variables are set correctly in both Vercel projects.

### 5.3 Final URLs
After deployment, you should have:
- **Frontend**: `https://your-frontend-app.vercel.app`
- **Backend**: `https://your-backend-app.vercel.app`
- **API**: `https://your-backend-app.vercel.app/api`
- **Database**: Railway MySQL (managed)

---

## 🔧 Troubleshooting

### Common Issues:

1. **Database Connection Failed**
   - Check database credentials in Vercel environment variables
   - Ensure Railway MySQL service is running
   - Verify the database schema was imported correctly

2. **CORS Errors**
   - The CORS configuration is already updated
   - Check browser console for specific error messages

3. **Build Failures**
   - Check build logs in Vercel
   - Ensure all dependencies are installed
   - Verify the root directory is set correctly

4. **Environment Variables**
   - Double-check all environment variables are set correctly
   - Redeploy after updating variables
   - Make sure there are no typos in the values

5. **API Not Working**
   - Check if the backend is deployed correctly
   - Verify the API routes are accessible
   - Check Vercel function logs for errors

---

## 📞 Support

If you encounter any issues:
1. Check Vercel deployment logs
2. Check Railway database logs
3. Verify all environment variables are set correctly
4. Test the API endpoints individually

---

## 🎉 Success Checklist

- [ ] Railway MySQL database created and running
- [ ] Database schema imported successfully
- [ ] Backend deployed on Vercel
- [ ] Frontend deployed on Vercel
- [ ] Environment variables set correctly
- [ ] API endpoints working
- [ ] Frontend can communicate with backend
- [ ] Database connection working

---

**Remember**: Never commit sensitive information like API keys or database passwords to your repository. Always use environment variables for production deployments. 