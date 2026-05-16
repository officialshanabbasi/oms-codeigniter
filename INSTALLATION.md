# Installation Guide - Order Management System (OMS)

## Complete Setup Instructions

### Prerequisites

Before starting, ensure you have:
- PHP 7.4 or higher
- MySQL 5.7 or higher
- Composer installed
- Apache/Nginx server
- GD Library enabled
- OpenSSL extension
- cURL extension

### Step 1: Download & Extract

```bash
# Clone the repository
git clone https://github.com/officialshanabbasi/oms-codeigniter.git
cd oms-codeigniter

# Or download ZIP and extract
unzip oms-codeigniter.zip
cd oms-codeigniter
```

### Step 2: Install Dependencies

```bash
composer install
```

This will install:
- CodeIgniter 4 framework
- PHPMailer for email
- PHPSpreadsheet for Excel export
- mPDF for PDF generation

### Step 3: Configure Environment

```bash
# Copy environment template
cp .env.example .env
```

Edit `.env` file with your settings:

```env
CI_ENVIRONMENT = development

# APP Settings
app.baseURL = 'http://localhost/oms-codeigniter/'
app.forceGlobalSecureRequests = false
app.sessionExpiration = 7200

# DATABASE Settings
database.default.hostname = localhost
database.default.database = oms_codeigniter
database.default.username = root
database.default.password = 
database.default.DBDriver = MySQLi
database.default.port = 3306

# EMAIL Settings (Optional)
email.protocol = SMTP
email.SMTPHost = smtp.gmail.com
email.SMTPPort = 587
email.SMTPUser = your-email@gmail.com
email.SMTPPass = your-app-password
email.SMTPCrypto = tls

# ENCRYPTION
encryption.key = your-secret-key-here
encryption.driver = OpenSSL
```

### Step 4: Create Database

#### Method 1: Using MySQL CLI

```bash
# Import database schema
mysql -u root -p < database.sql

# Or if no password:
mysql -u root < database.sql
```

#### Method 2: Using phpMyAdmin

1. Open phpMyAdmin
2. Click "New"
3. Create database: `oms_codeigniter`
4. Go to "Import"
5. Select `database.sql` file
6. Click "Import"

### Step 5: Set File Permissions

For Linux/Mac:

```bash
# Make directories writable
chmod -R 755 public/assets/uploads
chmod -R 755 writable
chmod -R 755 writable/cache
chmod -R 755 writable/logs
chmod -R 755 writable/session

# If using Apache user:
sudo chown -R www-data:www-data public/assets/uploads
sudo chown -R www-data:www-data writable
```

For Windows:
- Right-click folder → Properties → Security
- Edit → Select user → Check "Full Control"

### Step 6: Configure Web Server

#### Apache (.htaccess)

```apache
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteBase /oms-codeigniter/
    
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    
    RewriteRule ^(.*)$ index.php?/$1 [L]
</IfModule>
```

#### Nginx

```nginx
server {
    listen 80;
    server_name localhost;
    root /var/www/oms-codeigniter/public;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/run/php/php8.0-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```

### Step 7: Verify Installation

```bash
# Test database connection
php spark db:ping

# Clear cache
php spark cache:clear

# Generate application key (if needed)
php spark generate:key
```

### Step 8: Access System

Open your browser and navigate to:

**Frontend Store:**
```
http://localhost/oms-codeigniter/
```

**Admin Dashboard:**
```
http://localhost/oms-codeigniter/admin
```

**Admin Login Page:**
```
http://localhost/oms-codeigniter/auth/login
```

### Step 9: Login

Use default credentials:

| Field | Value |
|-------|-------|
| Email | admin@oms.com |
| Password | admin123 |

**⚠️ IMPORTANT: Change admin password after first login!**

## Post-Installation Setup

### 1. Update Company Settings

Go to **Admin → Settings → General**:
- Company Name
- Company Email
- Company Phone
- Company Address
- Company Logo
- Currency Settings

### 2. Configure SMTP (Email)

Go to **Admin → Settings → Email**:
- SMTP Host: smtp.gmail.com (for Gmail)
- SMTP Port: 587
- SMTP Username: your-email@gmail.com
- SMTP Password: your-app-specific-password
- From Email: noreply@yourdomain.com

For Gmail:
1. Enable 2-Factor Authentication
2. Create App Password
3. Use app password in settings

