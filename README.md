# Order Management System (OMS) - CodeIgniter 4

🚀 **Premium Order Management System** built with **CodeIgniter 4**, **MySQL**, **Bootstrap 5**, and **AJAX**.

Perfect for Pakistani eCommerce businesses!

---

## ✨ Key Features

### 🛍️ Frontend Store
- ✅ Public product catalog (responsive design)
- ✅ Advanced product search
- ✅ Product detail pages with gallery
- ✅ SEO-friendly URLs and meta tags
- ✅ WhatsApp order integration
- ✅ Mobile-first responsive design

### 📊 Admin Panel
- ✅ **Dashboard** - KPI cards, charts, recent orders
- ✅ **Orders Management** - Full CRUD with status tracking
- ✅ **Customers Management** - Customer profiles and history
- ✅ **Products Management** - SKU, categories, pricing, inventory
- ✅ **Suppliers Management** - Supplier details and records
- ✅ **Reports** - Sales, orders, customers, stock, profit
- ✅ **Settings** - Company info, SMTP, currency
- ✅ **User Management** - Roles: Super Admin, Admin, Staff, Viewer
- ✅ **Audit Logs** - Track all actions
- ✅ **Database Backup & Restore**

### 🔐 Security
- ✅ CSRF Protection
- ✅ XSS Filtering
- ✅ SQL Injection Protection
- ✅ Secure Password Hashing (bcrypt)
- ✅ Role-Based Access Control
- ✅ Secure File Uploads
- ✅ Session Management

### 🎨 Modern UI/UX
- ✅ Bootstrap 5 responsive design
- ✅ AdminLTE-style dashboard
- ✅ Professional charts (Chart.js)
- ✅ Toastr notifications
- ✅ SweetAlert2 confirmations
- ✅ Mobile-responsive interface

---

## 📋 System Requirements

- PHP 7.4+ (8.0+ recommended)
- MySQL 5.7+ or MariaDB 10.2+
- Composer
- Apache/Nginx with mod_rewrite
- GD Library for images
- cURL extension

---

## 🚀 Quick Start

### 1️⃣ Download & Extract

```bash
git clone https://github.com/officialshanabbasi/oms-codeigniter.git
cd oms-codeigniter
```

### 2️⃣ Install Dependencies

```bash
composer install
```

### 3️⃣ Configure Environment

```bash
cp .env .env.local
```

Edit `.env` with your database credentials:

```env
database.default.hostname = localhost
database.default.database = oms_codeigniter
database.default.username = root
database.default.password = 
```

### 4️⃣ Import Database

```bash
mysql -u root -p < database.sql
```

### 5️⃣ Set Permissions

```bash
chmod -R 755 public/assets/uploads writable
```

### 6️⃣ Access System

**Frontend:** `http://localhost/oms-codeigniter/`
**Admin:** `http://localhost/oms-codeigniter/admin`
**Login:** `admin@oms.com` / `admin123`

---

## 📊 Database Tables (16 Tables)

```
✅ users
✅ categories
✅ brands
✅ products
✅ product_gallery
✅ customers
✅ orders
✅ order_items
✅ suppliers
✅ purchases
✅ purchase_items
✅ audit_logs
✅ settings
✅ email_templates
✅ backup_logs
✅ payment_logs
```

---

## 📁 Project Structure

```
oms-codeigniter/
├── app/
│   ├── Controllers/
│   │   ├── Auth.php
│   │   ├── BaseController.php
│   │   ├── Admin/
│   │   │   ├── Dashboard.php
│   │   │   ├── Orders.php
│   │   │   ├── Customers.php
│   │   │   ├── Products.php
│   │   │   └── Settings.php
│   │   └── Frontend/
│   │       ├── Home.php
│   │       └── Products.php
│   ├── Models/
│   │   ├── ProductModel.php
│   │   ├── OrderModel.php
│   │   ├── CustomerModel.php
│   │   ├── UserModel.php
│   │   └── ...
│   ├── Views/
│   ├── Filters/
│   │   ├── AuthFilter.php
│   │   └── RoleFilter.php
│   ├── Helpers/
│   │   ├── auth_helper.php
│   │   └── format_helper.php
│   └── Config/
│       └── Routes.php
├── public/
│   ├── index.php
│   ├── .htaccess
│   └── assets/
│       ├── css/
│       │   ├── admin.css
│       │   └── frontend.css
│       ├── js/
│       │   └── script.js
│       ├── images/
│       └── uploads/
├── writable/
├── database.sql
├── composer.json
├── .env
└── README.md
```

