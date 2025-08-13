#!/bin/bash

echo "🚀 Deploying Hulame to Railway..."

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI not found. Installing..."
    npm install -g @railway/cli
fi

# Login to Railway
echo "🔐 Logging into Railway..."
railway login

# Link to your project
echo "🔗 Linking to Railway project..."
railway link

# Deploy backend
echo "📦 Deploying backend..."
cd back
railway up --service backend

# Deploy frontend
echo "🌐 Deploying frontend..."
cd ../front
railway up --service frontend

echo "✅ Deployment complete!"
echo "🔗 Check your Railway dashboard for deployment status"