### 3. Add Products

1. Go to **Admin → Products → Create**
2. Fill in product details
3. Upload featured image
4. Add gallery images (optional)
5. Set SKU, price, stock
6. Click Save

### 4. Add Customers

1. Go to **Admin → Customers → Create**
2. Enter customer details
3. Select city
4. Click Save

Or customers are created automatically when placing orders.

### 5. Configure WhatsApp

Edit WhatsApp number in **Admin → Settings → General**:
```
WhatsApp Number: +923001234567
```

This number will be used for order WhatsApp button.

## Troubleshooting

### Issue: Database Connection Error

**Solution:**
- Verify MySQL is running
- Check credentials in `.env`
- Ensure database user has all privileges

```bash
# Grant privileges
mysql -u root -p
GRANT ALL PRIVILEGES ON oms_codeigniter.* TO 'root'@'localhost';
FLUSH PRIVILEGES;
```

### Issue: Upload Permission Denied

**Solution:**
```bash
chmod -R 777 public/assets/uploads
chmod -R 777 writable
```

### Issue: CSRF Token Error

**Solution:**
- Clear browser cache and cookies
- Verify form has CSRF token field
- Check CSRF token name in `.env`

### Issue: Blank Admin Dashboard

**Solution:**
- Check PHP error logs: `writable/logs/`
- Enable debugging: `CI_ENVIRONMENT = development`
- Verify database tables exist

### Issue: Email Not Sending

**Solution:**
- Test SMTP credentials
- Enable "Less secure apps" (Gmail)
- Check firewall allows port 587
- Review email logs

### Issue: File Upload Fails

**Solution:**
- Increase `upload_max_filesize` in php.ini
- Increase `post_max_size` in php.ini
- Check folder permissions
- Verify GD library is enabled

## Performance Optimization

### 1. Enable Caching

Edit `.env`:
```env
cache.handler = redis
```

### 2. Set Query Logging

Edit `.env`:
```env
database.default.logging = false
```

### 3. Optimize Images

Use image optimization tools for faster loading.

### 4. Enable Compression

Add to Apache config:
```apache
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml
    AddOutputFilterByType DEFLATE text/css
    AddOutputFilterByType DEFLATE application/javascript
    AddOutputFilterByType DEFLATE application/x-javascript
</IfModule>
```

## Security Recommendations

### 1. Change Admin Password
Go to **Admin → Users** and change default password

### 2. Configure HTTPS
Update `app.baseURL` to use `https://`

### 3. Set Strong Encryption Key
```bash
php spark generate:key
```

### 4. Disable Debug Mode
Set `CI_ENVIRONMENT = production`

### 5. Regular Backups
Use **Admin → Backup** for daily backups

### 6. Update Dependencies
```bash
composer update
```

## Backup & Restore

### Create Backup

1. Go to **Admin → Backup**
2. Click "Create Backup"
3. Download SQL file

Or via command line:
```bash
mysqldump -u root -p oms_codeigniter > backup.sql
```

### Restore from Backup

1. Go to **Admin → Backup**
2. Select backup file
3. Click "Restore"

Or via command line:
```bash
mysql -u root -p oms_codeigniter < backup.sql
```

## Development Commands

```bash
# Start development server
php spark serve

# Run migrations
php spark migrate

# Run seeders
php spark db:seed ProductSeeder

# Clear cache
php spark cache:clear

# Generate model
php spark make:model ProductModel

# Generate controller
php spark make:controller Admin/Products
```

## Support & Help

- **Documentation:** See README.md
- **Issues:** GitHub Issues
- **Email:** support@oms.com
- **Website:** www.oms.com

## Common Tasks

### Add New Admin User

1. Go to **Admin → Users → Create**
2. Enter email and password
3. Select role
4. Click Save

### Change User Role

1. Go to **Admin → Users**
2. Click Edit on user
3. Change role
4. Click Save

### Export Orders

1. Go to **Admin → Orders**
2. Click "Export" button
3. Select format (CSV/Excel/PDF)
4. Download file

### Generate Invoice

1. Go to **Admin → Orders**
2. Find order and click "View"
3. Click "Print Invoice"
4. Select format (A4/Thermal)
5. Print or save as PDF

---

**Installation complete! 🎉**

You now have a fully functional Order Management System.

For more help, visit the documentation or contact support.
