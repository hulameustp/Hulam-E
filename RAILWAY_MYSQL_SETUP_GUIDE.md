# 🚀 Railway MySQL Setup Guide

## Step-by-Step Database Setup

### Step 1: Connect to Railway MySQL
```bash
railway connect MySQL
```

### Step 2: Execute These Commands One by One

Copy and paste each command into the MySQL shell:

#### 1. Create and Use Database
```sql
CREATE DATABASE IF NOT EXISTS hulame_db;
USE hulame_db;
```

#### 2. Set SQL Mode
```sql
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
```

#### 3. Create Cache Tables
```sql
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### 4. Create Contact Messages Table
```sql
CREATE TABLE `contact_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rental_id` bigint(20) UNSIGNED NOT NULL,
  `rental_title` varchar(255) NOT NULL,
  `owner_email` varchar(255) NOT NULL,
  `sender_name` varchar(255) NOT NULL,
  `sender_email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### 5. Create Jobs Tables
```sql
CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### 6. Create Migrations Table
```sql
CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2023_06_02_000000_create_rentals_table', 1),
(5, '2023_06_02_000001_add_role_and_verified_to_users_table', 1),
(6, '2025_06_02_152721_create_personal_access_tokens_table', 2),
(7, '2025_06_02_170931_add_profile_fields_to_users_table', 3),
(8, '2025_06_02_195129_add_status_to_rentals_table', 4),
(10, '2025_06_03_005559_add_verification_fields_to_users_table', 5),
(11, '2025_06_03_020300_create_contact_messages_table', 6),
(12, '2025_06_03_030629_create_transactions_table', 7),
(13, '2025_06_03_030746_update_notifications_table_for_rentals', 8),
(14, '2025_06_03_062256_create_notifications_table', 9),
(15, '2025_06_04_080335_fix_transaction_amount_field', 10),
(16, '2025_06_04_161809_update_existing_verification_status_to_unverified', 10),
(17, '2025_06_05_000000_fix_verification_status_default', 10),
(18, '2025_06_05_000001_fix_verification_status_mysql', 10),
(19, '2025_06_06_000000_create_rental_images_table', 10);
```

#### 7. Create Notifications Table
```sql
CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### 8. Create Password Reset Tokens Table
```sql
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### 9. Create Personal Access Tokens Table
```sql
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### 10. Create Users Table
```sql
CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'user',
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `course_year` varchar(100) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `social_link` varchar(500) DEFAULT NULL,
  `profile_picture` text DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `website` varchar(500) DEFAULT NULL,
  `skills` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`skills`)),
  `education` text DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT 0.0,
  `total_ratings` int(11) DEFAULT 0,
  `is_online` tinyint(1) DEFAULT 0,
  `last_seen` timestamp NULL DEFAULT NULL,
  `show_email` tinyint(1) DEFAULT 0,
  `show_contact` tinyint(1) DEFAULT 1,
  `show_social_link` tinyint(1) DEFAULT 1,
  `profile_completion` int(11) DEFAULT 0,
  `verification_document` text DEFAULT NULL,
  `verification_document_type` varchar(50) DEFAULT NULL,
  `verification_submitted_at` timestamp NULL DEFAULT NULL,
  `verification_reviewed_at` timestamp NULL DEFAULT NULL,
  `verification_status` varchar(20) NOT NULL DEFAULT 'unverified',
  `verification_notes` text DEFAULT NULL,
  `verified_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### 11. Create Rentals Table
```sql
CREATE TABLE `rentals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `location` varchar(255) NOT NULL,
  `image` text DEFAULT NULL,
  `status` enum('available','rented','unavailable') NOT NULL DEFAULT 'available',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### 12. Create Rental Images Table
```sql
CREATE TABLE `rental_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rental_id` bigint(20) UNSIGNED NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### 13. Create Rental Messages Table
```sql
CREATE TABLE `rental_messages` (
  `id` int(11) NOT NULL,
  `rental_id` int(11) NOT NULL,
  `renter_email` varchar(255) NOT NULL,
  `sender_name` varchar(255) NOT NULL,
  `sender_email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `rental_title` varchar(500) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### 14. Create Sessions Table
```sql
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### 15. Create Transactions Table
```sql
CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rental_id` bigint(20) UNSIGNED DEFAULT NULL,
  `renter_id` bigint(20) UNSIGNED DEFAULT NULL,
  `owner_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('pending','approved','rejected','completed','cancelled') NOT NULL DEFAULT 'pending',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  `renter_message` text DEFAULT NULL,
  `owner_response` text DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `rejected_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### 16. Add Indexes and Constraints
```sql
-- Indexes for cache
ALTER TABLE `cache` ADD PRIMARY KEY (`key`);
ALTER TABLE `cache_locks` ADD PRIMARY KEY (`key`);

-- Indexes for contact_messages
ALTER TABLE `contact_messages` ADD PRIMARY KEY (`id`);
ALTER TABLE `contact_messages` ADD KEY `contact_messages_rental_id_sent_at_index` (`rental_id`,`sent_at`);
ALTER TABLE `contact_messages` ADD KEY `contact_messages_owner_email_index` (`owner_email`);
ALTER TABLE `contact_messages` ADD KEY `contact_messages_sender_email_index` (`sender_email`);

