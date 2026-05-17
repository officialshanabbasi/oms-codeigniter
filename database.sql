-- =====================================================
-- ORDER MANAGEMENT SYSTEM (OMS) - CodeIgniter 4
-- Database Schema with Sample Data
-- =====================================================

DROP DATABASE IF EXISTS `oms_codeigniter`;
CREATE DATABASE `oms_codeigniter` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `oms_codeigniter`;

-- =====================================================
-- TABLE: users
-- =====================================================
CREATE TABLE `users` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) UNIQUE NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role` ENUM('super_admin','admin','staff','viewer') DEFAULT 'staff',
  `status` ENUM('active','inactive') DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  INDEX `role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: categories
-- =====================================================
CREATE TABLE `categories` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL UNIQUE,
  `slug` VARCHAR(100) UNIQUE NOT NULL,
  `description` TEXT,
  `image` VARCHAR(255),
  `status` ENUM('active','inactive') DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  INDEX `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: brands
-- =====================================================
CREATE TABLE `brands` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL UNIQUE,
  `slug` VARCHAR(100) UNIQUE NOT NULL,
  `logo` VARCHAR(255),
  `status` ENUM('active','inactive') DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  INDEX `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: products
-- =====================================================
CREATE TABLE `products` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `sku` VARCHAR(50) UNIQUE NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `slug` VARCHAR(200) UNIQUE NOT NULL,
  `category_id` INT NOT NULL,
  `brand_id` INT,
  `description` LONGTEXT,
  `purchase_price` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `sale_price` DECIMAL(10,2) NOT NULL,
  `discount` DECIMAL(5,2) DEFAULT 0,
  `stock_quantity` INT DEFAULT 0,
  `low_stock_alert` INT DEFAULT 5,
  `featured_image` VARCHAR(255),
  `video_url` VARCHAR(255),
  `meta_title` VARCHAR(160),
  `meta_description` VARCHAR(160),
  `meta_keywords` VARCHAR(160),
  `status` ENUM('active','inactive') DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`) ON DELETE RESTRICT,
  FOREIGN KEY (`brand_id`) REFERENCES `brands`(`id`) ON DELETE SET NULL,
  INDEX `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: product_gallery
-- =====================================================
CREATE TABLE `product_gallery` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  `display_order` INT DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE,
  INDEX `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: customers
-- =====================================================
CREATE TABLE `customers` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100),
  `phone` VARCHAR(20) NOT NULL UNIQUE,
  `city` VARCHAR(50),
  `address` TEXT,
  `status` ENUM('new','regular','vip') DEFAULT 'new',
  `is_product_not_available` TINYINT DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  INDEX `phone` (`phone`),
  INDEX `email` (`email`),
  INDEX `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: orders
-- =====================================================
CREATE TABLE `orders` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `order_number` VARCHAR(50) UNIQUE NOT NULL,
  `customer_id` INT NOT NULL,
  `order_date` DATETIME NOT NULL,
  `total_amount` DECIMAL(12,2) NOT NULL,
  `discount` DECIMAL(10,2) DEFAULT 0,
  `shipping_charge` DECIMAL(10,2) DEFAULT 0,
  `payment_status` ENUM('pending','paid','failed') DEFAULT 'pending',
  `order_status` ENUM('pending','confirmed','packed','shipped','delivered','cancelled','returned') DEFAULT 'pending',
  `status_reason` VARCHAR(255),
  `courier` VARCHAR(100),
  `tracking_number` VARCHAR(100),
  `cancellation_reason` TEXT,
  `notes` TEXT,
  `user_id` INT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE RESTRICT,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL,
  INDEX `order_number` (`order_number`),
  INDEX `order_status` (`order_status`),
  INDEX `payment_status` (`payment_status`),
  INDEX `customer_id` (`customer_id`),
  INDEX `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: order_items
-- =====================================================
CREATE TABLE `order_items` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `unit_price` DECIMAL(10,2) NOT NULL,
  `discount` DECIMAL(10,2) DEFAULT 0,
  `total` DECIMAL(12,2) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE RESTRICT,
  INDEX `order_id` (`order_id`),
  INDEX `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: suppliers
