# Deployment Guide: Vercel (Frontend) + Railway (Backend + Database)

## Prerequisites
- GitHub account
- Vercel account (free tier)
- Railway account (free tier)
- Git installed locally

## Step 1: Prepare Your Repository

### 1.1 Push to GitHub
```bash
# If not already done, push your code to GitHub
git add .
git commit -m "Prepare for deployment"
git push origin main
```

## Step 2: Deploy Backend to Railway

### 2.1 Create Railway Account
1. Go to [railway.app](https://railway.app)
2. Sign up with your GitHub account
3. Create a new project

### 2.2 Deploy Backend
1. In Railway dashboard, click "New Project"
2. Select "Deploy from GitHub repo"
3. Choose your repository
4. Set the root directory to `/back`
5. Railway will automatically detect it's a PHP/Laravel project

### 2.3 Set Environment Variables
In Railway dashboard, go to your project → Variables tab and add:

```
APP_NAME=Hulame
APP_ENV=production
APP_KEY=base64:2uGMbwjzgq2B/Lu7zyc1SxpF/8cDZl1l/6D10pyXF60=
APP_DEBUG=false
APP_URL=https://your-railway-app-url.railway.app

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

MAIL_MAILER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="Hulame"

SESSION_SECURE_COOKIE=true
SESSION_SAME_SITE=strict
```

### 2.4 Add MySQL Database
1. In Railway dashboard, click "New"
2. Select "Database" → "MySQL"
3. Railway will automatically link it to your backend
4. The database variables (MYSQLHOST, MYSQLPORT, etc.) will be automatically set

### 2.5 Deploy and Get Backend URL
1. Railway will automatically deploy your backend
2. Go to "Deployments" tab to see the deployment status
3. Once deployed, copy the generated URL (e.g., `https://your-app-name.railway.app`)

## Step 3: Deploy Frontend to Vercel

### 3.1 Create Vercel Account
1. Go to [vercel.com](https://vercel.com)
2. Sign up with your GitHub account

### 3.2 Deploy Frontend
1. In Vercel dashboard, click "New Project"
2. Import your GitHub repository
3. Configure the project:
   - **Framework Preset**: Create React App
   - **Root Directory**: `front`
   - **Build Command**: `npm run build`
   - **Output Directory**: `build`
   - **Install Command**: `npm install`

### 3.3 Set Environment Variables
In Vercel dashboard, go to your project → Settings → Environment Variables and add:

```
REACT_APP_API_URL=https://your-railway-backend-url.railway.app/api
REACT_APP_ENV=production
```

### 3.4 Deploy
1. Click "Deploy"
2. Vercel will build and deploy your frontend
3. You'll get a URL like `https://your-app-name.vercel.app`

## Step 4: Database Setup

### 4.1 Import Database Schema
1. In Railway dashboard, go to your MySQL database
2. Click "Connect" → "MySQL"
3. Use the connection details to connect via MySQL client
4. Import your database schema from `hulame.sql`

### 4.2 Alternative: Use Railway's SQL Editor
1. In Railway dashboard, go to your MySQL database
2. Click "Query" tab
3. Copy and paste the contents of `hulame.sql`
4. Execute the SQL commands

## Step 5: Final Configuration

### 5.1 Update CORS Settings (if needed)
If you encounter CORS issues, update your Laravel backend:

In `back/config/cors.php`:
```php
return [
    'paths' => ['api/*'],
    'allowed_methods' => ['*'],
    'allowed_origins' => ['https://your-vercel-frontend-url.vercel.app'],
    'allowed_origins_patterns' => [],
    'allowed_headers' => ['*'],
    'exposed_headers' => [],
    'max_age' => 0,
    'supports_credentials' => true,
];
```

### 5.2 Test Your Deployment
1. Test your frontend: `https://your-app-name.vercel.app`
2. Test your backend API: `https://your-railway-backend-url.railway.app/api`
3. Test database connectivity through your backend

## Step 6: Custom Domains (Optional)

### 6.1 Vercel Custom Domain
1. In Vercel dashboard, go to your project → Settings → Domains
2. Add your custom domain
3. Configure DNS as instructed

### 6.2 Railway Custom Domain
1. In Railway dashboard, go to your project → Settings → Domains
2. Add your custom domain
3. Configure DNS as instructed

## Troubleshooting

### Common Issues:

1. **Build Failures**
   - Check build logs in Vercel/Railway
   - Ensure all dependencies are in package.json/composer.json

2. **Environment Variables**
   - Double-check all environment variables are set correctly
   - Ensure variable names match exactly

3. **Database Connection**
   - Verify database credentials in Railway
   - Check if database is properly provisioned

4. **CORS Issues**
   - Update CORS configuration in Laravel
   - Ensure frontend URL is in allowed origins

5. **API Endpoints Not Working**
   - Check if backend is deployed successfully
   - Verify API routes are properly configured
   - Check Railway logs for errors

## Free Tier Limits

### Vercel Free Tier:
- 100GB bandwidth/month
- 100GB storage
- 100GB function execution time/month
- Custom domains supported

### Railway Free Tier:
- $5 credit/month
- Shared infrastructure
- Automatic scaling
- Custom domains supported

## Monitoring

### Vercel Analytics:
- Built-in analytics in Vercel dashboard
- Performance monitoring
- Error tracking

### Railway Monitoring:
- Built-in logs and metrics
- Performance monitoring
- Error tracking

## Security Notes

1. **Environment Variables**: Never commit sensitive data to Git
2. **API Keys**: Store securely in environment variables
3. **Database**: Use strong passwords and restrict access
4. **HTTPS**: Both Vercel and Railway provide SSL by default

## Cost Optimization

1. **Vercel**: Free tier is generous for most projects
2. **Railway**: Monitor usage to stay within $5 credit
3. **Database**: Consider using Railway's MySQL for simplicity
4. **CDN**: Vercel provides global CDN for free

## Support

- **Vercel**: [vercel.com/support](https://vercel.com/support)
- **Railway**: [railway.app/docs](https://railway.app/docs)
- **Laravel**: [laravel.com/docs](https://laravel.com/docs)
- **React**: [reactjs.org/docs](https://reactjs.org/docs)
