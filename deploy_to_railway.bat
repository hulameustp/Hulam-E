@echo off
echo =====================================================
echo    Hulame Rental - Railway Deployment Helper
echo =====================================================
echo.

echo Step 1: Adding all files to git...
git add .

echo.
echo Step 2: Committing changes...
git commit -m "Add Railway deployment configuration with Dockerfiles and nginx config"

echo.
echo Step 3: Pushing to GitHub...
git push origin main

echo.
echo =====================================================
echo    Files Ready for Railway Deployment!
echo =====================================================
echo.
echo Next steps:
echo 1. Go to https://railway.app
echo 2. Sign in and create a new project
echo 3. Connect your GitHub repository
echo 4. Follow the guide in RAILWAY_DEPLOYMENT_GUIDE.md
echo.
echo Backend files created:
echo   - back/Dockerfile
echo   - back/railway.json
echo.
echo Frontend files created:
echo   - front/Dockerfile  
echo   - front/nginx.conf
echo   - front/.env
echo.
echo Documentation:
echo   - RAILWAY_DEPLOYMENT_GUIDE.md
echo.
echo =====================================================
echo Ready to deploy! Open the guide for detailed steps.
echo =====================================================
pause 