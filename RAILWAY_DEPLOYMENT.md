# 🚀 Railway Deployment Guide for Hulame

## Prerequisites
- Railway account (https://railway.app)
- Railway CLI installed: `npm install -g @railway/cli`
- Git repository connected to Railway

## 🗄️ Step 1: Create MySQL Database Service

1. Go to [Railway Dashboard](https://railway.app/dashboard)
2. Select your Hulame project
3. Click **"New Service"** → **"Database"** → **"MySQL"**
4. Wait for MySQL service to be created
5. Note down the service name (e.g., `mysql-service`)

## 🔧 Step 2: Configure Backend Service

1. **Create Backend Service:**
   - Click **"New Service"** → **"GitHub Repo"**
   - Select your repository
   - Set service name: `hulame-backend`
   - Set root directory: `back`

2. **Set Environment Variables:**
   ```
   APP_NAME=Hulame
   APP_ENV=production
   APP_KEY=base64:2uGMbwjzgq2B/Lu7zyc1SxpF/8cDZl1l/6D10pyXF60=
   APP_DEBUG=false
   APP_URL=https://hulame-backend.up.railway.app
   
   DB_CONNECTION=mysql
   DB_HOST=${MYSQLHOST}
   DB_PORT=${MYSQLPORT}
   DB_DATABASE=${MYSQLDATABASE}
   DB_USERNAME=${MYSQLUSER}
   DB_PASSWORD=${MYSQLPASSWORD}
   
   CACHE_DRIVER=file
   SESSION_DRIVER=file
   QUEUE_DRIVER=sync
   LOG_CHANNEL=stack
   LOG_LEVEL=error
   ```

3. **Connect MySQL Service:**
   - In backend service, go to **"Variables"** tab
   - Click **"Reference Variable"**
   - Select your MySQL service
   - This will automatically inject MySQL connection variables

## 🌐 Step 3: Configure Frontend Service

1. **Create Frontend Service:**
   - Click **"New Service"** → **"GitHub Repo"**
   - Select your repository
   - Set service name: `hulame-frontend`
   - Set root directory: `front`

2. **Set Environment Variables:**
   ```
   REACT_APP_API_URL=https://hulame-backend.up.railway.app/api
   REACT_APP_ENV=production
   ```

## 🚀 Step 4: Deploy Services

### Option A: Using Railway CLI
```bash
# Login to Railway
railway login

# Link to your project
railway link

# Deploy backend
cd back
railway up --service hulame-backend

# Deploy frontend
cd ../front
railway up --service hulame-frontend
```

### Option B: Using Railway Dashboard
1. Go to each service
2. Click **"Deploy"** button
3. Wait for deployment to complete

## 🔍 Step 5: Verify Deployment

1. **Check Backend Health:**
   - Visit: `https://hulame-backend.up.railway.app/api/health`
   - Should return: `{"status":"healthy","timestamp":"...","service":"Hulame Backend API"}`

2. **Check Frontend:**
   - Visit: `https://hulame-frontend.up.railway.app`
   - Should load your React application

3. **Check Database Connection:**
   - Backend logs should show successful database connection
   - Tables should be migrated automatically

## 🗃️ Step 6: Database Migration

The database tables will be created automatically during the first deployment via Nixpacks build phase:

```toml
[phases.build]
  cmds = [
    "php artisan migrate --force",
    "php artisan storage:link"
  ]
```

## 🔗 Step 7: Custom Domains (Optional)

1. Go to each service → **"Settings"** → **"Domains"**
2. Add your custom domain
3. Configure DNS records as instructed

## 📊 Monitoring & Logs

- **Logs:** Each service → **"Deployments"** → **"View Logs"**
- **Metrics:** Each service → **"Metrics"** tab
- **Health Checks:** Automatic health monitoring via `/api/health` endpoint

## 🚨 Troubleshooting

### Common Issues:

1. **Database Connection Failed:**
   - Verify MySQL service is running
   - Check environment variables are correctly set
   - Ensure MySQL service is referenced in backend

2. **Build Failed:**
   - Check Nixpacks configuration
   - Verify all dependencies are in composer.json/package.json
   - Check build logs for specific errors

3. **Frontend Can't Connect to Backend:**
   - Verify REACT_APP_API_URL is correct
   - Check CORS configuration in backend
   - Ensure backend is healthy

### Debug Commands:
```bash
# Check Railway status
railway status

# View service logs
railway logs --service hulame-backend
railway logs --service hulame-frontend

# Check environment variables
railway variables --service hulame-backend
```

## 🎯 Success Checklist

- [ ] MySQL service created and running
- [ ] Backend service deployed successfully
- [ ] Frontend service deployed successfully
- [ ] Database tables migrated
- [ ] Health check endpoint responding
- [ ] Frontend can communicate with backend
- [ ] Application accessible via Railway URLs

## 📞 Support

If you encounter issues:
1. Check Railway documentation: https://docs.railway.app
2. Review service logs in Railway dashboard
3. Verify all environment variables are set correctly
4. Ensure services are properly connected

---

**🎉 Congratulations! Your Hulame application is now live on Railway!**
