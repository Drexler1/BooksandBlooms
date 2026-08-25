-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 25, 2026 at 04:50 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pos_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `full_name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `username_hash` varchar(64) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_settings`
--

CREATE TABLE `app_settings` (
  `setting_key` varchar(100) NOT NULL,
  `setting_value` varchar(500) NOT NULL DEFAULT '',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_settings`
--

INSERT INTO `app_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES
('late_grace_minutes', '10', '2026-05-19 13:49:20'),
('late_per_minute_rate', '0.7500', '2026-05-24 04:55:32');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `attendance_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `shift_type` varchar(50) DEFAULT NULL,
  `clock_in` datetime DEFAULT NULL,
  `clock_out` datetime DEFAULT NULL,
  `attendance_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `hours_worked` decimal(10,4) NOT NULL DEFAULT 0.0000,
  `hourly_rate_snapshot` decimal(10,2) NOT NULL DEFAULT 0.00,
  `daily_earnings` decimal(10,2) NOT NULL DEFAULT 0.00,
  `pay_period_start` date DEFAULT NULL,
  `pay_period_end` date DEFAULT NULL,
  `daily_pay` decimal(10,2) DEFAULT NULL,
  `late_minutes` int(11) NOT NULL DEFAULT 0,
  `late_deduction` decimal(10,2) NOT NULL DEFAULT 0.00,
  `deduction_waived` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(80) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `created_at`) VALUES
(53, 'Coffee', '2026-08-05 14:56:04'),
(59, 'Pasta & Snacks', '2026-08-10 14:46:07'),
(60, 'Combo Meals', '2026-08-11 05:06:29'),
(61, 'Rice Meals', '2026-08-11 05:07:35'),
(62, 'Cakes & Pastries', '2026-08-11 05:09:00'),
(63, 'Ala Carte', '2026-08-11 05:26:01');

-- --------------------------------------------------------

--
-- Table structure for table `email_alert_settings`
--

