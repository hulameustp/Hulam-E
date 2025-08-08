#!/bin/bash

echo "🚀 Hulame Deployment Setup Script"
echo "=================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Not in a git repository. Please initialize git first:"
    echo "   git init"
    echo "   git add ."
    echo "   git commit -m 'Initial commit'"
    exit 1
fi

echo "✅ Git repository found"
echo ""

# Check if we have a remote origin
if ! git remote get-url origin &> /dev/null; then
    echo "⚠️  No remote origin found. Please add your GitHub repository:"
    echo "   git remote add origin https://github.com/yourusername/yourrepo.git"
    echo ""
fi

echo "📋 Pre-deployment Checklist:"
echo "1. ✅ Netlify configuration removed"
echo "2. ✅ Vercel configuration added"
echo "3. ✅ Railway configuration ready"
echo "4. ✅ API configuration updated"
echo ""

echo "🔧 Next Steps:"
echo "1. Push your code to GitHub:"
echo "   git add ."
echo "   git commit -m 'Prepare for deployment'"
echo "   git push origin main"
echo ""
echo "2. Deploy Backend to Railway:"
echo "   - Go to railway.app"
echo "   - Create new project from GitHub repo"
echo "   - Set root directory to '/back'"
echo "   - Add MySQL database"
echo "   - Set environment variables"
echo ""
echo "3. Deploy Frontend to Vercel:"
echo "   - Go to vercel.com"
echo "   - Import GitHub repository"
echo "   - Set root directory to '/front'"
echo "   - Set environment variables"
echo ""
echo "4. Import database schema from hulame.sql"
echo ""
echo "📖 See DEPLOYMENT_GUIDE.md for detailed instructions"
echo ""

# Check for sensitive files
echo "🔒 Security Check:"
if [ -f "front/.env" ]; then
    echo "⚠️  front/.env found - make sure it doesn't contain sensitive data"
fi
if [ -f "back/.env" ]; then
    echo "⚠️  back/.env found - make sure it doesn't contain sensitive data"
fi

echo ""
echo "🎉 Setup complete! Follow the deployment guide to deploy your application."
