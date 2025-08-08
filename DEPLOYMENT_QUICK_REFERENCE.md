# 🚀 Quick Deployment Reference

## 📋 Pre-Deployment Checklist
- [ ] Netlify config removed ✅
- [ ] Vercel config added ✅
- [ ] Railway config ready ✅
- [ ] API config updated ✅
- [ ] Code pushed to GitHub
- [ ] Environment variables prepared

## 🔧 Deployment Steps

### 1. Backend (Railway)
```
1. Go to railway.app
2. New Project → Deploy from GitHub
3. Select repo, set root to /back
4. Add MySQL database
5. Set environment variables
6. Deploy and get URL
```

### 2. Frontend (Vercel)
```
1. Go to vercel.com
2. New Project → Import GitHub repo
3. Set root directory to /front
4. Set environment variables:
   - REACT_APP_API_URL=https://your-railway-url.railway.app/api
   - REACT_APP_ENV=production
5. Deploy
```

### 3. Database
```
1. In Railway dashboard → MySQL database
2. Query tab → Import hulame.sql
3. Execute SQL commands
```

## 🔑 Environment Variables

### Railway (Backend)
```
APP_NAME=Hulame
APP_ENV=production
APP_KEY=base64:2uGMbwjzgq2B/Lu7zyc1SxpF/8cDZl1l/6D10pyXF60=
APP_DEBUG=false
APP_URL=https://your-railway-url.railway.app
DB_CONNECTION=mysql
DB_HOST=${MYSQLHOST}
DB_PORT=${MYSQLPORT}
DB_DATABASE=${MYSQLDATABASE}
DB_USERNAME=${MYSQLUSER}
DB_PASSWORD=${MYSQLPASSWORD}
```

### Vercel (Frontend)
```
REACT_APP_API_URL=https://your-railway-url.railway.app/api
REACT_APP_ENV=production
```

## 🆓 Free Tier Limits

### Vercel
- 100GB bandwidth/month
- 100GB storage
- 100GB function execution time/month

### Railway
- $5 credit/month
- Shared infrastructure
- Automatic scaling

## 🔍 Testing URLs
- Frontend: `https://your-app.vercel.app`
- Backend: `https://your-app.railway.app/api`
- Health Check: `https://your-app.railway.app/api/test`

## 🛠️ Troubleshooting
- **Build fails**: Check logs, verify dependencies
- **CORS errors**: Update CORS config in Laravel
- **DB connection**: Verify Railway MySQL credentials
- **API not working**: Check Railway logs, verify routes

## 📞 Support
- Vercel: vercel.com/support
- Railway: railway.app/docs
- Laravel: laravel.com/docs
- React: reactjs.org/docs
