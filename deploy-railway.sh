#!/bin/bash

# Railway Deployment Script for Hulam-E Project
# This script automates the deployment of frontend, backend, and database to Railway

set -e

echo "🚀 Starting Railway deployment for Hulam-E project..."

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI is not installed. Please install it first:"
    echo "npm install -g @railway/cli"
    exit 1
fi

# Check if user is logged in to Railway
if ! railway whoami &> /dev/null; then
    echo "❌ Not logged in to Railway. Please run: railway login"
    exit 1
fi

# Function to generate Laravel app key
generate_app_key() {
    echo "🔑 Generating Laravel application key..."
    cd back
    php artisan key:generate --show
    cd ..
}

echo "📊 Creating new Railway project..."
railway new hulam-e --name "Hulam-E"

echo "🗄️  Step 1: Setting up MySQL Database..."
echo "Please add a MySQL database service through the Railway dashboard:"
echo "1. Go to your Railway project dashboard"
echo "2. Click 'Add Service' → 'Database' → 'MySQL'"
echo "3. Wait for the database to be provisioned"
echo "4. Press Enter when done..."
read -p "Press Enter to continue after adding MySQL service..."

echo "🔧 Step 2: Deploying Backend (Laravel API)..."
cd back

# Initialize Railway for backend
railway init --name "hulam-e-backend"

# Generate and set environment variables
APP_KEY=$(php artisan key:generate --show)

echo "Setting backend environment variables..."
railway variables set APP_ENV=production
railway variables set APP_DEBUG=false
railway variables set APP_KEY="$APP_KEY"
railway variables set CACHE_DRIVER=file
railway variables set SESSION_DRIVER=file
railway variables set QUEUE_DRIVER=sync
railway variables set DB_CONNECTION=mysql

# Deploy backend
echo "Deploying backend..."
railway up --detach

echo "⏳ Waiting for backend to deploy..."
sleep 30

# Get backend URL
BACKEND_URL=$(railway status --json | grep -o '"url":"[^"]*"' | cut -d'"' -f4)
echo "Backend deployed to: $BACKEND_URL"

cd ..

echo "🌐 Step 3: Deploying Frontend (React)..."
cd front

# Initialize Railway for frontend
railway init --name "hulam-e-frontend"

# Set frontend environment variables
railway variables set REACT_APP_API_URL="${BACKEND_URL}/api"

# Deploy frontend
echo "Deploying frontend..."
railway up --detach

echo "⏳ Waiting for frontend to deploy..."
sleep 30

# Get frontend URL
FRONTEND_URL=$(railway status --json | grep -o '"url":"[^"]*"' | cut -d'"' -f4)
echo "Frontend deployed to: $FRONTEND_URL"

cd ..

echo "🗃️  Step 4: Running Database Migrations..."
cd back

# Connect to backend service and run migrations
echo "Running Laravel migrations..."
railway run php artisan migrate --force
railway run php artisan db:seed --force

cd ..

echo "✅ Deployment completed successfully!"
echo ""
echo "🌐 Frontend URL: $FRONTEND_URL"
echo "🔧 Backend API URL: $BACKEND_URL"
echo ""
echo "📝 Next steps:"
echo "1. Test your application by visiting the frontend URL"
echo "2. Check the Railway dashboard for monitoring and logs"
echo "3. Configure custom domains if needed"
echo ""
echo "🔗 Railway Project: https://railway.app/project/$(railway status --json | grep -o '"id":"[^"]*"' | cut -d'"' -f4)"