-- =====================================================
CREATE TABLE `suppliers` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100),
  `phone` VARCHAR(20),
  `city` VARCHAR(50),
  `address` TEXT,
  `bank_details` TEXT,
  `status` ENUM('active','inactive') DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  INDEX `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: purchases
-- =====================================================
CREATE TABLE `purchases` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `purchase_number` VARCHAR(50) UNIQUE NOT NULL,
  `supplier_id` INT NOT NULL,
  `purchase_date` DATETIME NOT NULL,
  `total_amount` DECIMAL(12,2) NOT NULL,
  `discount` DECIMAL(10,2) DEFAULT 0,
  `payment_status` ENUM('pending','paid','partial') DEFAULT 'pending',
  `notes` TEXT,
  `user_id` INT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  FOREIGN KEY (`supplier_id`) REFERENCES `suppliers`(`id`) ON DELETE RESTRICT,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL,
  INDEX `purchase_number` (`purchase_number`),
  INDEX `supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: purchase_items
-- =====================================================
CREATE TABLE `purchase_items` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `purchase_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `unit_price` DECIMAL(10,2) NOT NULL,
  `discount` DECIMAL(10,2) DEFAULT 0,
  `total` DECIMAL(12,2) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`purchase_id`) REFERENCES `purchases`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE RESTRICT,
  INDEX `purchase_id` (`purchase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: audit_logs
-- =====================================================
CREATE TABLE `audit_logs` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT,
  `action` VARCHAR(50) NOT NULL,
  `entity` VARCHAR(50) NOT NULL,
  `entity_id` INT,
  `old_data` JSON,
  `new_data` JSON,
  `ip_address` VARCHAR(50),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL,
  INDEX `user_id` (`user_id`),
  INDEX `entity` (`entity`),
  INDEX `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: settings
-- =====================================================
CREATE TABLE `settings` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `key` VARCHAR(100) UNIQUE NOT NULL,
  `value` LONGTEXT,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: email_templates
-- =====================================================
CREATE TABLE `email_templates` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL UNIQUE,
  `subject` VARCHAR(200) NOT NULL,
  `body` LONGTEXT NOT NULL,
  `variables` JSON,
  `status` ENUM('active','inactive') DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: backup_logs
-- =====================================================
CREATE TABLE `backup_logs` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `filename` VARCHAR(255) NOT NULL,
  `file_size` BIGINT,
  `user_id` INT,
  `status` ENUM('success','failed') DEFAULT 'success',
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL,
  INDEX `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- SAMPLE DATA INSERTION
-- =====================================================

-- Insert Admin User (Password: admin123 hashed with bcrypt)
INSERT INTO `users` (`name`, `email`, `password`, `role`, `status`) VALUES
('Super Admin', 'admin@oms.com', '$2y$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lm', 'super_admin', 'active'),
('Admin User', 'admin2@oms.com', '$2y$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lm', 'admin', 'active'),
('Staff User', 'staff@oms.com', '$2y$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lm', 'staff', 'active');

-- Insert Categories
INSERT INTO `categories` (`name`, `slug`, `description`, `status`) VALUES
('Electronics', 'electronics', 'Electronic devices and gadgets', 'active'),
('Clothing', 'clothing', 'Men and women clothing', 'active'),
('Home & Garden', 'home-garden', 'Home and garden products', 'active'),
('Sports & Outdoors', 'sports-outdoors', 'Sports and outdoor equipment', 'active'),
('Books & Media', 'books-media', 'Books, magazines, and media', 'active');

-- Insert Brands
INSERT INTO `brands` (`name`, `slug`, `status`) VALUES
('Samsung', 'samsung', 'active'),
('Apple', 'apple', 'active'),
('Sony', 'sony', 'active'),
('LG', 'lg', 'active'),
('Dell', 'dell', 'active'),
('HP', 'hp', 'active');

