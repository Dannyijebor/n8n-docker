# Railway Deployment Guide for n8n

This guide explains how to deploy your n8n Docker setup to Railway.app as a free alternative to ngrok for webhook URL exposure.

## Prerequisites

- GitHub account
- Railway account (sign up at https://railway.app)
- Your n8n project code in a GitHub repository

## Step-by-Step Deployment

### 1. Prepare Your Repository

Ensure your repository contains:
- `Dockerfile` ✅
- `railway.json` ✅  
- `docker-compose.yml` (updated for env variables) ✅
- `.env` file (updated with WEBHOOK_URL) ✅

### 2. Set Up Railway Project

1. Go to https://railway.app and sign up/login
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Choose your n8n repository
5. Railway will automatically detect the Dockerfile

### 3. Add Database Services

#### PostgreSQL Database
1. In your Railway project dashboard, click "New Service"
2. Select "Database" → "PostgreSQL"
3. Railway will provision a PostgreSQL instance
4. Note the connection details from the "Connect" tab

#### Redis Database
1. Click "New Service" again
2. Select "Database" → "Redis"
3. Railway will provision a Redis instance
4. Note the connection details from the "Connect" tab

### 4. Configure Environment Variables

In your n8n service, go to "Variables" tab and add:

```bash
# Database Configuration
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=<your-railway-postgres-host>
DB_POSTGRESDB_PORT=<your-railway-postgres-port>
DB_POSTGRESDB_DATABASE=<your-railway-postgres-database>
DB_POSTGRESDB_USER=<your-railway-postgres-user>
DB_POSTGRESDB_PASSWORD=<your-railway-postgres-password>

# Redis Configuration  
QUEUE_BULL_REDIS_HOST=<your-railway-redis-host>
QUEUE_BULL_REDIS_PORT=<your-railway-redis-port>
QUEUE_BULL_REDIS_PASSWORD=<your-railway-redis-password>

# n8n Configuration
EXECUTIONS_MODE=queue
QUEUE_HEALTH_CHECK_ACTIVE=true
N8N_ENCRYPTION_KEY=<generate-a-secure-32-char-string>

# Webhook URL (Railway will provide this)
WEBHOOK_URL=https://<your-app-name>.railway.app
```

### 5. Deploy and Get Your URL

1. Railway will automatically deploy your app
2. Go to "Settings" → "Domains" in your n8n service
3. Railway provides a free subdomain: `https://<your-app-name>.railway.app`
4. This is your webhook URL to use instead of ngrok!

### 6. Update Webhook URL

1. Copy your Railway app URL
2. Update the `WEBHOOK_URL` environment variable in Railway dashboard
3. Or update your local `.env` file for future deployments:
   ```bash
   WEBHOOK_URL=https://<your-app-name>.railway.app
   ```

### 7. Custom Domain (Optional)

Railway allows custom domains on the free tier:
1. Go to "Settings" → "Domains"
2. Click "Add Domain"
3. Enter your custom domain
4. Configure DNS according to Railway's instructions

## Benefits Over ngrok

✅ **Permanent URL**: No more changing URLs  
✅ **No Tunnels**: Direct internet exposure  
✅ **HTTPS**: Automatic SSL certificates  
✅ **Custom Domains**: Use your own domain  
✅ **Always Online**: No need to keep ngrok running  
✅ **Professional**: Better for production use  

## Railway Free Tier Limits

- $5 in usage credits per month
- Typically covers small to medium n8n workloads
- No sleeping (unlike some other free services)
- Automatic scaling

## Troubleshooting

### Common Issues

1. **Build Failures**: Check Dockerfile syntax and Railway logs
2. **Database Connection**: Verify environment variables match Railway's provided credentials  
3. **Port Issues**: Railway automatically handles port mapping
4. **Memory Limits**: Monitor usage in Railway dashboard

### Getting Help

- Railway Documentation: https://docs.railway.app
- Railway Discord: https://discord.gg/railway
- n8n Community: https://community.n8n.io

## Alternative Free Platforms

If Railway doesn't meet your needs, consider:
- **Render.com**: 750 hours/month free tier
- **Fly.io**: $5 monthly credits
- **Google Cloud Run**: 2M requests/month free

---

**Success!** 🎉 You now have a professional webhook URL for your n8n workflows without relying on ngrok tunnels.
