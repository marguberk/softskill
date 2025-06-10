# 🚀 MaroAI Production Deployment

## 🌐 Live Demo
**Официальный сайт:** https://berkinbayev.kz

## 📋 Deployment Details

### 🖥️ Server Specifications
- **OS:** Ubuntu 24.04 LTS
- **IP:** 85.202.192.20
- **Domain:** berkinbayev.kz
- **SSL:** Let's Encrypt (Auto-renewal enabled)

### 🔧 Tech Stack
- **Backend:** FastAPI + Python 3.12
- **Frontend:** React + TypeScript + Vite
- **Database:** SQLite
- **Web Server:** Nginx
- **SSL:** Certbot (Let's Encrypt)
- **Process Manager:** systemd

### 📁 Deployment Files

#### 🛠️ Setup Scripts
- `setup-server.sh` - Complete server setup automation
- `setup-server-ssl.sh` - SSL certificate automation  
- `setup-ssl-auto.sh` - SSL auto-renewal setup
- `ssl-monitor.sh` - Continuous SSL monitoring

#### ⚙️ Configuration Files
- `nginx-maroai.conf` - Basic HTTP nginx configuration
- `nginx-maroai-ssl.conf` - HTTPS nginx configuration
- `maroai-frontend.service` - Frontend systemd service

#### 🔍 Monitoring & Utilities
- `check-dns.sh` - DNS propagation checker
- `status.html` - Server status monitoring page

### 🚀 Quick Deployment Commands

#### Fresh Server Setup:
```bash
# 1. Upload project files to server
scp -r . ubuntu@85.202.192.20:~/MaroAI/

# 2. Run complete setup
ssh ubuntu@85.202.192.20 'cd MaroAI && ./setup-server.sh'

# 3. Setup SSL (after DNS propagation)
ssh ubuntu@85.202.192.20 'cd MaroAI && ./setup-server-ssl.sh your-domain.com'
```

#### Manual SSL Setup:
```bash
# Get SSL certificate
sudo certbot --nginx -d berkinbayev.kz -d www.berkinbayev.kz --non-interactive --agree-tos --email admin@berkinbayev.kz --redirect
```

### 🔄 Services Management

#### Backend Service:
```bash
sudo systemctl status maroai-backend
sudo systemctl restart maroai-backend
sudo journalctl -u maroai-backend -f
```

#### Frontend Service:
```bash
sudo systemctl status maroai-frontend  
sudo systemctl restart maroai-frontend
sudo journalctl -u maroai-frontend -f
```

#### Nginx:
```bash
sudo systemctl status nginx
sudo systemctl reload nginx
sudo nginx -t
```

### 📊 Monitoring

#### Check DNS Propagation:
```bash
./check-dns.sh
```

#### SSL Certificate Status:
```bash
sudo certbot certificates
```

#### Server Status:
Visit: https://berkinbayev.kz/status.html

### 🛡️ Security Features
- ✅ HTTPS redirect (HTTP → HTTPS)
- ✅ SSL certificate auto-renewal
- ✅ Firewall configured (UFW)
- ✅ Security headers in nginx
- ✅ Rate limiting protection

### 🔗 API Endpoints
- **Base URL:** https://berkinbayev.kz/api/v1/
- **Documentation:** https://berkinbayev.kz/api/v1/docs
- **Health Check:** https://berkinbayev.kz/api/v1/health

### 📝 Logs Location
- **Nginx Access:** `/var/log/nginx/maroai_access.log`
- **Nginx Error:** `/var/log/nginx/maroai_error.log`
- **Backend Logs:** `journalctl -u maroai-backend`
- **Frontend Logs:** `journalctl -u maroai-frontend`

### 🔄 Backup & Updates

#### Database Backup:
```bash
cp app.db app_backup_$(date +%Y%m%d_%H%M%S).db
```

#### Code Updates:
```bash
git pull origin main
sudo systemctl restart maroai-backend maroai-frontend
```

### 📞 Support
- **GitHub:** https://github.com/marguberk/softskill
- **Issues:** https://github.com/marguberk/softskill/issues

---
**Last Updated:** June 5, 2025  
**Deployment Status:** ✅ Live and Running 