CREATE TABLE `email_alert_settings` (
  `id` int(11) NOT NULL,
  `smtp_host` varchar(255) NOT NULL DEFAULT '',
  `smtp_port` smallint(6) NOT NULL DEFAULT 587,
  `smtp_user` varchar(255) NOT NULL DEFAULT '',
  `smtp_password` varchar(255) NOT NULL DEFAULT '',
  `smtp_use_tls` tinyint(1) NOT NULL DEFAULT 1,
  `alert_recipient` varchar(255) NOT NULL DEFAULT '',
  `low_stock_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `low_stock_threshold` int(11) NOT NULL DEFAULT 5,
  `daily_summary_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `daily_summary_time` varchar(5) NOT NULL DEFAULT '22:30',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `overtime_request_enabled` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `email_alert_settings`
--

INSERT INTO `email_alert_settings` (`id`, `smtp_host`, `smtp_port`, `smtp_user`, `smtp_password`, `smtp_use_tls`, `alert_recipient`, `low_stock_enabled`, `low_stock_threshold`, `daily_summary_enabled`, `daily_summary_time`, `updated_at`, `overtime_request_enabled`) VALUES
(1, 'smtp.gmail.com', 587, 'patrimoniodrexler1@gmail.com', 'nlpx zczw mcgv xhzg', 1, 'patrimoniodrexler1@gmail.com', 1, 2, 1, '10:20', '2026-08-04 17:48:15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `application_id` int(11) DEFAULT NULL,
  `full_name` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `role` enum('admin','manager','cashier') NOT NULL DEFAULT 'cashier',
  `employment_status` enum('active','inactive','terminated') DEFAULT 'active',
  `face_image_path` varchar(255) DEFAULT NULL,
  `face_model_path` mediumtext DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `disabled_at` datetime DEFAULT NULL,
  `username_hash` varchar(64) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `hourly_rate` decimal(10,2) NOT NULL DEFAULT 0.00,
  `email` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees_trash`
--

CREATE TABLE `employees_trash` (
  `trash_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `username_hash` varchar(64) DEFAULT NULL,
  `password` varchar(255) NOT NULL DEFAULT '',
  `password_hash` varchar(255) DEFAULT NULL,
  `role` enum('admin','manager','cashier') NOT NULL DEFAULT 'cashier',
  `face_image_path` varchar(255) DEFAULT NULL,
  `face_model_path` mediumtext DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `disabled_at` datetime NOT NULL DEFAULT current_timestamp(),
  `delete_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_applications`
--

CREATE TABLE `employee_applications` (
  `application_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `role` enum('admin','manager','cashier') NOT NULL DEFAULT 'cashier',
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `face_mismatch_log`
--

CREATE TABLE `face_mismatch_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(11) NOT NULL,
  `attempted_at` datetime NOT NULL DEFAULT current_timestamp(),
  `distance_score` float DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `face_mismatch_log`
--

INSERT INTO `face_mismatch_log` (`id`, `employee_id`, `attempted_at`, `distance_score`, `ip_address`, `user_agent`) VALUES
(1, 1, '2026-03-25 08:55:09', 0.6711, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(2, 1, '2026-03-25 08:55:32', 0.6885, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(3, 1, '2026-03-25 08:55:45', 0.7331, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(4, 1, '2026-03-25 12:33:22', 0.3156, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(5, 1, '2026-03-25 12:33:28', 0.8002, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(6, 1, '2026-03-25 12:33:43', 0.4578, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(7, 1, '2026-03-25 12:33:53', 0.4503, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(8, 1, '2026-03-25 12:33:58', 0.301, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(9, 1, '2026-03-25 12:34:04', 0.3761, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(10, 1, '2026-03-25 12:35:08', 0.4677, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(11, 2, '2026-03-25 12:36:56', 0.3106, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(12, 2, '2026-03-25 12:37:13', 0.367, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(13, 2, '2026-03-25 12:38:00', 0.4079, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(14, 2, '2026-03-25 12:38:14', 0.6877, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(15, 2, '2026-03-25 12:39:01', 0.3209, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(16, 2, '2026-03-25 12:39:20', 0.3051, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(17, 2, '2026-03-25 12:39:39', 0.7074, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(18, 2, '2026-03-25 12:42:29', 0.6511, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(19, 2, '2026-03-25 12:42:33', 0.6217, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(20, 2, '2026-03-25 12:42:35', 0.6179, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(21, 2, '2026-03-25 13:23:52', 0.6914, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(22, 2, '2026-03-25 13:24:06', 0.6406, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(23, 2, '2026-03-25 14:28:32', 0.662, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(24, 2, '2026-03-25 14:30:42', 0.6833, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(25, 2, '2026-03-25 15:00:52', 0.4435, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(26, 3, '2026-03-25 15:00:56', 0.5634, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(27, 3, '2026-03-25 15:01:08', 0.4741, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(28, 2, '2026-03-25 15:01:09', 0.4562, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(29, 3, '2026-03-25 15:01:19', 0.4432, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(30, 2, '2026-03-25 15:01:32', 0.4416, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(31, 3, '2026-03-25 15:19:36', 0.5779, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(32, 3, '2026-03-25 15:48:58', 0.6949, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(33, 3, '2026-03-25 16:27:39', 0.517, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(34, 5, '2026-03-26 07:41:25', 0.3381, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(35, 5, '2026-03-26 07:41:42', 0.6013, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(36, 5, '2026-03-26 07:45:05', 0.4796, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(37, 5, '2026-03-26 07:46:25', 0.8069, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(38, 3, '2026-03-27 00:14:49', 0.5249, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(39, 3, '2026-03-27 00:29:10', 0.5543, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(40, 3, '2026-03-27 00:29:46', 0.58, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(41, 3, '2026-03-27 00:30:47', 0.6344, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(42, 5, '2026-03-27 07:54:34', 0.5163, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(43, 3, '2026-03-31 23:38:48', 0.5825, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(44, 10, '2026-08-05 08:29:43', 0.3712, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36');

-- --------------------------------------------------------

--
-- Table structure for table `inv_items`
--

CREATE TABLE `inv_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `type` enum('ingredient','packaging') NOT NULL DEFAULT 'ingredient',
  `stock` decimal(12,2) NOT NULL DEFAULT 0.00,
  `unit` varchar(20) NOT NULL DEFAULT 'pcs',
  `reorder_point` decimal(12,2) NOT NULL DEFAULT 10.00,
  `note` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inv_items`
--

INSERT INTO `inv_items` (`id`, `name`, `type`, `stock`, `unit`, `reorder_point`, `note`, `is_active`, `created_at`, `updated_at`) VALUES
(28, '8oz Cup', 'packaging', 1.00, '8oz', 20.00, 'Cup packaging — auto-deducted on sales', 1, '2026-08-05 14:55:15', '2026-08-05 15:02:38'),
(32, 'Sugar', 'ingredient', 1.00, 'kg', 10.00, NULL, 1, '2026-08-07 07:22:12', '2026-08-07 07:22:12');

-- --------------------------------------------------------

--
-- Table structure for table `inv_log`
--

CREATE TABLE `inv_log` (
  `log_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `item_name` varchar(120) NOT NULL DEFAULT '',
  `unit` varchar(20) NOT NULL DEFAULT 'pcs',
  `delta` decimal(12,2) NOT NULL,
  `stock_after` decimal(12,2) NOT NULL,
  `source` enum('sale','manual') NOT NULL DEFAULT 'manual',
  `transaction_id` int(10) UNSIGNED DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_by` varchar(80) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `attempt_key` varchar(64) NOT NULL,
  `fail_count` int(11) NOT NULL DEFAULT 0,
  `locked_until` datetime DEFAULT NULL,
  `last_attempt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`attempt_key`, `fail_count`, `locked_until`, `last_attempt`) VALUES
('0aa4996eec69f205abce96013334f99d8083c84780047f1850c297218e71081e', 1, NULL, '2026-06-20 10:46:00'),
('0d7dce5d2cf9a848e0a85d2766071b72ce389c9142207a25335af3a785d3cd60', 1, NULL, '2026-06-20 10:46:04'),
('0f50b0d848d29f2476624f171dc2d442266e35bed28ad11e830d6cf09f2b0929', 3, NULL, '2026-04-04 14:34:07'),
('3049ea9e4b0a7b1b19db0afff84bc4434878d00c503dc9b9fa6a8a257c4f67e6', 4, NULL, '2026-03-26 11:36:53'),
('4801e744b254a7d1f0993a29705a151e7430e4355186ff79b51128baca15af53', 2, NULL, '2026-06-18 12:30:09'),
('85d636564759f084aae5de99f84bf6246f97cfea6c02769f55484c7eba9bec4d', 5, '2026-04-05 17:42:20', '2026-04-05 17:27:20'),
('a49a0bc44eb86fb946e61a404978255950b48af6daaaec520e2a6fdd8120104c', 1, NULL, '2026-04-24 15:00:51'),
('c6226336103d7f37ae7977cb2eaf934e6491d7fe3bebb358acf9e6a93384a342', 1, NULL, '2026-06-20 10:45:34'),
('caf6f36cd0b4ca60bb2d899d89d0dc0986c37b7ffe6f2d62c35186ceaa370657', 1, NULL, '2026-06-20 10:46:18'),
('d139604745a93e36066ef4338fb6d25123ef18fac7fd9e388a991c8cb4392670', 1, NULL, '2026-08-07 14:28:35'),
('e465bc3707ee26be69bd181efe4d44bc137e560e1a3ec977570c0037c0f17b79', 1, NULL, '2026-08-16 00:36:05'),
('e5a53f281f2cbc6dda2b870762a92947b3855ebe9e8e026b4de8f37c45d61c62', 2, NULL, '2026-06-20 10:45:45');

-- --------------------------------------------------------

--
-- Table structure for table `overtime_requests`
--

CREATE TABLE `overtime_requests` (
  `request_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `attendance_id` int(11) DEFAULT NULL,
  `request_date` date NOT NULL,
  `extended_hours` decimal(4,2) NOT NULL,
  `reason` varchar(500) NOT NULL DEFAULT '',
  `status` enum('pending','approved','denied','cancelled') NOT NULL DEFAULT 'pending',
  `reviewed_by` varchar(255) DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `admin_note` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `overtime_requests`
--

INSERT INTO `overtime_requests` (`request_id`, `employee_id`, `attendance_id`, `request_date`, `extended_hours`, `reason`, `status`, `reviewed_by`, `reviewed_at`, `admin_note`, `created_at`) VALUES
(1, 10, NULL, '2026-05-27', 1.00, 'DELAY', 'denied', 'Drexler', '2026-05-27 19:28:19', '', '2026-05-27 11:27:41'),
(2, 10, NULL, '2026-05-27', 1.00, 'PLEASE', 'denied', 'Drexler', '2026-05-27 19:29:25', '', '2026-05-27 11:29:05'),
(3, 10, NULL, '2026-08-03', 1.00, 'extend 1 hour', 'cancelled', NULL, NULL, NULL, '2026-08-03 15:05:45'),
(4, 10, NULL, '2026-08-03', 1.00, 'extend 1', 'cancelled', NULL, NULL, NULL, '2026-08-03 15:09:41'),
(5, 10, NULL, '2026-08-03', 1.00, 'sample', 'cancelled', NULL, NULL, NULL, '2026-08-03 15:20:10'),
(6, 10, NULL, '2026-08-03', 1.00, '1', 'cancelled', NULL, NULL, NULL, '2026-08-03 15:20:41'),
(7, 10, NULL, '2026-08-03', 0.50, '1', 'cancelled', NULL, NULL, NULL, '2026-08-03 15:31:50'),
(8, 10, NULL, '2026-08-03', 0.50, '1', 'cancelled', NULL, NULL, NULL, '2026-08-03 15:40:06'),
(9, 12, NULL, '2026-08-17', 1.00, 'overtime', 'cancelled', NULL, NULL, NULL, '2026-08-17 16:23:30');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `id` int(10) UNSIGNED NOT NULL,
  `token` varchar(128) NOT NULL,
  `role` enum('admin','manager','cashier') NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_table` enum('admins','employees') NOT NULL,
  `expires_at` datetime NOT NULL,
  `otp_code` varchar(6) DEFAULT NULL,
  `otp_verified` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`id`, `token`, `role`, `user_id`, `user_table`, `expires_at`, `otp_code`, `otp_verified`) VALUES
(24, '0dfe2679fb7baec80952213d256a663ae491430aff7ee986e940d7e07878b899', 'cashier', 12, 'employees', '2026-08-07 12:11:15', '955191', 0),
(25, 'e50bbe28b79c917b80811efb08222f723dcc5bcd47b4adb203eeee08303230fd', 'admin', 6, 'admins', '2026-08-07 12:12:09', '890806', 0),
(26, 'ccb78fbd94eb0bb50020dabfa4138a55de31e08b8b1731a04db88118f83453ea', 'cashier', 12, 'employees', '2026-08-07 12:12:24', '729622', 0),
(27, '45922b290efcc688ce11636df14ddd06b7d27487516d1e2977be6647e6e7d57e', 'cashier', 12, 'employees', '2026-08-07 12:21:03', '972175', 0),
(28, '8dc869ed079db9dc3be81b634391dd3a18d5422f16e78f7ff90e2dfb9741dc60', 'cashier', 12, 'employees', '2026-08-07 12:22:57', '371289', 0),
(29, 'f67e3477bbd464f94d995d1edaac3ba18517becdd4c9ea0971022e2d73c6233d', 'cashier', 12, 'employees', '2026-08-07 12:25:02', '161019', 0),
(30, 'd9d225625cdf6a5ef8d70c2e7b38f42fc65e15960796f947f25c971c0561d1e1', 'admin', 6, 'admins', '2026-08-07 12:25:48', '411160', 0),
(31, '86d84e412f93c5eeb6158d4175e43ac24d51db75159b8e53ec30800cad910bd1', 'cashier', 12, 'employees', '2026-08-07 12:29:20', '439920', 1),
(32, '94a0ab4079e2fd36c750e1fd641bc605e376b5c615279882d22029001fd18323', 'cashier', 12, 'employees', '2026-08-07 12:31:04', '845683', 1),
(34, '1ebd44079351818e5893449b8676ff940cb50ba2451f3aba82b3a14495072b7f', 'admin', 6, 'admins', '2026-08-07 12:36:10', '217476', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payroll_periods`
--

CREATE TABLE `payroll_periods` (
  `payroll_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(11) NOT NULL,
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `total_hours` decimal(8,2) NOT NULL DEFAULT 0.00,
  `total_pay` decimal(12,2) NOT NULL DEFAULT 0.00,
  `days_worked` smallint(6) NOT NULL DEFAULT 0,
  `status` enum('draft','finalized') NOT NULL DEFAULT 'draft',
  `generated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `finalized_at` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `description` text DEFAULT NULL,
  `sku` varchar(60) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `stock` int(11) NOT NULL DEFAULT 0,
  `reorder_point` int(11) NOT NULL DEFAULT 5,
  `unit` varchar(30) NOT NULL DEFAULT 'pcs',
  `icon` varchar(10) NOT NULL DEFAULT '?',
  `image_url` varchar(512) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `cup_eligible` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `category_id`, `name`, `description`, `sku`, `price`, `cost`, `stock`, `reorder_point`, `unit`, `icon`, `image_url`, `is_active`, `created_at`, `updated_at`, `cup_eligible`) VALUES
(79, 53, 'Spanish Latte', NULL, NULL, 111.00, 11.00, 0, 5, 'pcs', '?', '/static/product_images/prod_a88f410a5dcf08c31e7fa405.webp', 1, '2026-08-05 14:56:19', '2026-08-11 06:22:24', 1),
(95, 59, 'Chicken pop, Fries and Drnks', NULL, NULL, 55.00, 0.00, 0, 5, 'pcs', '?', NULL, 0, '2026-08-11 05:01:09', '2026-08-11 05:25:18', 1),
(96, 61, 'Bacon Roll with Rice', NULL, 'C6', 65.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:11:15', '2026-08-11 05:11:15', 0),
(97, 61, 'Chicken Pop with Rice', NULL, 'C7', 65.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_5281e082aef900d7e986446c.jpg', 1, '2026-08-11 05:16:14', '2026-08-11 06:28:02', 0),
(98, 61, 'Hotdog with Rice', NULL, 'C8', 55.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_0d62391169404383d2a9b5fd.webp', 1, '2026-08-11 05:16:46', '2026-08-11 06:29:09', 0),
(99, 61, 'Siomai with Rice', NULL, 'C9', 55.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_c552f3546074f6f63b89608f.jpg', 1, '2026-08-11 05:17:14', '2026-08-11 06:34:47', 0),
(100, 61, 'Shanghai with Rice', NULL, 'C10', 55.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_3ea09ade6de17e81f6bbebf1.webp', 1, '2026-08-11 05:18:14', '2026-08-11 06:33:42', 0),
(101, 61, 'Nuggets with Rice', NULL, 'C11', 55.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_a12b09a992fe375e203f37fc.webp', 1, '2026-08-11 05:18:48', '2026-08-11 06:32:40', 0),
(102, 60, 'Hotdog , Fries & Drinks', NULL, 'C1', 55.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:20:07', '2026-08-11 05:20:22', 0),
(103, 60, 'Chicken Pop, Fries and Drinks', NULL, 'C2', 55.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:21:03', '2026-08-11 05:21:03', 0),
(104, 60, 'Chicken Pop, Cheese sticks  & Drinks', NULL, 'C3', 55.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:22:32', '2026-08-11 05:22:32', 0),
(105, 60, 'Cheese Stick, Hotdog, Fries & Drinks', NULL, 'C4', 55.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:23:58', '2026-08-11 05:23:58', 0),
(106, 60, 'Chicken Pop, Hotdog, cheese Sticks & Drinks', NULL, 'C5', 75.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:25:01', '2026-08-11 05:25:01', 0),
(107, 63, 'Fries', NULL, NULL, 25.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_0d0725018a1ba306b6fcc0fa.webp', 1, '2026-08-11 05:26:58', '2026-08-11 06:17:45', 0),
(108, 63, 'Cheese Sticks (5 pcs)', NULL, NULL, 25.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_57f05075623c7989ab0909a6.webp', 1, '2026-08-11 05:27:40', '2026-08-11 06:15:54', 0),
(109, 63, 'Hotdog on Stick', NULL, NULL, 25.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_72a18e44bf2f3f65673099da.jpg', 1, '2026-08-11 05:28:06', '2026-08-11 06:16:56', 0),
(110, 63, 'Siomai (3 pcs)', NULL, NULL, 25.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_6a5d1352765d67e351848476.jpg', 1, '2026-08-11 05:28:36', '2026-08-11 06:03:04', 0),
(111, 63, 'Nachos', NULL, NULL, 60.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_30fdef61edd327975748d0e7.png', 1, '2026-08-11 05:29:00', '2026-08-11 06:13:02', 0),
(112, 63, 'Hashbrown', NULL, NULL, 55.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_ee4df9ba465ad94585f28230.jpg', 1, '2026-08-11 05:29:24', '2026-08-11 06:09:55', 0),
(113, 63, 'Nuggets', NULL, NULL, 55.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_e8d3db415e14b2e8da33c077.webp', 1, '2026-08-11 05:29:43', '2026-08-11 06:06:09', 0),
(114, 62, 'Banana muffin (3pcs)', NULL, NULL, 100.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_ba5850a6d3481ab402055795.webp', 1, '2026-08-11 05:32:00', '2026-08-11 05:59:56', 0),
(115, 62, 'Brazos (Cupcakes)', NULL, NULL, 100.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_cf3448fbb10ff5e54c23f07d.jpg', 1, '2026-08-11 05:32:37', '2026-08-11 06:14:38', 0),
(116, 62, 'Dulce de Leche (slice)', NULL, NULL, 95.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_7163a3487563ae864a929a2b.jpg', 1, '2026-08-11 05:33:09', '2026-08-11 06:20:32', 0),
(117, 62, 'Yema cake (slice)', NULL, NULL, 95.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_b821fba79cbd68992e962b44.webp', 1, '2026-08-11 05:33:34', '2026-08-11 06:21:23', 0),
(118, 59, 'Chicken Alfredo', NULL, NULL, 120.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_c22e287845c0ba9458b8787c.jpg', 1, '2026-08-11 05:34:36', '2026-08-11 06:25:50', 0),
(119, 59, 'Carbonara', NULL, NULL, 120.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_2f032ae5bd51f11e6d9836b6.jpg', 1, '2026-08-11 05:34:56', '2026-08-11 06:25:02', 0),
(120, 59, 'Fries & Nachos', NULL, NULL, 150.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:35:23', '2026-08-11 05:35:23', 0),
(121, 59, 'Fries & Chicken Popcorn', NULL, NULL, 150.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:35:55', '2026-08-11 05:35:55', 0),
(122, 59, 'Barkada Treats', NULL, NULL, 199.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:36:21', '2026-08-11 05:36:21', 0);

-- --------------------------------------------------------

--
-- Table structure for table `shift_config`
--

CREATE TABLE `shift_config` (
  `id` int(11) NOT NULL,
  `label` varchar(100) NOT NULL,
  `start_time` varchar(5) NOT NULL,
  `end_time` varchar(5) NOT NULL,
  `color` varchar(20) NOT NULL DEFAULT '#c9a961',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shift_config`
--

INSERT INTO `shift_config` (`id`, `label`, `start_time`, `end_time`, `color`, `created_at`) VALUES
(1, '8AM', '08:00', '18:00', '#4caf50', '2026-05-19 14:12:12');

-- --------------------------------------------------------

--
-- Table structure for table `stock_requests`
--

CREATE TABLE `stock_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `item_name` varchar(120) NOT NULL,
  `item_type` enum('ingredient','packaging') NOT NULL DEFAULT 'ingredient',
  `quantity` decimal(12,2) NOT NULL DEFAULT 0.00,
  `unit` varchar(20) NOT NULL DEFAULT 'pcs',
  `note` varchar(255) DEFAULT NULL,
  `requested_by` varchar(80) NOT NULL,
  `requested_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `reviewed_by` varchar(80) DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `review_note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock_requests`
--

INSERT INTO `stock_requests` (`id`, `item_name`, `item_type`, `quantity`, `unit`, `note`, `requested_by`, `requested_at`, `status`, `reviewed_by`, `reviewed_at`, `review_note`) VALUES
(1, 'Milk', 'ingredient', 1.00, 'pcs', NULL, 'patrimonio', '2026-08-10 14:50:03', 'rejected', 'Admin', '2026-08-18 14:50:45', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `cashier_id` int(11) NOT NULL,
  `cashier_name` varchar(255) NOT NULL DEFAULT '',
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `tax_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `amount_tendered` decimal(12,2) NOT NULL DEFAULT 0.00,
  `change_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `payment_method` enum('cash','card','gcash','maya','other') NOT NULL DEFAULT 'cash',
  `gcash_ref` varchar(50) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `status` enum('completed','voided') NOT NULL DEFAULT 'completed',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `discount_type` enum('none','senior','pwd','manual') NOT NULL DEFAULT 'none',
  `net_sales` decimal(12,2) NOT NULL DEFAULT 0.00,
  `vat_amount` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_items`
--

CREATE TABLE `transaction_items` (
  `item_id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `product_name` varchar(120) NOT NULL,
  `category_name` varchar(80) NOT NULL DEFAULT '',
  `unit_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `line_total` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `app_settings`
--
ALTER TABLE `app_settings`
  ADD PRIMARY KEY (`setting_key`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendance_id`),
  ADD KEY `attendance_ibfk_1` (`employee_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `uq_category_name` (`name`);

--
-- Indexes for table `email_alert_settings`
--
ALTER TABLE `email_alert_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `application_id` (`application_id`);

--
-- Indexes for table `employees_trash`
--
ALTER TABLE `employees_trash`
  ADD PRIMARY KEY (`trash_id`),
  ADD KEY `idx_delete_at` (`delete_at`),
  ADD KEY `idx_employee_id` (`employee_id`);

--
-- Indexes for table `employee_applications`
--
ALTER TABLE `employee_applications`
  ADD PRIMARY KEY (`application_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `face_mismatch_log`
--
ALTER TABLE `face_mismatch_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_employee_id` (`employee_id`),
  ADD KEY `idx_attempted_at` (`attempted_at`);

--
-- Indexes for table `inv_items`
--
ALTER TABLE `inv_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_type` (`type`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `inv_log`
--
ALTER TABLE `inv_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_item` (`item_id`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_source` (`source`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`attempt_key`);

--
-- Indexes for table `overtime_requests`
--
ALTER TABLE `overtime_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `idx_ot_employee` (`employee_id`),
  ADD KEY `idx_ot_status` (`status`),
  ADD KEY `idx_ot_date` (`request_date`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `idx_token` (`token`),
  ADD KEY `idx_expires_at` (`expires_at`);

--
-- Indexes for table `payroll_periods`
--
ALTER TABLE `payroll_periods`
  ADD PRIMARY KEY (`payroll_id`),
  ADD UNIQUE KEY `uq_emp_period` (`employee_id`,`period_start`),
  ADD KEY `idx_period_start` (`period_start`),
  ADD KEY `idx_employee_id` (`employee_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `idx_category` (`category_id`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `shift_config`
--
ALTER TABLE `shift_config`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_requests`
--
ALTER TABLE `stock_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `idx_cashier` (`cashier_id`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `transaction_items`
--
ALTER TABLE `transaction_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `idx_tx` (`transaction_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `email_alert_settings`
--
ALTER TABLE `email_alert_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `employees_trash`
--
ALTER TABLE `employees_trash`
  MODIFY `trash_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `employee_applications`
--
ALTER TABLE `employee_applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `face_mismatch_log`
--
ALTER TABLE `face_mismatch_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `inv_items`
--
ALTER TABLE `inv_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `inv_log`
--
ALTER TABLE `inv_log`
  MODIFY `log_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `overtime_requests`
--
ALTER TABLE `overtime_requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `payroll_periods`
--
ALTER TABLE `payroll_periods`
  MODIFY `payroll_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `shift_config`
--
ALTER TABLE `shift_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `stock_requests`
--
ALTER TABLE `stock_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `transaction_items`
--
ALTER TABLE `transaction_items`
  MODIFY `item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `employee_applications` (`application_id`) ON DELETE SET NULL;

--
-- Constraints for table `payroll_periods`
--
ALTER TABLE `payroll_periods`
  ADD CONSTRAINT `payroll_periods_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL;

--
-- Constraints for table `transaction_items`
--
ALTER TABLE `transaction_items`
  ADD CONSTRAINT `fk_ti_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
