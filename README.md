# n8n Docker Setup

A production-ready n8n workflow automation platform deployed with Docker, featuring PostgreSQL database, Redis queue management, and scalable architecture.

## 🚀 Features

- **Complete Stack**: n8n with PostgreSQL database and Redis queue
- **Production Ready**: Resource limits, health checks, and monitoring
- **Cloud Deployment**: Ready for Railway.app with one-click deployment
- **Secure Configuration**: Environment-based secrets management
- **Scalable**: Multi-worker architecture with queue processing
- **Development Friendly**: Local development with Docker Compose

## 📋 Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (v20.10+)
- [Docker Compose](https://docs.docker.com/compose/install/) (v2.0+)
- Git (for cloning and version control)
- 4GB+ RAM available for containers

## 🛠️ Quick Start

### 1. Clone and Setup

```bash
git clone <your-repository-url>
cd n8n
```

### 2. Configure Environment

Copy and customize the environment file:

```bash
cp .env .env.local
```

**⚠️ IMPORTANT**: Update these critical security settings in `.env`:

```bash
# Change these default passwords!
POSTGRES_PASSWORD=your-secure-postgres-password
POSTGRES_NON_ROOT_PASSWORD=your-secure-n8n-password
ENCRYPTION_KEY=your-32-character-encryption-key

# For local development
WEBHOOK_URL=http://localhost:5678
```

### 3. Start the Stack

```bash
docker-compose up -d
```

### 4. Access n8n

Open your browser and navigate to: http://localhost:5678

## 📁 Project Structure

```
n8n/
├── README.md                 # This file
├── docker-compose.yml        # Main Docker configuration
├── Dockerfile               # n8n container definition
├── .env                     # Environment variables (gitignored)
├── .gitignore              # Git ignore rules
├── init-data.sh            # PostgreSQL initialization
├── railway.json            # Railway deployment config
├── deployment-options.md   # Platform comparison guide
└── docs/
    ├── RAILWAY_DEPLOYMENT.md  # Railway setup guide
    └── tasks.md              # Improvement roadmap
```

## 🐳 Docker Services

| Service | Description | Port | Resources |
|---------|-------------|------|-----------|
| **n8n** | Main workflow engine | 5678 | 1 CPU, 512MB RAM |
| **n8n-worker** | Background job processor | - | 1 CPU, 512MB RAM |
| **postgres** | Database | 5432 | 1 CPU, 1GB RAM |
| **redis** | Queue & cache | 6379 | 0.5 CPU, 256MB RAM |

## 🔧 Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `POSTGRES_PASSWORD` | PostgreSQL admin password | `ranma` ⚠️ |
| `POSTGRES_NON_ROOT_PASSWORD` | n8n database user password | `ranma` ⚠️ |
| `ENCRYPTION_KEY` | n8n data encryption key | `changeEncryptionKey` ⚠️ |
| `WEBHOOK_URL` | Public webhook URL | `http://localhost:5678` |

### Health Checks

All services include health checks:
- **PostgreSQL**: Connection test every 5s
- **Redis**: Ping test every 5s
- **n8n**: Automatic restart on failure

### Resource Management

Resource limits are configured for all containers:
- CPU limits prevent resource exhaustion
- Memory limits ensure stable operation
- Restart policies handle failures gracefully

## ☁️ Cloud Deployment

### Railway.app (Recommended)

Deploy to Railway.app for a free, production-ready hosting solution:

1. **Quick Deploy**: [![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new)

2. **Manual Setup**: See [Railway Deployment Guide](docs/RAILWAY_DEPLOYMENT.md)

**Benefits:**
- $5/month free tier
- Automatic HTTPS & custom domains
- Built-in PostgreSQL & Redis
- No service sleeping
- Professional webhook URLs

### Other Platforms

See [deployment-options.md](deployment-options.md) for alternatives:
- Render.com (750 hours/month free)
- Fly.io ($5 monthly credits)
- Google Cloud Run (2M requests/month)

## 🔒 Security Considerations

### Immediate Actions Required

1. **Change Default Passwords**: Update all passwords in `.env`
2. **Generate Encryption Key**: Create a secure 32+ character key
3. **File Permissions**: Set `.env` to read-only (`chmod 600 .env`)
4. **Network Security**: Configure custom Docker networks for production

### Security Features

- Environment variables protected by `.gitignore`
- Database connections isolated within Docker network
- Resource limits prevent DoS attacks
- Health checks ensure service availability

## 🚨 Troubleshooting

### Common Issues

#### Services Won't Start
```bash
# Check service status
docker-compose ps

# View logs
docker-compose logs [service-name]

# Restart services
docker-compose restart
```

#### Database Connection Errors
```bash
# Check PostgreSQL logs
docker-compose logs postgres

# Verify environment variables
docker-compose config

# Test database connectivity
docker-compose exec postgres pg_isready -h localhost -U n8n -d n8n
```

#### Memory Issues
```bash
# Check resource usage
docker stats

# Increase Docker memory allocation (Docker Desktop)
# Or adjust resource limits in docker-compose.yml
```

### Performance Optimization

- **CPU**: Increase CPU limits for heavy workflows
- **Memory**: Monitor usage and adjust limits accordingly  
- **Database**: Consider connection pooling for high-volume setups
- **Workers**: Scale n8n-worker replicas for parallel processing

## 📚 Additional Resources

- **[n8n Documentation](https://docs.n8n.io/)** - Official n8n guides
- **[Docker Compose Reference](https://docs.docker.com/compose/)** - Docker configuration help
- **[Railway Documentation](https://docs.railway.app/)** - Deployment platform docs
- **[PostgreSQL Tuning](https://wiki.postgresql.org/wiki/Tuning_Your_PostgreSQL_Server)** - Database optimization
- **[Tasks & Improvements](docs/tasks.md)** - Prioritized enhancement roadmap

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📋 Improvement Roadmap

See [docs/tasks.md](docs/tasks.md) for a prioritized list of 65+ improvement tasks covering:

- 🔴 **Critical**: Security vulnerabilities and data protection
- 🟠 **High**: Infrastructure stability and security hardening  
- 🟡 **Medium**: Production readiness and monitoring
- 🔵 **Low**: Performance optimizations and advanced features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚡ Quick Commands

```bash
# Start all services
docker-compose up -d

# Stop all services  
docker-compose down

# View logs
docker-compose logs -f

# Update and restart
docker-compose pull && docker-compose up -d

# Backup database
docker-compose exec postgres pg_dump -U n8n n8n > backup.sql

# Access n8n CLI
docker-compose exec n8n n8n --help
```

---

**🎉 Happy Automating!** Your n8n instance is ready for workflow creation. Access it at http://localhost:5678 and start building powerful automation workflows.
