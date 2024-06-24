-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 30, 2023 at 08:13 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 7.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vortex_isp`
--

-- --------------------------------------------------------

--
-- Table structure for table `band_widths`
--

CREATE TABLE `band_widths` (
  `id` int(10) UNSIGNED NOT NULL,
  `name_bw` varchar(255) NOT NULL,
  `rate_down` int(10) UNSIGNED NOT NULL,
  `rate_down_unit` enum('Kbps','Mbps') NOT NULL,
  `rate_up` int(10) UNSIGNED NOT NULL,
  `rate_up_unit` enum('Kbps','Mbps') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `band_widths`
--

INSERT INTO `band_widths` (`id`, `name_bw`, `rate_down`, `rate_down_unit`, `rate_up`, `rate_up_unit`) VALUES
(1, '10Mbps', 10, 'Mbps', 5, 'Mbps'),
(2, '20 Mbps', 20, 'Mbps', 10, 'Mbps'),
(3, '40 Mb/s', 40, 'Mbps', 20, 'Mbps'),
(4, '60 Mbps', 50, 'Mbps', 20, 'Mbps');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(191) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_11_26_170905_create_transactions_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` int(10) NOT NULL,
  `name_plan` varchar(40) NOT NULL,
  `id_bw` int(10) NOT NULL,
  `price` varchar(40) NOT NULL,
  `type` enum('Hotspot','PPPOE','Balance') NOT NULL,
  `typebp` enum('Unlimited','Limited') DEFAULT NULL,
  `limit_type` enum('Time_Limit','Data_Limit','Both_Limit') DEFAULT NULL,
  `time_limit` int(10) UNSIGNED DEFAULT NULL,
  `time_unit` enum('Mins','Hrs') DEFAULT NULL,
  `data_limit` int(10) UNSIGNED DEFAULT NULL,
  `data_unit` enum('MB','GB') DEFAULT NULL,
  `validity` int(10) NOT NULL,
  `validity_unit` enum('Mins','Hrs','Days','Months') NOT NULL,
  `shared_users` int(10) DEFAULT NULL,
  `routers` varchar(32) NOT NULL,
  `is_radius` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 is radius',
  `pool` varchar(40) DEFAULT NULL,
  `pool_expired` varchar(40) DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 disabled\r\n',
  `is_business` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `name_plan`, `id_bw`, `price`, `type`, `typebp`, `limit_type`, `time_limit`, `time_unit`, `data_limit`, `data_unit`, `validity`, `validity_unit`, `shared_users`, `routers`, `is_radius`, `pool`, `pool_expired`, `enabled`, `is_business`) VALUES
