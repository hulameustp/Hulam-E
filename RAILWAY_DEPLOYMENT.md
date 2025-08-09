# 🚀 Railway Deployment Guide for Hulam-E

## Quick Start

1. **Install Railway CLI**
   ```bash
   npm install -g @railway/cli
   railway login
   ```

2. **Run the automated deployment script**
   ```bash
   ./deploy-railway.sh
   ```

## Manual Deployment Steps

### 1. Create Railway Project
```bash
railway new hulam-e
```

### 2. Deploy Database
- In Railway dashboard: Add Service → Database → MySQL
- Note the generated connection details

### 3. Deploy Backend (Laravel)
```bash
cd back
railway init
railway variables set APP_ENV=production
railway variables set APP_DEBUG=false
railway variables set APP_KEY=$(php artisan key:generate --show)
railway variables set DB_CONNECTION=mysql
railway up
```

### 4. Deploy Frontend (React)
```bash
cd front
railway init
railway variables set REACT_APP_API_URL=https://your-backend-url.up.railway.app/api
railway up
```

### 5. Run Migrations
```bash
cd back
railway run php artisan migrate --force
railway run php artisan db:seed --force
```

## Environment Variables

### Backend Required Variables:
- `APP_ENV=production`
- `APP_DEBUG=false`
- `APP_KEY=` (generate with Laravel)
- `DB_CONNECTION=mysql`
- Railway auto-injects MySQL connection details

### Frontend Required Variables:
- `REACT_APP_API_URL=https://your-backend-url.up.railway.app/api`

## Files Created for Railway:

- ✅ `front/railway.json` - Frontend Railway configuration
- ✅ `front/Dockerfile` - Frontend Docker setup with Nginx
- ✅ `front/nginx.conf` - Nginx configuration for React SPA
- ✅ `back/railway.json` - Backend Railway configuration (already existed)
- ✅ `back/Dockerfile` - Backend Docker setup (already existed)
- ✅ `deploy-railway.sh` - Automated deployment script
- ✅ `front/env.railway` - Frontend environment template
- ✅ `back/env.railway` - Backend environment template

## Files Removed:
- ❌ `front/vercel.json` - Vercel configuration (removed)

## Project Structure:
```
hulam-e/
├── front/              (React frontend)
│   ├── railway.json
│   ├── Dockerfile
│   ├── nginx.conf
│   └── env.railway
├── back/               (Laravel backend)
│   ├── railway.json
│   ├── Dockerfile
│   └── env.railway
└── deploy-railway.sh   (Deployment script)
```

## Monitoring & Logs
- Use Railway dashboard for monitoring
- View logs in real-time: `railway logs`
- Connect to services: `railway connect`

## Custom Domains
1. Go to service settings in Railway dashboard
2. Navigate to "Domains" tab
3. Add your custom domain

## Database Access
- Railway provides a built-in database viewer
- Connect via Railway CLI: `railway connect mysql`
- Or use external tools with provided connection string

## Troubleshooting
- Check Railway dashboard logs for errors
- Verify environment variables are set correctly
- Ensure database migrations ran successfully
- Test API endpoints directly before frontend testing