-- Indexes for jobs
ALTER TABLE `failed_jobs` ADD PRIMARY KEY (`id`);
ALTER TABLE `failed_jobs` ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);
ALTER TABLE `jobs` ADD PRIMARY KEY (`id`);
ALTER TABLE `jobs` ADD KEY `jobs_queue_index` (`queue`);
ALTER TABLE `job_batches` ADD PRIMARY KEY (`id`);

-- Indexes for migrations
ALTER TABLE `migrations` ADD PRIMARY KEY (`id`);

-- Indexes for notifications
ALTER TABLE `notifications` ADD PRIMARY KEY (`id`);
ALTER TABLE `notifications` ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

-- Indexes for password_reset_tokens
ALTER TABLE `password_reset_tokens` ADD PRIMARY KEY (`email`);

-- Indexes for personal_access_tokens
ALTER TABLE `personal_access_tokens` ADD PRIMARY KEY (`id`);
ALTER TABLE `personal_access_tokens` ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`);
ALTER TABLE `personal_access_tokens` ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

-- Indexes for rentals
ALTER TABLE `rentals` ADD PRIMARY KEY (`id`);
ALTER TABLE `rentals` ADD KEY `rentals_user_id_foreign` (`user_id`);

-- Indexes for rental_images
ALTER TABLE `rental_images` ADD PRIMARY KEY (`id`);
ALTER TABLE `rental_images` ADD KEY `rental_images_rental_id_index` (`rental_id`);

-- Indexes for rental_messages
ALTER TABLE `rental_messages` ADD PRIMARY KEY (`id`);
ALTER TABLE `rental_messages` ADD KEY `idx_rental_id` (`rental_id`);
ALTER TABLE `rental_messages` ADD KEY `idx_renter_email` (`renter_email`);

-- Indexes for sessions
ALTER TABLE `sessions` ADD PRIMARY KEY (`id`);
ALTER TABLE `sessions` ADD KEY `sessions_user_id_index` (`user_id`);
ALTER TABLE `sessions` ADD KEY `sessions_last_activity_index` (`last_activity`);

-- Indexes for transactions
ALTER TABLE `transactions` ADD PRIMARY KEY (`id`);
ALTER TABLE `transactions` ADD KEY `transactions_renter_id_status_index` (`renter_id`,`status`);
ALTER TABLE `transactions` ADD KEY `transactions_owner_id_status_index` (`owner_id`,`status`);
ALTER TABLE `transactions` ADD KEY `transactions_rental_id_foreign` (`rental_id`);

-- Indexes for users
ALTER TABLE `users` ADD PRIMARY KEY (`id`);
ALTER TABLE `users` ADD UNIQUE KEY `users_email_unique` (`email`);
ALTER TABLE `users` ADD KEY `idx_verified_role` (`verified`,`role`);
ALTER TABLE `users` ADD KEY `idx_last_seen` (`last_seen`);
ALTER TABLE `users` ADD KEY `idx_rating` (`rating`);
ALTER TABLE `users` ADD KEY `users_verification_submitted_at_index` (`verification_submitted_at`);
ALTER TABLE `users` ADD KEY `users_verified_by_foreign` (`verified_by`);
ALTER TABLE `users` ADD KEY `users_verification_status_index` (`verification_status`);
```

#### 17. Set Auto Increment Values
```sql
-- Set AUTO_INCREMENT values
ALTER TABLE `contact_messages` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `failed_jobs` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `jobs` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `migrations` MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
ALTER TABLE `personal_access_tokens` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `rentals` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `rental_images` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `rental_messages` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `transactions` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `users` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
```

#### 18. Add Foreign Key Constraints
```sql
-- Add foreign key constraints
ALTER TABLE `contact_messages` ADD CONSTRAINT `contact_messages_rental_id_foreign` FOREIGN KEY (`rental_id`) REFERENCES `rentals` (`id`) ON DELETE CASCADE;
ALTER TABLE `rentals` ADD CONSTRAINT `rentals_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
ALTER TABLE `rental_images` ADD CONSTRAINT `rental_images_rental_id_foreign` FOREIGN KEY (`rental_id`) REFERENCES `rentals` (`id`) ON DELETE CASCADE;
ALTER TABLE `transactions` ADD CONSTRAINT `transactions_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
ALTER TABLE `transactions` ADD CONSTRAINT `transactions_rental_id_foreign` FOREIGN KEY (`rental_id`) REFERENCES `rentals` (`id`) ON DELETE CASCADE;
ALTER TABLE `transactions` ADD CONSTRAINT `transactions_renter_id_foreign` FOREIGN KEY (`renter_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
ALTER TABLE `users` ADD CONSTRAINT `users_verified_by_foreign` FOREIGN KEY (`verified_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;
```

#### 19. Commit the Transaction
```sql
COMMIT;
```

### Step 3: Verify Database Setup
```sql
SHOW TABLES;
```

You should see all the tables created successfully.

### Step 4: Exit MySQL
```sql
EXIT;
```

## 🎯 Next Steps

After setting up the database:
1. Get the database credentials from Railway
2. Add them to Vercel environment variables
3. Deploy your backend on Vercel
4. Deploy your frontend on Vercel

## 📝 Notes

- Execute each command one by one
- Make sure to end each command with `;`
- If you get an error, check the syntax and try again
- The database will be ready for your Laravel application 