(5, 'Saa 24', 5, '1000', 'Hotspot', 'Unlimited', 'Time_Limit', 0, 'Hrs', 0, 'MB', 24, 'Hrs', 1, 'Momo HQ', 0, NULL, '', 1, 0),
(6, 'Siku 3', 5, '2500', 'Hotspot', 'Unlimited', 'Time_Limit', 0, 'Hrs', 0, 'MB', 3, 'Days', 1, 'Momo HQ', 0, NULL, '', 1, 0),
(7, 'Siku 7', 5, '5000', 'Hotspot', 'Unlimited', 'Time_Limit', 0, 'Hrs', 0, 'MB', 7, 'Days', 1, 'Momo HQ', 0, NULL, '', 1, 0),
(8, 'Siku 30', 5, '25000', 'Hotspot', 'Unlimited', 'Time_Limit', 0, 'Hrs', 0, 'MB', 30, 'Days', 1, 'Momo HQ', 0, NULL, '', 1, 0),
(9, 'Mtoto unlimited', 1, '35000', 'Hotspot', 'Unlimited', 'Time_Limit', 0, 'Hrs', 0, 'MB', 30, 'Days', 1, 'Momo HQ', 0, NULL, '', 1, 1),
(10, 'Simba unlimited', 2, '45000', 'Hotspot', 'Unlimited', 'Time_Limit', 0, 'Hrs', 0, 'MB', 30, 'Days', 1, 'Momo HQ', 0, NULL, '', 1, 1),
(11, 'Cheetah unlimited', 3, '75000', 'Hotspot', 'Unlimited', 'Time_Limit', 0, 'Hrs', 0, 'MB', 30, 'Days', 1, 'Momo HQ', 0, NULL, '', 1, 1),
(12, 'Eagle Unlimited', 4, '150000', 'Hotspot', 'Unlimited', 'Time_Limit', 0, 'Hrs', 0, 'MB', 30, 'Days', 1, 'Momo HQ', 0, NULL, '', 1, 1),
(13, 'Falcon Unlimited', 6, '250000', 'Hotspot', 'Unlimited', 'Time_Limit', 0, 'Hrs', 0, 'MB', 30, 'Days', 1, 'Momo HQ', 0, NULL, '', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_bandwidth`
--

CREATE TABLE `tbl_bandwidth` (
  `id` int(10) UNSIGNED NOT NULL,
  `name_bw` varchar(255) NOT NULL,
  `rate_down` int(10) UNSIGNED NOT NULL,
  `rate_down_unit` enum('Kbps','Mbps') NOT NULL,
  `rate_up` int(10) UNSIGNED NOT NULL,
  `rate_up_unit` enum('Kbps','Mbps') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_bandwidth`
--

INSERT INTO `tbl_bandwidth` (`id`, `name_bw`, `rate_down`, `rate_down_unit`, `rate_up`, `rate_up_unit`) VALUES
(1, '10Mbps', 10, 'Mbps', 5, 'Mbps'),
(2, '20Mbps', 20, 'Mbps', 10, 'Mbps'),
(3, '40Mb/s', 40, 'Mbps', 20, 'Mbps'),
(4, '60 Mbps', 60, 'Mbps', 30, 'Mbps'),
(5, '5 Mbps', 5, 'Mbps', 2, 'Mbps'),
(6, '100Mb/s', 100, 'Mbps', 50, 'Mbps');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ref` varchar(191) NOT NULL,
  `plan_id` varchar(191) NOT NULL,
  `user_id` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `amount` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `ref`, `plan_id`, `user_id`, `phone`, `status`, `amount`, `created_at`, `updated_at`) VALUES
(1, '17010201701', '5', '1', '0752771650', 'success', '1000', '2023-11-26 14:36:10', '2023-11-26 15:48:31'),
(2, '17010252771', '7', '1', '0752771650', 'success', '5000', '2023-11-26 16:01:17', '2023-11-26 16:01:53'),
(3, '17010283142', '5', '2', '0762137208', 'pending', '1000', '2023-11-26 16:51:54', '2023-11-26 16:51:54'),
(4, '17010343283', '5', '3', '0752771650', 'pending', '1000', '2023-11-27 02:32:08', '2023-11-27 02:32:08'),
(5, '17010344673', '5', '3', '0752771650', 'success', '1000', '2023-11-27 02:34:27', '2023-11-27 05:42:54'),
(6, '17010353114', '5', '4', '0752771650', 'success', '1000', '2023-11-27 05:48:31', '2023-11-27 05:49:17'),
(7, '17010556095', '5', '5', '0687005710', 'success', '1000', '2023-11-27 11:26:49', '2023-11-27 11:27:07'),
(8, '17010580026', '5', '6', '0657111850', 'success', '1000', '2023-11-27 12:06:42', '2023-11-27 12:06:55'),
(9, '17010588838', '6', '8', '0673085442', 'pending', '2500', '2023-11-27 12:21:23', '2023-11-27 12:21:23'),
(10, '17010592908', '6', '8', '0673085442', 'success', '2500', '2023-11-27 12:28:10', '2023-11-27 12:28:27'),
(11, '170106180811', '8', '11', '0743382300', 'pending', '25000', '2023-11-27 13:10:08', '2023-11-27 13:10:08'),
(12, '170106310411', '8', '11', '0743382300', 'success', '25000', '2023-11-27 13:31:44', '2023-11-27 13:32:23'),
(13, '170106350912', '5', '12', '0782312930', 'success', '1000', '2023-11-27 13:38:29', '2023-11-27 13:38:43'),
(14, '170106563713', '6', '13', '0626599539', 'pending', '2500', '2023-11-27 14:13:57', '2023-11-27 14:13:57'),
(15, '17010663027', '5', '7', '0743753157', 'success', '1000', '2023-11-27 14:25:02', '2023-11-27 14:25:26'),
(16, '170106933614', '5', '14', '0679941251', 'pending', '1000', '2023-11-27 15:15:36', '2023-11-27 15:15:36'),
(17, '17010699713', '5', '3', '0769178393', 'pending', '1000', '2023-11-27 15:26:11', '2023-11-27 15:26:11'),
(18, '17010703153', '5', '3', '0769178393', 'success', '1000', '2023-11-27 15:31:55', '2023-11-27 15:32:27'),
(19, '170107189715', '5', '15', '0762547246', 'success', '1000', '2023-11-27 15:58:17', '2023-11-27 15:58:37'),
(20, '170108728017', '5', '17', '0715536969', 'success', '1000', '2023-11-27 20:14:40', '2023-11-27 20:15:04'),
(21, '170119452418', '5', '18', '0752753182', 'pending', '1000', '2023-11-29 02:02:04', '2023-11-29 02:02:04'),
(22, '170119462818', '5', '18', '0752753182', 'success', '1000', '2023-11-29 02:03:48', '2023-11-29 02:04:13'),
(23, '17011951313', '5', '3', '0752771650', 'success', '1000', '2023-11-29 02:12:11', '2023-11-29 02:12:32'),
(24, '170119565010', '5', '10', '0788318434', 'success', '1000', '2023-11-29 02:20:50', '2023-11-29 02:21:07'),
(25, '17011983665', '5', '5', '0687005710', 'success', '1000', '2023-11-29 03:06:06', '2023-11-29 03:06:19'),
(26, '170120640121', '5', '21', '0712112119', 'success', '1000', '2023-11-29 05:20:01', '2023-11-29 05:20:32'),
(27, '170122287122', '5', '22', '0679375756', 'pending', '1000', '2023-11-29 09:54:31', '2023-11-29 09:54:31'),
(28, '170122389522', '5', '22', '0679375756', 'success', '1000', '2023-11-29 10:11:35', '2023-11-29 10:11:46'),
(29, '170122494323', '5', '23', '0672995439', 'success', '1000', '2023-11-29 10:29:03', '2023-11-29 10:29:23'),
(30, '170123140925', '5', '25', '0657509450', 'success', '1000', '2023-11-29 12:16:49', '2023-11-29 12:17:09'),
(31, '17012330286', '5', '6', '0657111850', 'success', '1000', '2023-11-29 12:43:48', '2023-11-29 12:44:05'),
(32, '170123391313', '6', '13', '0626599539', 'success', '2500', '2023-11-29 12:58:33', '2023-11-29 12:58:51'),
(33, '17012340138', '6', '8', '0673085442', 'success', '2500', '2023-11-29 13:00:13', '2023-11-29 13:00:27'),
(34, '170123586319', '5', '19', '0765718710', 'pending', '1000', '2023-11-29 13:31:03', '2023-11-29 13:31:03'),
(35, '170123598726', '5', '26', '0625533663', 'success', '1000', '2023-11-29 13:33:07', '2023-11-29 13:33:24'),
(36, '170123600615', '5', '15', '0762547246', 'success', '1000', '2023-11-29 13:33:26', '2023-11-29 13:33:56'),
(37, '170123602627', '5', '27', '0626671604', 'success', '1000', '2023-11-29 13:33:46', '2023-11-29 13:34:11'),
(38, '170123604214', '5', '14', '0679941251', 'success', '1000', '2023-11-29 13:34:02', '2023-11-29 13:34:14'),
(39, '170123605312', '5', '12', '0782312930', 'success', '1000', '2023-11-29 13:34:13', '2023-11-29 13:34:33'),
(40, '170123674119', '5', '19', '0788168196', 'pending', '1000', '2023-11-29 13:45:41', '2023-11-29 13:45:41'),
(41, '170123711128', '5', '28', '0788168196', 'success', '1000', '2023-11-29 13:51:51', '2023-11-29 13:52:13'),
(42, '170123809629', '5', '29', '0629121986', 'success', '1000', '2023-11-29 14:08:16', '2023-11-29 14:08:34'),
(43, '170124012431', '5', '31', '0695027174', 'success', '1000', '2023-11-29 14:42:04', '2023-11-29 14:42:28'),
(44, '170124104832', '5', '32', '0675999095', 'success', '1000', '2023-11-29 14:57:28', '2023-11-29 14:57:44'),
(45, '170124121733', '5', '33', '0712129512', 'success', '1000', '2023-11-29 15:00:17', '2023-11-29 15:00:32'),
(46, '170124288135', '5', '35', '0717216784', 'success', '1000', '2023-11-29 15:28:01', '2023-11-29 15:28:20'),
(47, '17012436057', '5', '7', '0743753157', 'success', '1000', '2023-11-29 15:40:05', '2023-11-29 15:40:30'),
(48, '170124740739', '5', '39', '0783238980', 'success', '1000', '2023-11-29 16:43:27', '2023-11-29 16:43:50'),
(49, '170124755240', '5', '40', '0686134391', 'success', '1000', '2023-11-29 16:45:52', '2023-11-29 16:46:07'),
(50, '170125148141', '6', '41', '0714244482', 'success', '2500', '2023-11-29 17:51:21', '2023-11-29 17:51:42'),
(51, '17012529089', '5', '9', '0685536558', 'pending', '1000', '2023-11-29 18:15:08', '2023-11-29 18:15:08'),
(52, '17012531479', '5', '9', '0685536558', 'success', '1000', '2023-11-29 18:19:07', '2023-11-29 18:19:20'),
(53, '170125418434', '5', '34', '0687776539', 'pending', '1000', '2023-11-29 18:36:24', '2023-11-29 18:36:24'),
(54, '170125431239', '5', '39', '0783238980', 'pending', '1000', '2023-11-29 18:38:32', '2023-11-29 18:38:32'),
(55, '170125491834', '5', '34', '0687776539', 'pending', '1000', '2023-11-29 18:48:38', '2023-11-29 18:48:38'),
(56, '170125770443', '5', '43', '0752771650', 'success', '1000', '2023-11-29 19:35:04', '2023-11-29 19:35:35'),
(57, '170125893542', '5', '42', '0752771650', 'success', '1000', '2023-11-29 19:55:35', '2023-11-29 19:56:13'),
(58, '170126074133', '5', '33', '0712129512', 'pending', '1000', '2023-11-29 20:25:41', '2023-11-29 20:25:41'),
(59, '170126345648', '5', '48', '0622122254', 'success', '1000', '2023-11-29 21:10:56', '2023-11-29 21:11:13'),
(60, '170126471433', '5', '33', '0712129512', 'pending', '1000', '2023-11-29 21:31:54', '2023-11-29 21:31:54'),
(61, '170126683650', '5', '50', '0692202492', 'success', '1000', '2023-11-29 22:07:16', '2023-11-29 22:07:41'),
(62, '170126702351', '5', '51', '0769364555', 'pending', '1000', '2023-11-29 22:10:23', '2023-11-29 22:10:23'),
(63, '170126713651', '5', '51', '0769364555', 'pending', '1000', '2023-11-29 22:12:16', '2023-11-29 22:12:16'),
(64, '170126743151', '5', '51', '0752771650', 'success', '1000', '2023-11-29 22:17:11', '2023-11-29 22:17:31'),
(65, '170126857452', '6', '52', '0655232800', 'success', '2500', '2023-11-29 22:36:14', '2023-11-29 22:36:27'),
(66, '170126905639', '5', '39', '0783238980', 'pending', '1000', '2023-11-29 22:44:16', '2023-11-29 22:44:16'),
(67, '170126926953', '5', '53', '0752771650', 'pending', '1000', '2023-11-29 22:47:49', '2023-11-29 22:47:49'),
(68, '170126938653', '5', '53', '0752771650', 'success', '1000', '2023-11-29 22:49:46', '2023-11-29 22:50:05'),
(69, '170126955054', '5', '54', '0752771650', 'success', '1000', '2023-11-29 22:52:30', '2023-11-29 22:52:58'),
(70, '170127184555', '5', '55', '0714607184', 'pending', '1000', '2023-11-29 23:30:45', '2023-11-29 23:30:45'),
(71, '170127190155', '5', '55', '0714607184', 'pending', '1000', '2023-11-29 23:31:41', '2023-11-29 23:31:41'),
(72, '17012734143', '10', '3', '0752771650', 'pending', '35000', '2023-11-29 20:56:54', '2023-11-29 20:56:54'),
(73, '17012735143', '11', '3', '0752771650', 'success', '45000', '2023-11-29 20:58:34', '2023-11-29 20:58:35'),
(74, '17012735883', '10', '3', '0752771650', 'success', '35000', '2023-11-29 20:59:48', '2023-11-29 20:59:48'),
(75, '17012739663', '11', '3', '0752771650', 'success', '45000', '2023-11-29 21:06:06', '2023-11-29 21:06:06'),
(76, '170127518838', '5', '38', '0783838021', 'pending', '1000', '2023-11-29 21:26:28', '2023-11-29 21:26:28'),
(77, '170127529938', '5', '38', '0783838021', 'success', '1000', '2023-11-29 21:28:19', '2023-11-29 21:28:33'),
(78, '17012755893', '10', '57', '0755662662', 'pending', '35000', '2023-11-29 21:33:09', '2023-11-29 21:33:09'),
(79, '17012756263', '10', '57', '0755662662', 'pending', '35000', '2023-11-29 21:33:46', '2023-11-29 21:33:46'),
(80, '17012757953', '10', '57', '0755662662', 'pending', '35000', '2023-11-29 21:36:35', '2023-11-29 21:36:35'),
(81, '17012762913', '10', '57', '0755662662', 'success', '35000', '2023-11-29 21:44:51', '2023-11-29 21:44:52'),
(82, '17012764453', '10', '3', '0752771650', 'success', '35000', '2023-11-29 21:47:25', '2023-11-29 21:47:25'),
(83, '17012764903', '10', '57', '0755662662', 'success', '35000', '2023-11-29 21:48:10', '2023-11-29 21:48:10'),
(84, '17012769463', '8', '3', '0752771650', 'success', '25000', '2023-11-29 21:55:46', '2023-11-29 21:55:46'),
(85, '17012769813', '8', '57', '0755662662', 'success', '25000', '2023-11-29 21:56:21', '2023-11-29 21:56:22'),
(86, '170127895759', '5', '59', '0687807140', 'success', '1000', '2023-11-29 22:29:17', '2023-11-29 22:29:29'),
(87, '170128289361', '6', '61', '0626763906', 'pending', '2500', '2023-11-29 23:34:53', '2023-11-29 23:34:53'),
(88, '170128332960', '5', '60', '0695027401', 'pending', '1000', '2023-11-29 23:42:09', '2023-11-29 23:42:09'),
(89, '170128392247', '10', '47', '0765601391', 'pending', '35000', '2023-11-29 23:52:02', '2023-11-29 23:52:02'),
(90, '170128418747', '10', '47', '0786601391', 'pending', '35000', '2023-11-29 23:56:27', '2023-11-29 23:56:27'),
(91, '170128468847', '10', '47', '0786601391', 'success', '35000', '2023-11-30 00:04:48', '2023-11-30 00:05:09'),
(92, '170128738360', '5', '60', '0695027401', 'pending', '1000', '2023-11-30 00:49:43', '2023-11-30 00:49:43'),
(93, '170128748360', '5', '60', '0695027401', 'success', '1000', '2023-11-30 00:51:23', '2023-11-30 00:51:38'),
(94, '170128906462', '5', '62', '0687391576', 'success', '1000', '2023-11-30 01:17:44', '2023-11-30 01:18:13'),
(95, '170129376731', '5', '31', '0695027174', 'pending', '1000', '2023-11-30 02:36:07', '2023-11-30 02:36:07'),
(96, '170131910710', '5', '10', '0788318434', 'success', '1000', '2023-11-30 09:38:27', '2023-11-30 09:38:45'),
(97, '170132195865', '6', '65', '0654532014', 'success', '2500', '2023-11-30 10:25:58', '2023-11-30 10:26:13'),
(98, '170132482267', '7', '67', '0755077366', 'success', '5000', '2023-11-30 11:13:42', '2023-11-30 11:14:27'),
(99, '170132566468', '5', '68', '0758498195', 'pending', '1000', '2023-11-30 11:27:44', '2023-11-30 11:27:44'),
(100, '17013308963', '8', '71', '0754329820', 'success', '25000', '2023-11-30 12:54:56', '2023-11-30 12:54:57'),
(101, '170133108125', '5', '25', '0657509450', 'pending', '1000', '2023-11-30 12:58:01', '2023-11-30 12:58:01'),
(102, '170133625873', '5', '73', '0788976749', 'success', '1000', '2023-11-30 14:24:18', '2023-11-30 14:24:43'),
(103, '170133682474', '5', '74', '0612046240', 'success', '1000', '2023-11-30 14:33:44', '2023-11-30 14:34:12'),
(104, '170133979328', '7', '28', '0788168196', 'success', '5000', '2023-11-30 15:23:13', '2023-11-30 15:23:30'),
(105, '170134077814', '5', '14', '0679941251', 'success', '1000', '2023-11-30 15:39:38', '2023-11-30 15:39:51'),
(106, '170134250014', '5', '14', '0679941251', 'pending', '1000', '2023-11-30 16:08:20', '2023-11-30 16:08:20'),
(107, '170134254614', '5', '14', '0679941251', 'pending', '1000', '2023-11-30 16:09:06', '2023-11-30 16:09:06'),
(108, '17013526756', '5', '6', '0657111850', 'pending', '1000', '2023-11-30 18:57:55', '2023-11-30 18:57:55'),
(109, '17013527446', '5', '6', '0657111850', 'pending', '1000', '2023-11-30 18:59:04', '2023-11-30 18:59:04'),
(110, '17013528006', '5', '6', '0752771650', 'success', '1000', '2023-11-30 19:00:00', '2023-11-30 19:00:22'),
(111, '170135751353', '5', '53', '0752771650', 'success', '1000', '2023-11-30 23:18:33', '2023-11-30 23:18:58'),
(112, '17013587143', '5', '75', '0745003868', 'success', '1000', '2023-11-30 23:38:34', '2023-11-30 23:38:34'),
(113, '170136027925', '5', '25', '0657509450', 'pending', '1000', '2023-12-01 00:04:39', '2023-12-01 00:04:39'),
(114, '170136033125', '5', '25', '0657509450', 'pending', '1000', '2023-12-01 00:05:31', '2023-12-01 00:05:31'),
(115, '170136038325', '5', '25', '0622774278', 'pending', '1000', '2023-12-01 00:06:23', '2023-12-01 00:06:23'),
(116, '170136045125', '5', '25', '0654485755', 'pending', '1000', '2023-12-01 00:07:31', '2023-12-01 00:07:31'),
(117, '170136056025', '5', '25', '0657509450', 'success', '1000', '2023-12-01 00:09:20', '2023-12-01 00:09:44'),
(118, '170136173632', '5', '32', '0675999095', 'success', '1000', '2023-12-01 00:28:56', '2023-12-01 00:29:17'),
(119, '170137425576', '5', '76', '0621293988', 'success', '1000', '2023-12-01 03:57:35', '2023-12-01 03:57:56');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL DEFAULT 'binafsi',
  `mac` varchar(191) DEFAULT NULL,
  `ip` varchar(191) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `phone`, `password`, `type`, `mac`, `ip`, `remember_token`, `created_at`, `updated_at`) VALUES
(3, 'James John ', '0752771650', '$2y$12$5EDyLOrCXqGInhPVVcEZIOd1jejtZXp/HJS5xWxRtuCciGm8KT.aG', 'admin', 'BE:03:8D:C1:DD:60', '192.168.0.151', NULL, '2023-11-27 02:31:09', '2023-12-01 03:47:05'),
(2, 'Regan  albinus mgonya ', '0762137208', '$2y$12$AjoA.kY2BtDcjSL72FdGVOu/gsu90Fm2OQldtJRhz1up0E9ybbFOG', 'binafsi', 'D8:A4:91:5A:91:A2', '192.168.0.131', NULL, '2023-11-26 16:44:47', '2023-11-26 16:45:09'),
(4, 'admin', '0654485755', '$2y$12$8qcGgBKtD0fBrTGXYnnW6eN7/hpV06uGS985NmtKgKUw7n/dIa3ji', 'binafsi', '3C:77:E6:1E:CD:F3', '192.168.0.40', NULL, '2023-11-27 05:47:52', '2023-11-27 05:48:01'),
(5, 'Kelvin AN', '0687005710', '$2y$12$AOohKHdzf3kQQ1Upb3stVuoUM53RBndCaAKdcTMvz840O6PAVyOqC', 'binafsi', 'DE:BA:06:15:78:EE', '192.168.0.42', NULL, '2023-11-27 10:45:58', '2023-11-29 10:49:08'),
(6, 'Gasper Simon Chiwanga ', '0657111850', '$2y$12$5EDyLOrCXqGInhPVVcEZIOd1jejtZXp/HJS5xWxRtuCciGm8KT.aG', 'binafsi', '72:47:BC:D3:BE:EF', '192.168.0.19', NULL, '2023-11-27 10:46:45', '2023-11-30 18:56:36'),
(7, 'Shafii', '0743753157', '$2y$12$huFz3sGdNJX2fUyOi0b2zeSeS0pBqupnQRkjO1fcE.b5kuaO1Hvle', 'binafsi', '4A:88:DB:08:35:F6', '192.168.0.59', NULL, '2023-11-27 10:50:07', '2023-11-30 08:42:47'),
(8, 'Magreth ', '0673085442', '$2y$12$xfQg4PtbB8IJaLthsWLIyeeWfhVo57NvIGMQlgfetBUQ9ksb4B.Wi', 'binafsi', '6A:D1:C1:D4:23:48', '192.168.0.190', NULL, '2023-11-27 12:19:56', '2023-11-29 12:59:02'),
(9, 'Benard j nkangala', '0685536558', '$2y$12$QYkWeawIZvSPGBmoUOVGq.kk61fplOQ59k4rW7oc1YvZiLYxsTsC6', 'binafsi', 'D6:93:60:2B:C7:86', '192.168.0.137', NULL, '2023-11-27 12:20:20', '2023-11-29 18:14:41'),
(10, 'Juma nasoro', '0788318434', '$2y$12$ptbd0x1MCRuK.LSDqZhGNuETOpZ7/ONB6DsDA9aFcHJ869axLRnSO', 'binafsi', '74:C1:7D:FD:87:F9', '192.168.0.12', NULL, '2023-11-27 12:35:23', '2023-11-27 12:35:44'),
(11, 'MR JUMBO SUPPLIES', '0743382300', '$2y$12$tehuVNd9/AIazydDzYNTOue4GhTHdDLnf4oyBOEJNuyaISibbu3tm', 'binafsi', '14:CB:19:BC:6A:19', '192.168.0.254', NULL, '2023-11-27 13:09:13', '2023-11-30 10:03:41'),
(12, 'Malick omary', '0782312930', '$2y$12$fxzDf9xLR2eMec0nydLgoOqr4ezaWi8128OWxaFppjdD7IcpUx1dm', 'binafsi', '6A:36:07:85:D4:6E', '192.168.0.226', NULL, '2023-11-27 13:37:31', '2023-11-29 13:33:40'),
(13, 'Ayoub chambo', '0626599539', '$2y$12$MHWtfKNNQoK1qWkGOWkDluhh0uC/e.EtbO8ux7blhvtI1htQn34fe', 'binafsi', '0A:C6:CA:B7:C8:B8', '192.168.0.110', NULL, '2023-11-27 14:12:42', '2023-12-01 01:04:48'),
(14, 'Shaban msuya', '0679941251', '$2y$12$eMa3n08E9DpXbhNIISk/ZuI1.Qb/rDqdG5bExoJ2NAKei9Z8UiBN.', 'binafsi', '76:CB:2C:DE:1B:E8', '192.168.0.194', NULL, '2023-11-27 15:14:55', '2023-11-30 16:08:07'),
(15, 'Eleneus gedius', '0762547246', '$2y$12$CdLJFuBm.naY8o9VxBZs9OHc.WoDxa3GZhXus9qihRbZqIndb/Cry', 'binafsi', '86:A9:F8:6B:10:BF', '192.168.0.234', NULL, '2023-11-27 15:57:35', '2023-11-30 08:07:07'),
(16, 'Mkinga Empire', '0766055066', '$2y$12$eMa3n08E9DpXbhNIISk/ZuI1.Qb/rDqdG5bExoJ2NAKei9Z8UiBN.', 'binafsi', '30:DE:4B:F4:02:3B', '192.168.0.213', NULL, '2023-11-27 15:14:55', '2023-11-30 17:41:57'),
(17, 'Elisha', '0715536969', '$2y$12$70b02hrA/xYEkIafy7u8iOiEu0vXw61aZlrFuoUUUBleGzlAUiJym', 'binafsi', NULL, NULL, NULL, '2023-11-27 20:13:47', '2023-11-27 20:13:47'),
(18, 'Omari Mdoe', '0752753182', '$2y$12$/gTzbETCKXiPE7kN6tO7p..ZcjzUGieGoO/QplNTTKHB2prEmslDi', 'binafsi', '3A:D0:B3:85:06:73', '192.168.0.248', NULL, '2023-11-29 02:01:10', '2023-11-29 21:31:29'),
(19, 'Chipe', '0765718710', '$2y$12$iQDblSylbRguIYZxZGKDnem9ZxtJC2/3UpWmVjpWqfk461FgmOp2q', 'binafsi', '02:50:ED:17:E7:D7', '192.168.0.237', NULL, '2023-11-29 02:01:21', '2023-11-29 13:44:56'),
(20, 'Respecious John', '0658976599', '$2y$12$Vo2WPn.mD6E5FZGMWtgZzOcyHmXCiSpOQsKhdgKlYzoTo80Wq.JBS', 'binafsi', '3A:59:57:91:6C:3F', '192.168.0.115', NULL, '2023-11-29 03:12:16', '2023-11-29 03:12:38'),
(21, 'assengapeter', '0712112119', '$2y$12$TM74RUGKfsnoIEret0SzvOZxwIdF76oODb7QPkF4SWS4b53IZrwjK', 'binafsi', '8E:59:1E:C2:6F:18', '192.168.0.46', NULL, '2023-11-29 05:19:00', '2023-11-29 05:19:23'),
(22, 'Japhet Maile', '0679375756', '$2y$12$ZiF1um5vwqBc3wU/kDakCOtYha3P7NpXEq2BZPp/HsY5BciK7WJ4K', 'binafsi', '52:E7:4A:92:DE:75', '192.168.0.245', NULL, '2023-11-29 09:53:07', '2023-11-29 19:28:37'),
(23, 'SUBIRA MTANDI', '0672995439', '$2y$12$sRUOGM/q1RHXCtRLpvHgIuwA8j8vu7Z1Kw9bzhJ7xkmJqYJT3f.ty', 'binafsi', 'D8:A4:91:5A:91:A2', '192.168.0.131', NULL, '2023-11-29 10:27:10', '2023-11-29 13:30:02'),
(24, 'Grace  medaa', '0655013243', '$2y$12$Pw5ZGID1tMKzi7B.b.5xRu52a9K5FhYxghV.rsZAglBZbwQEnyBlS', 'binafsi', 'D8:A4:91:5A:91:A2', '192.168.0.131', NULL, '2023-11-29 11:23:57', '2023-11-29 11:24:21'),
(25, 'ABUBAKARI RAJABU shaban', '0657509450', '$2y$12$IPA1mBNYJ7mTdcxgwoTVouQWvULLnDmonoQTAiCFhEogKPxqFKZMO', 'binafsi', '52:F9:B7:6E:90:44', '192.168.0.77', NULL, '2023-11-29 12:12:04', '2023-12-01 00:04:23'),
(26, 'Twaha said', '0625533663', '$2y$12$sW5b4I4UeXpufsuburvnQuojLzifYHR6v.y9ppdPsnggDKdLnkzS.', 'binafsi', '6E:CE:C8:BF:BC:64', '192.168.0.31', NULL, '2023-11-29 13:29:30', '2023-11-29 13:32:39'),
(27, 'Grace Joseph yohana', '0626671604', '$2y$12$UpdJZXHBKW/4b/Bt2ahsX.cBVzqelo2Kp8NH04/3zwHP80TtficLK', 'binafsi', 'E6:8E:1A:C0:E6:1F', '192.168.0.14', NULL, '2023-11-29 13:32:56', '2023-11-30 10:29:04'),
(28, 'Khali', '0788168196', '$2y$12$1W0fFpocNiiHcwjG3s3X9.3Prbro4BL73im4I8Ie0x4WNZW9eyyQa', 'binafsi', '02:50:ED:17:E7:D7', '192.168.0.49', NULL, '2023-11-29 13:50:59', '2023-11-30 19:45:24'),
(29, 'Samehe Pius ndawala', '0629121986', '$2y$12$GoTAgippQg9V0UK.SeMCPe/CZGe96KqTCjuAtnilYYCBGUjNTWjNO', 'binafsi', 'E6:9E:EB:21:E3:71', '192.168.0.69', NULL, '2023-11-29 14:07:29', '2023-11-29 14:07:51'),
(30, 'Khadija peter', '0613259531', '$2y$12$AWmIiqnuakwcr0fPmo1BZ.EK6kjBjCI5n1AUBIB6ABYwQghvSl6KG', 'binafsi', NULL, NULL, NULL, '2023-11-29 14:38:56', '2023-11-29 14:38:56'),
(31, 'Helina braiton mtyele', '0695027174', '$2y$12$tOEyEoClITKxO5P1/2jWzu15KpBHpXS6EjtwnsYxisZe2Gr2wAR02', 'binafsi', '36:65:0D:30:92:55', '192.168.0.78', NULL, '2023-11-29 14:39:10', '2023-11-30 08:22:28'),
(32, 'Hawa', '0675999095', '$2y$12$NuBl8T91IE80/uk44hGhfeHAwofw5R7LdhFoK4kGKiBIqk.AxUjA.', 'binafsi', 'DC:EF:CA:D2:F0:90', '192.168.0.87', NULL, '2023-11-29 14:56:56', '2023-12-01 00:28:47'),
(33, 'Rama', '0712129512', '$2y$12$xpQq8pzh/0q8RUyNYv6ljug7lbwn.vS5QEMgmWNo6TPcgaylvPASS', 'binafsi', '16:3B:D1:86:78:46', '192.168.0.176', NULL, '2023-11-29 14:59:40', '2023-11-30 10:59:51'),
(34, 'Jackson paulo', '0687776539', '$2y$12$rrBY4xOeFl5QYhmJFre0d.HMImJw1NOBhHNy2clhRS4/JWEprExey', 'binafsi', 'BE:B6:FD:C9:C3:EA', '192.168.0.80', NULL, '2023-11-29 15:14:10', '2023-11-29 18:35:34'),
(35, 'Edina Ayubu ', '0745356784', '$2y$12$m5uIp7y/UNsFeJgeGjZHme5nS9/fieRKXKXoLd5SvhxL3AFZCU/fC', 'admin', NULL, NULL, NULL, '2023-11-29 15:15:16', '2023-11-30 13:30:03'),
(36, 'Theresia juma', '0629519500', '$2y$12$4jqHyYsaj56kFShrRIAM..501X6p.4PDVBwh.gtBjlxnQ5NkORPeO', 'binafsi', NULL, NULL, NULL, '2023-11-29 15:35:54', '2023-11-29 15:35:54'),
(37, 'Jeniva Godwin ', '0622456239', '$2y$12$.Jo1G604szRAHnBgcNRRNeXxdNF8BvfvaqkdX5UddjtpfCFY4g4/q', 'binafsi', 'D2:B0:68:84:D8:E2', '192.168.0.152', NULL, '2023-11-29 15:39:38', '2023-11-29 15:40:13'),
(43, 'Baduret Sweni', '0658354726', '$2y$12$WEW4x7IVsr3AYwjNK2lrFusebuRLFuT5WkM5l94zxe.fhKCbIfGIO', 'binafsi', 'F2:BF:2A:3F:31:BC', '192.168.0.253', NULL, '2023-11-29 19:34:11', '2023-11-29 19:34:48'),
(38, 'William andrea', '0783838021', '$2y$12$EUpn8YgxOYRbmJU/wpwHcuE3zuRBV2byXSJFDwcA8wHrohG/ZNu52', 'binafsi', '46:B1:63:26:24:BC', '192.168.0.79', NULL, '2023-11-29 16:07:26', '2023-11-29 21:26:03'),
(39, 'Danis aminadabu', '0783238980', '$2y$12$p/SaIDFcHpQ2YImQ62qzruzhBBeQHL7h.OHkJK1/hASYulCp5zpq.', 'binafsi', '42:59:1A:B5:03:0D', '192.168.0.42', NULL, '2023-11-29 16:39:12', '2023-11-29 22:41:34'),
(40, 'David karume amani', '0686134391', '$2y$12$acEqEq1oepGXTsAz3jCS4OYF7VmbnXikCsBSkM4fOQDua45cxQqva', 'binafsi', '34:60:F9:D4:CD:9C', '192.168.0.131', NULL, '2023-11-29 16:43:22', '2023-11-30 15:35:11'),
(41, 'Boniface ayengo', '0714244482', '$2y$12$8BtJu91OX64/TKnpjjhFheKO5kWHHkR4OUtAdNs2cCMB66QD7gkFK', 'binafsi', 'B2:87:4A:16:01:61', '192.168.0.42', NULL, '2023-11-29 17:50:41', '2023-11-30 14:20:15'),
(71, 'Halid Salim Ibrahim ', '0754329820', '$2y$12$AWDFvi.EuM9iptaGxj0BDul8YSzG31pAWkEVbRRFr43vwDtKO9Bbq', 'binafsi', '50:65:F3:31:9F:74', '192.168.0.90', NULL, '2023-11-30 12:49:43', '2023-11-30 12:54:31'),
(42, 'petson vedastus', '0622080947', '$2y$12$0qrnG7rajxBcUqOiTxr6OegL8ZFE81HguhDptuNZgQvg1YQqikR1.', 'binafsi', 'D4:BE:D9:4C:4E:92', '192.168.0.103', NULL, '2023-11-29 19:14:46', '2023-11-29 19:54:46'),
(46, 'Mery Tarimo', '0717216784', '$2y$12$ag5ZQgtiKoPfhh5rUXRkJuDDPR5lypLVRpIbO3plVzA3JZFUE5mPm', 'binafsi', NULL, NULL, NULL, '2023-11-29 20:18:56', '2023-11-29 20:18:56'),
(47, 'Philbert Mushumba ', '0765601391', '$2y$12$u9w8DfM/BaKIzje1t81a2etRWkZiUDVZnLPThJqdlh5xDXLNvP0ja', 'business', 'A0:9F:7A:19:63:3A', '192.168.0.33', NULL, '2023-11-29 20:21:30', '2023-11-30 16:53:10'),
(48, 'Jailos ', '0622122254', '$2y$12$k9h0ld0C0kwjSVrK95JQUe5eTAIlaguILfXtfHfL3vFhpVqKmVdJW', 'binafsi', 'E6:65:1E:C9:74:8A', '192.168.0.11', NULL, '2023-11-29 21:09:55', '2023-11-29 21:10:17'),
(50, 'Happy vhas', '0692202492', '$2y$12$hv1GyhLfvoeSYoTthCXbuOIVMO20QtdK80JM69vOyXlA.i2FG1zrS', 'binafsi', 'D8:A4:91:5A:91:A2', '192.168.0.131', NULL, '2023-11-29 22:06:12', '2023-11-29 22:23:53'),
(51, 'Rose laymond', '0769364555', '$2y$12$LtH737Hn78cIXmVbXixLD.U5gDKHQPtVJEPIMrVOyIMxV3eCCfLXC', 'binafsi', '92:77:4A:63:DA:42', '192.168.0.69', NULL, '2023-11-29 22:09:50', '2023-11-29 22:10:10'),
(52, 'Mohamed Ally', '0655232800', '$2y$12$yVEfUhbWR9p1GF6Sq3PKOurRPUxedy2jiAKlQAUxujp7xqj7jiikC', 'binafsi', 'D8:A4:91:5A:91:A2', '192.168.0.131', NULL, '2023-11-29 22:29:32', '2023-11-29 22:36:00'),
(53, 'Said salum ', '0673127094', '$2y$12$H7WNzwncKuZRybl4Q/By/.dIYlIVDMqoWNNlfjgyz2ASYgeCnH2Zq', 'binafsi', 'D6:55:2E:FC:1A:19', '192.168.0.50', NULL, '2023-11-29 22:45:21', '2023-11-30 20:06:41'),
(54, 'John mtack', '0694073015', '$2y$12$G37ZQMtLgAkFD8g7X2zcYetNZM/LPMJgEBACenUxhKa3Q9As14Pji', 'binafsi', '72:F6:30:18:41:3A', '192.168.0.66', NULL, '2023-11-29 22:48:25', '2023-11-29 22:48:53'),
(55, 'Sauda', '0714607184', '$2y$12$//FX6DlbKJV4w0CQtBHczuVKDzJeGN2vIC0WULXE1Fu28FYGyk6iu', 'binafsi', '06:31:7B:01:A5:90', '192.168.0.254', NULL, '2023-11-29 23:29:54', '2023-11-29 23:30:19'),
(56, 'Ismail ismail', '0769948574', '$2y$12$oROGa/kdEyFG1M6hszS/8./lXxShrZ8pyJcEGFd6.SdD4lewsbzti', 'binafsi', NULL, NULL, NULL, '2023-11-29 20:54:30', '2023-11-29 20:54:30'),
(57, 'MATARE INVESTMENT ', '0755662662', '$2y$12$qAuGc1EOYbunoFYJqLPDf.ZVnfgyYwulWejHDcVuTR3G2vKRn3oqm', 'binafsi', '60:32:B1:E1:C5:63', '192.168.0.83', NULL, '2023-11-29 21:31:20', '2023-11-29 21:58:47'),
(58, 'Nasma', '0785910445', '$2y$12$PYcw7zhioT9b8Ju1Jusl4OEVO84/Wjup7mUckxN.D050b4nSDRU0q', 'binafsi', NULL, NULL, NULL, '2023-11-29 21:51:31', '2023-11-29 21:51:31'),
(59, 'Amiru', '0687807140', '$2y$12$nNG36Ih84mGzp0OnTiK2yeEvdfxExbuD2OatrEoLHytZ3XJW9DXi.', 'binafsi', 'B6:2B:5F:3C:DF:DC', '192.168.0.142', NULL, '2023-11-29 22:27:28', '2023-11-29 22:28:48'),
(60, 'Sarah Julius Mswaga', '0695027401', '$2y$12$aUlM.KV2Hv8TU/YYzuzHQebPtgxE7yIPz/obIfV2A.s4AXJO7rxki', 'binafsi', 'B6:70:02:C6:6E:C6', '192.168.0.222', NULL, '2023-11-29 23:31:47', '2023-11-29 23:41:28'),
(61, 'David', '0626763906', '$2y$12$qOGXuXNj2z19Zwvggjx9CeYTJTjblZHUceZik89O8C9XSXZ49jfmK', 'binafsi', '3E:AB:5E:F2:74:0D', '192.168.0.110', NULL, '2023-11-29 23:32:25', '2023-11-29 23:33:27'),
(62, 'Abasi', '0687391576', '$2y$12$DRV77c0xJRduTlSOT0/EhukuWIjoHz7MT5C9B7jA8.4lidFTkFgU6', 'binafsi', 'DE:1C:D1:2F:D3:65', '192.168.0.217', NULL, '2023-11-30 01:15:06', '2023-11-30 01:17:19'),
(63, 'nelson', '0754428381', '$2y$12$mZzusWmz.JOsDcls/VQnremHy4ocXot.e/PWg9zXUa26e.4CZx4dm', 'binafsi', NULL, NULL, NULL, '2023-11-30 07:37:11', '2023-11-30 07:37:11'),
(65, 'Michael', '0654532014', '$2y$12$BP6E9pClkdzuce7tcLtNj.wlDHTHQkFVH3YO5Yx6MS2TIlLWtozpu', 'binafsi', '42:A8:C9:93:F3:AD', '192.168.0.28', NULL, '2023-11-30 10:25:01', '2023-11-30 19:11:15'),
(64, 'sheddy bella', '0613666417', '$2y$12$Gxhzs6UeXkUFfX.3UdYFgeFWNhhvqKgozv2lrAVwkNml2CHOSXnfm', 'binafsi', NULL, NULL, NULL, '2023-11-30 07:54:15', '2023-11-30 07:54:15'),
(66, 'Kezia hezroni msambili ', '0694272500', '$2y$12$W38VetJhxrrqpT29mBlyqOOfDB24E81x1KrPYBIolWBq.1tKzpd/2', 'binafsi', '12:D4:7D:C9:6C:BD', '192.168.0.180', NULL, '2023-11-30 11:01:22', '2023-11-30 11:01:57'),
(67, 'Elizabeth ', '0755077366', '$2y$12$8Gr4OZMitPc/4/Ys5DXoNOnENa2gwWApC8XMPFZKC0AlXw7PB9MuO', 'binafsi', 'D8:A4:91:5A:91:A2', '192.168.0.131', NULL, '2023-11-30 11:12:36', '2023-11-30 11:13:09'),
(68, 'Rogers Sanga', '0758498195', '$2y$12$8SFJ8Rch4bWXGaUEb0TefuZGC6cwKQedrOVupk2l7kN5dckxpFC5K', 'binafsi', 'C2:C9:E3:04:EE:38', '192.168.0.200', NULL, '2023-11-30 11:26:06', '2023-11-30 11:50:36'),
(70, 'Awadhi', '0769178393', '$2y$12$.KhmfZFLRD5iYkmrbR.FM.JJIGYiL4D1YxLPLDgPxUb3Vnp3a5EvK', 'binafsi', '64:80:99:A9:46:A1', '192.168.0.161', NULL, '2023-11-30 12:36:49', '2023-11-30 12:51:45'),
(72, 'Irene samweli kiyagi', '0714532823', '$2y$12$S74x6P8bA98KtOZP0AB4pezX957Y6AENd2WCLhWZmjxzIymJ8DiTW', 'binafsi', NULL, NULL, NULL, '2023-11-30 14:11:52', '2023-11-30 14:11:52'),
(73, 'Kimatikimati ', '0788976749', '$2y$12$R97Ph04P.qqcguAWE4oTeujw/qwYbkhp9JHSdLT0rW0meoj6f5NP2', 'binafsi', '9E:82:60:69:B3:A9', '192.168.0.69', NULL, '2023-11-30 14:23:00', '2023-11-30 14:23:47'),
(74, 'John Atanas', '0612046240', '$2y$12$ydW/q3V2JRKrFf5Kw8/OHe0t7ilCZtHgW2ZxAHrls5iWQQ9ydojca', 'binafsi', 'B0:6F:E0:A6:CE:AA', '192.168.0.41', NULL, '2023-11-30 14:28:47', '2023-11-30 14:29:27'),
(75, 'Juma Juma', '0745003868', '$2y$12$2PPZnpaMnQqLXbD.QO6hgeVH6e6AOnN0Ds1gTeZri6Yw6iOsiLxeq', 'binafsi', '6C:5C:14:3E:8A:E6', '192.168.0.61', NULL, '2023-11-30 23:24:36', '2023-11-30 23:36:04'),
(76, 'Salim mohamedy ', '0621293988', '$2y$12$jTRdwnZk/7G0ddD.CCj5vexhELb9NjLeQMvppu9xWldraRnpfKXIK', 'binafsi', '1E:41:2B:06:4D:C0', '192.168.0.145', NULL, '2023-12-01 03:56:47', '2023-12-01 03:57:15');

-- --------------------------------------------------------

--
-- Table structure for table `user_recharges`
--

CREATE TABLE `user_recharges` (
  `id` int(10) NOT NULL,
  `customer_id` int(10) NOT NULL,
  `username` varchar(32) NOT NULL,
  `plan_id` int(10) NOT NULL,
  `namebp` varchar(40) NOT NULL,
  `recharged_on` date NOT NULL,
  `recharged_time` time NOT NULL DEFAULT '00:00:00',
  `expiration` date NOT NULL,
  `time` time NOT NULL,
  `status` varchar(20) NOT NULL,
  `method` varchar(128) NOT NULL,
  `routers` varchar(32) NOT NULL,
  `type` varchar(15) NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `last_notification_sent_at` timestamp(6) NULL DEFAULT NULL,
  `expiration_notified` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_recharges`
--

INSERT INTO `user_recharges` (`id`, `customer_id`, `username`, `plan_id`, `namebp`, `recharged_on`, `recharged_time`, `expiration`, `time`, `status`, `method`, `routers`, `type`, `created_at`, `updated_at`, `last_notification_sent_at`, `expiration_notified`) VALUES
(4, 3, '0752771650', 8, 'Siku 30', '2023-11-29', '16:55:46', '2023-12-29', '16:55:46', 'on', 'admin', 'mikrotik', 'Hotspot', '2023-11-27 05:42:54.000000', '2023-11-29 21:55:46.000000', NULL, 0),
(5, 4, '0654485755', 5, 'Saa 24', '2023-11-27', '00:49:17', '2023-11-28', '00:49:17', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-27 05:49:17.000000', '2023-11-28 05:49:21.000000', NULL, 1),
(6, 5, '0687005710', 5, 'Saa 24', '2023-11-28', '22:06:19', '2023-11-29', '22:06:19', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-27 11:27:07.000000', '2023-11-30 03:06:21.000000', NULL, 1),
(7, 6, '0657111850', 5, 'Saa 24', '2023-11-30', '14:00:22', '2023-12-24', '14:00:22', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-27 12:06:55.000000', '2023-11-30 19:00:22.000000', NULL, 0),
(8, 8, '0673085442', 6, 'Siku 3', '2023-11-29', '08:00:27', '2023-12-02', '08:00:27', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-27 12:28:27.000000', '2023-11-29 13:00:27.000000', NULL, 0),
(9, 11, '0743382300', 8, 'Siku 30', '2023-11-27', '08:32:23', '2023-12-27', '08:32:23', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-27 13:32:23.000000', '2023-11-27 13:32:23.000000', NULL, 0),
(10, 12, '0782312930', 5, 'Saa 24', '2023-11-29', '08:34:33', '2023-11-30', '08:34:33', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-27 13:38:43.000000', '2023-11-30 13:34:49.000000', NULL, 1),
(11, 7, '0743753157', 5, 'Saa 24', '2023-11-29', '10:40:30', '2023-11-30', '10:40:30', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-27 14:25:26.000000', '2023-11-30 15:40:31.000000', NULL, 1),
(12, 14, '0679941251', 5, 'Saa 24', '2023-11-30', '10:39:51', '2023-12-24', '10:39:51', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-27 14:25:26.000000', '2023-11-30 15:39:51.000000', NULL, 0),
(13, 15, '0762547246', 5, 'Saa 24', '2023-11-29', '08:33:56', '2023-11-30', '08:33:56', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-27 15:58:37.000000', '2023-11-30 13:34:01.000000', NULL, 1),
(14, 16, '0766055066', 5, 'Saa 24', '2023-11-27', '10:58:37', '2023-11-28', '10:58:37', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-27 15:58:37.000000', '2023-11-28 15:58:42.000000', NULL, 1),
(15, 17, '0715536969', 5, 'Saa 24', '2023-11-27', '15:15:04', '2023-11-28', '15:15:04', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-27 20:15:04.000000', '2023-11-28 22:13:12.000000', NULL, 1),
(16, 18, '0752753182', 5, 'Saa 24', '2023-11-28', '21:04:13', '2023-11-29', '21:04:13', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 02:04:13.000000', '2023-11-30 02:04:21.000000', NULL, 1),
(17, 10, '0788318434', 5, 'Saa 24', '2023-11-30', '04:38:45', '2023-12-01', '04:38:45', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 02:21:07.000000', '2023-11-30 09:38:45.000000', NULL, 0),
(18, 21, '0712112119', 5, 'Saa 24', '2023-11-29', '00:20:32', '2023-11-30', '00:20:32', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 05:20:32.000000', '2023-11-30 05:20:41.000000', NULL, 1),
(19, 22, '0679375756', 5, 'Saa 24', '2023-11-29', '05:11:46', '2023-11-30', '05:11:46', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 10:11:46.000000', '2023-11-30 10:11:52.000000', NULL, 1),
(20, 23, '0672995439', 5, 'Saa 24', '2023-11-29', '05:29:23', '2023-11-30', '05:29:23', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 10:29:23.000000', '2023-11-30 10:29:31.000000', NULL, 1),
(21, 25, '0657509450', 5, 'Saa 24', '2023-11-30', '19:09:44', '2023-12-24', '19:09:44', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 12:17:09.000000', '2023-12-01 00:09:44.000000', NULL, 0),
(22, 13, '0626599539', 6, 'Siku 3', '2023-11-29', '07:58:51', '2023-12-02', '07:58:51', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 12:58:51.000000', '2023-11-29 12:58:51.000000', NULL, 0),
(23, 26, '0625533663', 5, 'Saa 24', '2023-11-29', '08:33:24', '2023-11-30', '08:33:24', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 13:33:24.000000', '2023-11-30 13:33:31.000000', NULL, 1),
(24, 27, '0626671604', 5, 'Saa 24', '2023-11-29', '08:34:11', '2023-11-30', '08:34:11', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 13:34:11.000000', '2023-11-30 13:34:13.000000', '2023-11-29 13:34:11.000000', 1),
(25, 28, '0788168196', 7, 'Siku 7', '2023-11-30', '10:23:30', '2023-12-07', '10:23:30', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 13:52:12.000000', '2023-11-30 15:23:30.000000', NULL, 0),
(26, 29, '0629121986', 5, 'Saa 24', '2023-11-29', '09:08:34', '2023-11-30', '09:08:34', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 14:08:34.000000', '2023-11-30 14:08:41.000000', NULL, 1),
(27, 31, '0695027174', 5, 'Saa 24', '2023-11-29', '09:42:27', '2023-11-30', '09:42:27', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 14:42:27.000000', '2023-11-30 14:42:31.000000', NULL, 1),
(28, 32, '0675999095', 5, 'Saa 24', '2023-11-30', '19:29:17', '2023-12-24', '19:29:17', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 14:57:44.000000', '2023-12-01 00:29:17.000000', NULL, 0),
(29, 33, '0712129512', 5, 'Saa 24', '2023-11-29', '10:00:31', '2023-11-30', '10:00:31', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 15:00:31.000000', '2023-11-30 15:00:41.000000', '2023-11-30 10:00:31.000000', 1),
(30, 35, '0745356784', 5, 'Saa 24', '2023-11-29', '10:28:20', '2023-11-30', '10:28:20', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 15:28:20.000000', '2023-11-30 15:28:21.000000', NULL, 1),
(31, 39, '0783238980', 5, 'Saa 24', '2023-11-29', '11:43:50', '2023-11-30', '11:43:50', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 16:43:50.000000', '2023-11-30 16:43:52.000000', NULL, 1),
(32, 40, '0686134391', 5, 'Saa 24', '2023-11-29', '11:46:07', '2023-11-30', '11:46:07', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 16:46:07.000000', '2023-11-30 16:46:11.000000', NULL, 1),
(33, 41, '0714244482', 6, 'Siku 3', '2023-11-29', '12:51:42', '2023-12-02', '12:51:42', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 17:51:42.000000', '2023-11-29 17:51:42.000000', NULL, 0),
(34, 9, '0685536558', 5, 'Saa 24', '2023-11-29', '13:19:20', '2023-11-30', '13:19:20', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 18:19:20.000000', '2023-11-30 18:19:21.000000', NULL, 1),
(35, 43, '0658354726', 5, 'Saa 24', '2023-11-29', '14:35:35', '2023-11-30', '14:35:35', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 19:35:35.000000', '2023-11-30 19:35:41.000000', NULL, 1),
(36, 42, '0622080947', 5, 'Saa 24', '2023-11-29', '14:56:13', '2023-11-30', '14:56:13', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 19:56:13.000000', '2023-11-30 19:56:21.000000', NULL, 1),
(37, 48, '0622122254', 5, 'Saa 24', '2023-11-29', '16:11:13', '2023-11-30', '16:11:13', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 21:11:13.000000', '2023-11-30 23:16:31.000000', NULL, 1),
(38, 50, '0692202492', 5, 'Saa 24', '2023-11-29', '17:07:41', '2023-11-30', '17:07:41', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 22:07:41.000000', '2023-11-30 23:16:31.000000', '2023-11-29 22:07:41.000000', 1),
(39, 51, '0769364555', 5, 'Saa 24', '2023-11-29', '17:17:31', '2023-11-30', '17:17:31', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 22:17:31.000000', '2023-11-30 23:16:31.000000', '2023-11-29 22:17:31.000000', 1),
(40, 52, '0655232800', 6, 'Siku 3', '2023-11-29', '17:36:27', '2023-12-02', '17:36:27', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 22:36:27.000000', '2023-11-29 22:36:27.000000', NULL, 0),
(41, 53, '0673127094', 5, 'Saa 24', '2023-11-30', '18:18:58', '2023-12-24', '18:18:58', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 22:50:05.000000', '2023-11-30 23:18:58.000000', NULL, 0),
(42, 54, '0694073015', 5, 'Saa 24', '2023-11-29', '17:52:58', '2023-11-30', '17:52:58', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 22:52:58.000000', '2023-11-30 23:16:31.000000', NULL, 1),
(43, 38, '0783838021', 5, 'Saa 24', '2023-11-29', '16:28:33', '2023-11-30', '16:28:33', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 21:28:33.000000', '2023-11-30 23:16:31.000000', NULL, 1),
(44, 57, '0755662662', 8, 'Siku 30', '2023-11-29', '16:56:22', '2023-12-29', '16:56:22', 'on', 'admin', 'mikrotik', 'Hotspot', '2023-11-29 21:44:52.000000', '2023-11-29 21:56:22.000000', NULL, 0),
(45, 59, '0687807140', 5, 'Saa 24', '2023-11-29', '17:29:29', '2023-11-30', '17:29:29', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-29 22:29:29.000000', '2023-11-30 23:16:31.000000', NULL, 1),
(46, 47, '0765601391', 10, 'Mtoto unlimited', '2023-11-29', '19:05:09', '2023-12-29', '19:05:09', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-30 00:05:09.000000', '2023-11-30 00:05:09.000000', NULL, 0),
(47, 60, '0695027401', 5, 'Saa 24', '2023-11-29', '19:51:38', '2023-11-30', '19:51:38', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-30 00:51:38.000000', '2023-12-01 00:51:41.000000', NULL, 1),
(48, 62, '0687391576', 5, 'Saa 24', '2023-11-29', '20:18:13', '2023-11-30', '20:18:13', 'off', 'selcom', 'mikrotik', 'Hotspot', '2023-11-30 01:18:13.000000', '2023-12-01 01:18:21.000000', NULL, 1),
(49, 65, '0654532014', 6, 'Siku 3', '2023-11-30', '05:26:13', '2023-12-03', '05:26:13', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-30 10:26:13.000000', '2023-11-30 10:26:13.000000', NULL, 0),
(50, 67, '0755077366', 7, 'Siku 7', '2023-11-30', '06:14:27', '2023-12-07', '06:14:27', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-30 11:14:27.000000', '2023-11-30 11:14:27.000000', NULL, 0),
(51, 71, '0754329820', 8, 'Siku 30', '2023-11-30', '07:54:57', '2023-12-30', '07:54:57', 'on', 'admin', 'mikrotik', 'Hotspot', '2023-11-30 12:54:57.000000', '2023-11-30 12:54:57.000000', NULL, 0),
(52, 73, '0788976749', 5, 'Saa 24', '2023-11-30', '09:24:43', '2023-12-24', '09:24:43', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-30 14:24:43.000000', '2023-11-30 14:24:43.000000', NULL, 0),
(53, 74, '0612046240', 5, 'Saa 24', '2023-11-30', '09:34:12', '2023-12-24', '09:34:12', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-11-30 14:34:12.000000', '2023-11-30 14:34:12.000000', NULL, 0),
(54, 75, '0745003868', 5, 'Saa 24', '2023-11-30', '18:38:34', '2023-12-24', '18:38:34', 'on', 'admin', 'mikrotik', 'Hotspot', '2023-11-30 23:38:34.000000', '2023-11-30 23:38:34.000000', NULL, 0),
(55, 76, '0621293988', 5, 'Saa 24', '2023-11-30', '22:57:56', '2023-12-24', '22:57:56', 'on', 'selcom', 'mikrotik', 'Hotspot', '2023-12-01 03:57:56.000000', '2023-12-01 03:57:56.000000', NULL, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `band_widths`
--
ALTER TABLE `band_widths`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_bandwidth`
--
ALTER TABLE `tbl_bandwidth`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_phone_unique` (`phone`);

--
-- Indexes for table `user_recharges`
--
ALTER TABLE `user_recharges`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `band_widths`
--
ALTER TABLE `band_widths`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tbl_bandwidth`
--
ALTER TABLE `tbl_bandwidth`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `user_recharges`
--
ALTER TABLE `user_recharges`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