---

## 👤 Default Login

| Field | Value |
|-------|-------|
| **Email** | admin@oms.com |
| **Password** | admin123 |
| **Role** | Super Admin |

⚠️ **Change password after first login!**

---

## 🎯 User Roles

| Role | Permissions |
|------|-------------|
| **Super Admin** | Full access to all modules |
| **Admin** | Orders, Customers, Products, Reports |
| **Staff** | Orders, Customers |
| **Viewer** | Reports only (read-only) |

---

## 🔧 Key Technologies

- **Backend:** CodeIgniter 4 (PHP Framework)
- **Database:** MySQL 5.7+
- **Frontend:** Bootstrap 5, HTML5, CSS3, JavaScript
- **Charts:** Chart.js
- **Notifications:** Toastr, SweetAlert2
- **Icons:** Bootstrap Icons
- **Package Manager:** Composer

---

## 📖 Installation & Setup Guide

See **INSTALLATION.md** for detailed step-by-step instructions.

---

## 🎨 Features Included

### Orders Module
- ✅ Create/Edit/Delete orders
- ✅ Order status tracking (7 statuses)
- ✅ Payment status management
- ✅ Courier tracking
- ✅ Bulk actions
- ✅ Print invoices
- ✅ Export CSV/Excel/PDF
- ✅ Filter by status

### Customers Module
- ✅ Add/Edit/Delete customers
- ✅ Search by name/phone/city
- ✅ Customer profiles
- ✅ Total orders & spending
- ✅ Order history
- ✅ Customer status (New/Regular/VIP)

### Products Module
- ✅ Add/Edit/Delete products
- ✅ SKU generation
- ✅ Category & brand assignment
- ✅ Stock management
- ✅ Low stock alerts
- ✅ Featured images & gallery
- ✅ Product videos
- ✅ SEO fields (meta tags)
- ✅ CSV import/export

### Reports Module
- ✅ Sales Reports
- ✅ Order Reports
- ✅ Customer Reports
- ✅ Stock Reports
- ✅ Profit Reports
- ✅ Courier Performance
- ✅ Cancelled Orders Analysis

---

## 💡 Configuration

### SMTP Setup

Edit **Admin → Settings → Email**:

```
SMTP Host: smtp.gmail.com
Port: 587
Username: your-email@gmail.com
Password: your-app-password
```

### WhatsApp Integration

Edit **Admin → Settings**:
```
WhatsApp Number: +923001234567
```

### Company Settings

Edit **Admin → Settings → General**:
- Company Name
- Company Email & Phone
- Company Address
- Currency
- Timezone

---

## 🔒 Security Features

✅ **CSRF Token Protection** - Every form protected
✅ **XSS Filtering** - Input validation and sanitization
✅ **SQL Injection Prevention** - Parameterized queries
✅ **Password Security** - bcrypt hashing
✅ **Session Security** - Encrypted sessions
✅ **File Upload Security** - Validated uploads
✅ **Role-Based Access** - Permission checks
✅ **Audit Logging** - Track all actions

---

## 🐛 Troubleshooting

### Database Connection Error
```bash
# Verify MySQL is running and credentials are correct
mysql -u root -p
```

### Permission Error
```bash
chmod -R 755 public/assets/uploads
chmod -R 755 writable
```

### CSRF Token Error
- Clear browser cache and cookies
- Verify form has CSRF token field

### Blank Dashboard
- Check `writable/logs/` for error logs
- Enable debug mode in `.env`

---

## 📞 Support & Help

- **Documentation:** See INSTALLATION.md
- **Email:** support@oms.com
- **Website:** www.oms.com
- **GitHub Issues:** Report bugs on GitHub

---

## 📝 License

MIT License - Open source and free to use

---

## 👨‍💻 Author

**Official Shan Abbasi**
- GitHub: [@officialshanabbasi](https://github.com/officialshanabbasi)
- Email: contact@officialshanabbasi.com

---

## 🌟 Give it a Star!

If you find this project helpful, please give it a ⭐ on GitHub!

---

**Built with ❤️ for Pakistani eCommerce Businesses**

**Version:** 1.0.0
**Last Updated:** May 2026
**Status:** ✅ Production Ready