-- Insert Products
INSERT INTO `products` (`sku`, `name`, `slug`, `category_id`, `brand_id`, `description`, `purchase_price`, `sale_price`, `discount`, `stock_quantity`, `low_stock_alert`, `status`, `meta_title`, `meta_description`, `meta_keywords`) VALUES
('SKU000001', 'Samsung 55" Smart TV', 'samsung-55-smart-tv', 1, 1, 'High quality 55 inch smart television with 4K resolution', 35000.00, 45000.00, 10, 50, 5, 'active', 'Samsung 55 Smart TV', 'Buy Samsung 55 inch Smart TV online', 'Samsung TV, 4K TV'),
('SKU000002', 'iPhone 14 Pro', 'iphone-14-pro', 1, 2, 'Latest iPhone 14 Pro with A16 Bionic chip', 120000.00, 155000.00, 5, 30, 5, 'active', 'iPhone 14 Pro', 'Buy iPhone 14 Pro Online', 'Apple, iPhone 14'),
('SKU000003', 'Sony Headphones', 'sony-headphones', 1, 3, 'High quality wireless Sony headphones', 8000.00, 12000.00, 15, 100, 10, 'active', 'Sony Wireless Headphones', 'Premium Sony Headphones', 'Sony, Headphones'),
('SKU000004', 'Winter Jacket', 'winter-jacket', 2, NULL, 'Warm and comfortable winter jacket', 3000.00, 5000.00, 0, 200, 20, 'active', 'Winter Jacket', 'Buy winter jacket online', 'Jacket, Winter'),
('SKU000005', 'Cotton T-Shirt', 'cotton-t-shirt', 2, NULL, 'High quality cotton t-shirt', 500.00, 999.00, 0, 500, 50, 'active', 'Cotton T-Shirt', 'Comfortable cotton t-shirt', 'T-Shirt, Cotton'),
('SKU000006', 'Bed Sheet Set', 'bed-sheet-set', 3, NULL, 'Premium bed sheet set for comfort', 2000.00, 3500.00, 0, 75, 10, 'active', 'Bed Sheet Set', 'Quality bed sheet set', 'Bedding, Sheets'),
('SKU000007', 'Sports Ball', 'sports-ball', 4, NULL, 'Professional sports ball', 1000.00, 1500.00, 0, 150, 20, 'active', 'Sports Ball', 'Professional sports ball', 'Sports, Ball'),
('SKU000008', 'Self Help Book', 'self-help-book', 5, NULL, 'Motivational self help book', 800.00, 1200.00, 0, 80, 10, 'active', 'Self Help Book', 'Popular self help book', 'Books, Self Help');

-- Insert Customers
INSERT INTO `customers` (`name`, `email`, `phone`, `city`, `address`, `status`) VALUES
('Ahmed Ali', 'ahmed@example.com', '+923001234567', 'Karachi', 'House 123, Street ABC, Karachi', 'regular'),
('Fatima Khan', 'fatima@example.com', '+923005678901', 'Lahore', 'Apartment 456, Defense, Lahore', 'new'),
('Hassan Muhammad', 'hassan@example.com', '+923009876543', 'Islamabad', 'Office 789, G9, Islamabad', 'vip'),
('Ayesha Ahmed', 'ayesha@example.com', '+923012345678', 'Multan', 'Shop 321, Mall Road, Multan', 'regular'),
('Muhammad Saeed', 'saeed@example.com', '+923014567890', 'Peshawar', 'House 654, Hayatabad, Peshawar', 'new');

-- Insert Suppliers
INSERT INTO `suppliers` (`name`, `email`, `phone`, `city`, `address`, `status`) VALUES
('Tech Wholesale Co', 'supply@techwholesale.com', '+923211234567', 'Karachi', 'Industrial Area, Karachi', 'active'),
('Fashion Imports Ltd', 'orders@fashionimports.com', '+923219876543', 'Lahore', 'Business District, Lahore', 'active'),
('Home Goods Distributor', 'sales@homegoods.com', '+923214567890', 'Islamabad', 'Trade Center, Islamabad', 'active');

-- Insert Settings
INSERT INTO `settings` (`key`, `value`) VALUES
('company_name', 'Order Management System'),
('company_email', 'info@oms.com'),
('company_phone', '+92-300-1234567'),
('company_address', 'Karachi, Pakistan'),
('company_logo', 'logo.png'),
('currency', 'PKR'),
('currency_symbol', 'Rs'),
('smtp_host', 'smtp.gmail.com'),
('smtp_port', '587'),
('smtp_username', 'your-email@gmail.com'),
('smtp_password', 'your-password'),
('smtp_from', 'noreply@oms.com'),
('whatsapp_number', '+92-300-1234567'),
('timezone', 'Asia/Karachi'),
('date_format', 'Y-m-d'),
('items_per_page', '10'),
('tax_percentage', '17'),
('shipping_charge_flat', '300');

-- Insert Email Templates
INSERT INTO `email_templates` (`name`, `subject`, `body`, `status`) VALUES
('order_confirmation', 'Order Confirmation - {order_number}', '<h2>Thank you for your order!</h2><p>Order Number: {order_number}</p><p>Total Amount: Rs {total_amount}</p>', 'active'),
('order_shipped', 'Your Order Has Been Shipped - {order_number}', '<h2>Your order has been shipped!</h2><p>Tracking Number: {tracking_number}</p><p>Courier: {courier}</p>', 'active'),
('order_delivered', 'Order Delivered - {order_number}', '<h2>Your order has been delivered!</h2><p>Thank you for shopping with us!</p>', 'active');

-- =====================================================
-- Database Setup Complete!
-- Default Credentials:
-- Email: admin@oms.com
-- Password: admin123
-- =====================================================
