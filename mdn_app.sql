-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  jeu. 31 mars 2022 à 14:33
-- Version du serveur :  5.7.26
-- Version de PHP :  7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `mdn_app`
--

-- --------------------------------------------------------

--
-- Structure de la table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
CREATE TABLE IF NOT EXISTS `appointments` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `motif_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `recep_id` bigint(20) UNSIGNED NOT NULL,
  `doctor_id` bigint(20) UNSIGNED NOT NULL,
  `patient_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_enreg` date NOT NULL,
  `date_appoint` date DEFAULT NULL,
  `date_heure_appoint` datetime NOT NULL,
  `approved` int(11) NOT NULL DEFAULT '0',
  `observations` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `piece` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appointments_recep_id_foreign` (`recep_id`),
  KEY `appointments_doctor_id_foreign` (`doctor_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `libelle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `libelle`, `created_at`, `updated_at`) VALUES
(1, 'Privé', '2022-02-04 12:07:32', '2022-02-04 12:07:32'),
(2, 'Assuré', '2022-02-04 12:07:39', '2022-02-04 12:07:39'),
(3, 'Conventionné', '2022-02-04 12:07:53', '2022-02-04 12:07:53'),
(5, 'Famille', '2022-02-18 09:04:00', '2022-02-18 09:04:00');

-- --------------------------------------------------------

--
-- Structure de la table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
CREATE TABLE IF NOT EXISTS `contacts` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `noms` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contacts_patient_id_foreign` (`patient_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `date_rdvs`
--

DROP TABLE IF EXISTS `date_rdvs`;
CREATE TABLE IF NOT EXISTS `date_rdvs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `dates` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `conv` int(11) NOT NULL DEFAULT '0',
  `assur` int(11) NOT NULL DEFAULT '0',
  `prive` int(11) NOT NULL DEFAULT '0',
  `total` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `days`
--

DROP TABLE IF EXISTS `days`;
CREATE TABLE IF NOT EXISTS `days` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `libelle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `days`
--

INSERT INTO `days` (`id`, `libelle`, `created_at`, `updated_at`) VALUES
(0, 'Dimanche', NULL, NULL),
(1, 'Lundi', NULL, NULL),
(2, 'Mardi', NULL, NULL),
(3, 'Mercredi', NULL, NULL),
(4, 'Jeudi', NULL, NULL),
(5, 'Vendredi', NULL, NULL),
(6, 'Samedi', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `grilles`
--

DROP TABLE IF EXISTS `grilles`;
CREATE TABLE IF NOT EXISTS `grilles` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `date_rdv` date NOT NULL,
  `date_rdv_id` int(11) DEFAULT NULL,
  `doctor_id` bigint(20) UNSIGNED NOT NULL,
  `conv` int(11) NOT NULL DEFAULT '0',
  `assur` int(11) NOT NULL DEFAULT '0',
  `prive` int(11) NOT NULL DEFAULT '0',
  `total` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `grilles_doctor_id_foreign` (`doctor_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(96, 'default', '{\"uuid\":\"e612ef6c-52d5-4dcb-9842-3bb11bccc9f0\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644315441, 1644315441),
(95, 'default', '{\"uuid\":\"d3d005de-2b19-4476-bc90-9aa29c65bd3d\",\"displayName\":\"App\\\\Jobs\\\\MailJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\MailJob\",\"command\":\"O:16:\\\"App\\\\Jobs\\\\MailJob\\\":13:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"doctor\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:7:\\\"appoint\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Appointment\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644315427, 1644315427),
(93, 'default', '{\"uuid\":\"8167abca-000b-4689-a68e-6afc2e3c38e3\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644315309, 1644315309),
(94, 'default', '{\"uuid\":\"87c148aa-861a-4395-be34-c96fde1e82cf\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:8;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644315363, 1644315363),
(90, 'default', '{\"uuid\":\"1a860d80-fcae-4859-8d80-e311ab9bac7f\",\"displayName\":\"App\\\\Jobs\\\\MailJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\MailJob\",\"command\":\"O:16:\\\"App\\\\Jobs\\\\MailJob\\\":13:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"doctor\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:7:\\\"appoint\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Appointment\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644314547, 1644314547),
(91, 'default', '{\"uuid\":\"13f9e218-7f19-495e-8b14-79432f07b123\",\"displayName\":\"App\\\\Jobs\\\\MailJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\MailJob\",\"command\":\"O:16:\\\"App\\\\Jobs\\\\MailJob\\\":13:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:8;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"doctor\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:7:\\\"appoint\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Appointment\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644314599, 1644314599),
(92, 'default', '{\"uuid\":\"04200a02-499d-41c9-82fa-151f77f28bb8\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644315204, 1644315204),
(97, 'default', '{\"uuid\":\"a3076a81-2dd6-4455-a1ef-05d77ead1b60\",\"displayName\":\"App\\\\Jobs\\\\MailJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\MailJob\",\"command\":\"O:16:\\\"App\\\\Jobs\\\\MailJob\\\":13:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:18;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"doctor\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:7:\\\"appoint\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Appointment\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644315840, 1644315840),
(98, 'default', '{\"uuid\":\"742a7fb0-7079-4db0-b67e-92f5ee8f7527\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:18;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644315847, 1644315847),
(99, 'default', '{\"uuid\":\"f29f377d-89bc-4cb6-8135-844c11707c62\",\"displayName\":\"App\\\\Jobs\\\\MailJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\MailJob\",\"command\":\"O:16:\\\"App\\\\Jobs\\\\MailJob\\\":13:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:205;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"doctor\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:7:\\\"appoint\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Appointment\\\";s:2:\\\"id\\\";i:5;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644315884, 1644315884),
(100, 'default', '{\"uuid\":\"22c4f0f2-fe3c-488d-8476-2e131b58178e\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:205;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644315892, 1644315892),
(101, 'default', '{\"uuid\":\"8867b1d8-ce60-480d-bc85-dba5ca024fba\",\"displayName\":\"App\\\\Jobs\\\\MailJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\MailJob\",\"command\":\"O:16:\\\"App\\\\Jobs\\\\MailJob\\\":13:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:198;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"doctor\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:5;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:7:\\\"appoint\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Appointment\\\";s:2:\\\"id\\\";i:6;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644316120, 1644316120),
(102, 'default', '{\"uuid\":\"62ab813e-805c-492d-ae8f-2d0c66649c44\",\"displayName\":\"App\\\\Jobs\\\\MailJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\MailJob\",\"command\":\"O:16:\\\"App\\\\Jobs\\\\MailJob\\\":13:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:198;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"doctor\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:5;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:7:\\\"appoint\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Appointment\\\";s:2:\\\"id\\\";i:7;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644316456, 1644316456),
(103, 'default', '{\"uuid\":\"6b698812-8575-4dac-a196-6a55e003a20d\",\"displayName\":\"App\\\\Jobs\\\\MailJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\MailJob\",\"command\":\"O:16:\\\"App\\\\Jobs\\\\MailJob\\\":13:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:28;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"doctor\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:5;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:7:\\\"appoint\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Appointment\\\";s:2:\\\"id\\\";i:8;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644316745, 1644316745),
(104, 'default', '{\"uuid\":\"40919b10-8302-4e8e-b3d8-fcfe273e0427\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:28;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644316782, 1644316782),
(105, 'default', '{\"uuid\":\"5928eba0-eada-4862-a75e-694af8050d18\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644320846, 1644320846),
(106, 'default', '{\"uuid\":\"c5ce56a8-fdf7-45c4-8991-8208a8294436\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644320902, 1644320902),
(107, 'default', '{\"uuid\":\"ad895595-1bee-4659-b013-edba261a2282\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644320993, 1644320993),
(108, 'default', '{\"uuid\":\"9f5190f2-3d71-4722-852b-61265ebfab26\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644323022, 1644323022),
(109, 'default', '{\"uuid\":\"9ef1ad86-81ba-4ee2-8583-0a35bbbcfd97\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644323041, 1644323041),
(110, 'default', '{\"uuid\":\"f714c57e-51dc-446e-a7de-763b9baaa162\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:8;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644323139, 1644323139),
(111, 'default', '{\"uuid\":\"6d863705-278d-4db1-8df1-6a88af183f3a\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644323151, 1644323151),
(112, 'default', '{\"uuid\":\"d391e805-aca2-4bd0-9aae-87bbb9a74673\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:18;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644323170, 1644323170),
(113, 'default', '{\"uuid\":\"266df467-0dc2-4a10-bbe7-7f68c6f1967b\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:205;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644323188, 1644323188),
(114, 'default', '{\"uuid\":\"da9ca941-ac40-4d8a-b852-9bdc08de4da2\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:28;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644323199, 1644323199),
(115, 'default', '{\"uuid\":\"012a37ef-63ca-43d2-9c55-b534d7f12826\",\"displayName\":\"App\\\\Jobs\\\\MailJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\MailJob\",\"command\":\"O:16:\\\"App\\\\Jobs\\\\MailJob\\\":13:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"doctor\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:7:\\\"appoint\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Appointment\\\";s:2:\\\"id\\\";i:9;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644591354, 1644591354),
(116, 'default', '{\"uuid\":\"3f4a633b-d4fe-4b2f-9a85-34b597d7478e\",\"displayName\":\"App\\\\Jobs\\\\MailJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\MailJob\",\"command\":\"O:16:\\\"App\\\\Jobs\\\\MailJob\\\":13:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:20;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"doctor\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:7:\\\"appoint\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Appointment\\\";s:2:\\\"id\\\";i:10;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644591440, 1644591440),
(117, 'default', '{\"uuid\":\"4a7d61a5-aa28-439c-bdb1-b7f1684edc9f\",\"displayName\":\"App\\\\Jobs\\\\MailJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\MailJob\",\"command\":\"O:16:\\\"App\\\\Jobs\\\\MailJob\\\":13:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"doctor\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:7:\\\"appoint\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Appointment\\\";s:2:\\\"id\\\";i:11;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644591462, 1644591462),
(118, 'default', '{\"uuid\":\"2345e42c-c0f0-4f79-b51b-2dad02d1b62c\",\"displayName\":\"App\\\\Jobs\\\\MailJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\MailJob\",\"command\":\"O:16:\\\"App\\\\Jobs\\\\MailJob\\\":13:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"doctor\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:7:\\\"appoint\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Appointment\\\";s:2:\\\"id\\\";i:12;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644591568, 1644591568),
(119, 'default', '{\"uuid\":\"ce6fac24-5c4a-4ac2-a9d9-9fb7125ea911\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644591631, 1644591631),
(120, 'default', '{\"uuid\":\"1473cc47-afd4-402d-a14e-c33599e1ac7f\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:20;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644591705, 1644591705),
(121, 'default', '{\"uuid\":\"2de2e620-af0f-4850-91b3-4dc51f374a45\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644591761, 1644591761),
(122, 'default', '{\"uuid\":\"2bf68b41-d88c-4b2a-978f-41853ee34bad\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644592334, 1644592334),
(123, 'default', '{\"uuid\":\"6266ff4d-9a8a-4ff1-bcd5-3c7387af5ac1\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644592367, 1644592367),
(124, 'default', '{\"uuid\":\"d7208703-9659-45be-b3ae-0c5041728e46\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644592385, 1644592385),
(125, 'default', '{\"uuid\":\"384edc4c-8d37-4d64-96ca-29f564150ff9\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644592630, 1644592630),
(126, 'default', '{\"uuid\":\"f4c83b26-eac5-4815-9720-6630c9fc6f09\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644592644, 1644592644),
(127, 'default', '{\"uuid\":\"5f4972ff-67c0-423a-ba02-34d6899f8c4c\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644592770, 1644592770),
(128, 'default', '{\"uuid\":\"11e64f5c-7b45-45f9-8d09-67fc33090963\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644593499, 1644593499),
(129, 'default', '{\"uuid\":\"35fdab69-2128-450b-a2ab-c4aef14c83bb\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644931503, 1644931503),
(130, 'default', '{\"uuid\":\"55a6e9fe-8303-41ab-8f3b-8174de334bb8\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:20;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644931525, 1644931525),
(131, 'default', '{\"uuid\":\"74668129-4cfe-4d16-8721-976441016a65\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644931543, 1644931543),
(132, 'default', '{\"uuid\":\"e74b1fa1-11ca-41c4-8fe6-0ca0532d9d93\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644931579, 1644931579),
(133, 'default', '{\"uuid\":\"0a5c181e-aaca-4ff2-88b0-8e985c90c1c1\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644933342, 1644933342),
(134, 'default', '{\"uuid\":\"b45bafcb-db20-45e7-b2f8-4b1231b2d3e2\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644933362, 1644933362),
(135, 'default', '{\"uuid\":\"2600d028-b501-4f83-a174-29cf4d4ca2bc\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644933525, 1644933525),
(136, 'default', '{\"uuid\":\"48f2f9ef-b751-4cfd-8a80-153af2efa79d\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644933540, 1644933540);
INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(137, 'default', '{\"uuid\":\"1b005f7f-476b-4091-bcd8-9254a84b8732\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644933559, 1644933559),
(138, 'default', '{\"uuid\":\"1d6daae9-c714-4f49-a014-2f34c0299bdb\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644935712, 1644935712),
(139, 'default', '{\"uuid\":\"d5a3b862-71a3-4339-be32-c15c51ede20b\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644935841, 1644935841),
(140, 'default', '{\"uuid\":\"0ce311b2-8148-4706-8426-f6fce58a4d92\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644936675, 1644936675),
(141, 'default', '{\"uuid\":\"3e310a94-70b8-4746-bb03-8591e171bb18\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644936695, 1644936695),
(142, 'default', '{\"uuid\":\"a7ea8892-d7e0-4def-99d0-dc0725918f65\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644936923, 1644936923),
(143, 'default', '{\"uuid\":\"0ffc9dba-5ded-44e2-9559-7ab2b7abb6c6\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939039, 1644939039),
(144, 'default', '{\"uuid\":\"adae87c5-2cd9-453a-85cc-d35dbc5f5a74\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939063, 1644939063),
(145, 'default', '{\"uuid\":\"f990a352-487c-4fb0-99ed-47af7640b05b\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939280, 1644939280),
(146, 'default', '{\"uuid\":\"98690573-1e03-4acb-9786-a725bf901073\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939319, 1644939319),
(147, 'default', '{\"uuid\":\"7a51647d-473d-4f85-9ef2-50911b6d3e62\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939411, 1644939411),
(148, 'default', '{\"uuid\":\"93a0edae-971c-4249-8257-448487023cbb\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939429, 1644939429),
(149, 'default', '{\"uuid\":\"8df086df-c700-435f-aa76-ca9e6eeb4f15\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:20;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939454, 1644939454),
(150, 'default', '{\"uuid\":\"2e6559fb-d885-4a05-9a67-c13122f5e158\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939485, 1644939485),
(151, 'default', '{\"uuid\":\"e9cd69f4-b038-4b10-a882-dad5528b469d\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939583, 1644939583),
(152, 'default', '{\"uuid\":\"0b8177c4-f86a-4b1f-bfc2-464887a18ca6\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939592, 1644939592),
(153, 'default', '{\"uuid\":\"6d01d207-7e8c-4bc0-bda9-9fb62bea0feb\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:20;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939600, 1644939600),
(154, 'default', '{\"uuid\":\"779ee9d6-69f5-4b7d-acf7-f9971038872a\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939667, 1644939667),
(155, 'default', '{\"uuid\":\"0f9ef3e1-8b48-4902-ad42-a1ec62ec71c1\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939676, 1644939676),
(156, 'default', '{\"uuid\":\"2ec074c4-d14d-4a8a-ac4e-21b88f3ea3d3\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:20;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939684, 1644939684),
(157, 'default', '{\"uuid\":\"7004e6d8-8857-4248-8a9b-871f36439c0e\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939879, 1644939879),
(158, 'default', '{\"uuid\":\"a32183f6-2239-419f-af40-862def6fcd3b\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939914, 1644939914),
(159, 'default', '{\"uuid\":\"14c6ff6e-2804-4287-a6f0-4863be5ec504\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:20;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939925, 1644939925),
(160, 'default', '{\"uuid\":\"ef139066-5eaa-4296-95e6-641f233dea54\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644939945, 1644939945),
(161, 'default', '{\"uuid\":\"9fe852f1-8239-47a6-9e83-2e765deb058d\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644940079, 1644940079),
(162, 'default', '{\"uuid\":\"5963b04c-ad2f-46a6-89df-9afbde351c94\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644940104, 1644940104),
(163, 'default', '{\"uuid\":\"aa311cb7-6a6e-4202-88ae-ba6d49d14a14\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644941757, 1644941757),
(164, 'default', '{\"uuid\":\"951e4b0b-3a17-4a82-a3b3-26a41821a8d1\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644941772, 1644941772),
(165, 'default', '{\"uuid\":\"b11b9db3-d3ec-46e5-a239-e9e900f64004\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:20;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644941785, 1644941785),
(166, 'default', '{\"uuid\":\"b754cdfe-354f-4271-b44e-2f1260b3e870\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644941808, 1644941808),
(167, 'default', '{\"uuid\":\"4174defa-0100-419b-8e3a-5b0d5344af10\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644942238, 1644942238),
(168, 'default', '{\"uuid\":\"074cd964-1dc5-4e7a-ae2a-7557508ad3d4\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644942266, 1644942266),
(169, 'default', '{\"uuid\":\"b783441e-271c-44d0-ae0a-7b33e63e9f99\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:20;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644942280, 1644942280),
(170, 'default', '{\"uuid\":\"288f7b96-5d91-4151-bf07-ff3c53e9e584\",\"displayName\":\"App\\\\Jobs\\\\ApproveJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ApproveJob\",\"command\":\"O:19:\\\"App\\\\Jobs\\\\ApproveJob\\\":11:{s:7:\\\"patient\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\patient\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1644942294, 1644942294);

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(11, '2014_10_12_000000_create_users_table', 1),
(12, '2014_10_12_100000_create_password_resets_table', 1),
(13, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(14, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(15, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(16, '2016_06_01_000004_create_oauth_clients_table', 1),
(17, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(18, '2019_08_19_000000_create_failed_jobs_table', 1),
(19, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(20, '2022_01_14_195107_create_appointments_table', 1),
(21, '2022_01_21_170256_create_services_table', 2),
(22, '2022_01_21_170422_create_days_table', 2),
(23, '2022_01_21_185052_pivot_table', 3),
(24, '2022_01_21_185731_pivot_table', 4),
(25, '2022_01_24_233330_create_patients_table', 5),
(26, '2022_01_24_234051_create_patients_table', 6),
(27, '2022_01_25_184230_create_tops_table', 7),
(28, '2022_01_27_115810_create_jobs_table', 8),
(29, '2022_01_28_090706_create_motifs_table', 9),
(30, '2022_02_02_105914_create_societies_table', 10),
(31, '2022_02_02_105955_create_categories_table', 10),
(32, '2022_02_02_110022_society_category', 10),
(33, '2022_02_08_093703_create_grilles_table', 11),
(34, '2022_02_08_113354_create_date_rdvs_table', 12),
(35, '2022_03_04_084624_create_roles_table', 13),
(36, '2022_03_04_085510_create_permissions_table', 13),
(37, '2022_03_04_090007_create_role_permissions_table', 13),
(38, '2022_03_22_115937_create_contacts_table', 14),
(39, '2022_03_22_120430_create_patients_table', 15),
(40, '2022_03_22_123341_create_pays_table', 16),
(41, '2022_03_22_124623_patient', 17);

-- --------------------------------------------------------

--
-- Structure de la table `motifs`
--

DROP TABLE IF EXISTS `motifs`;
CREATE TABLE IF NOT EXISTS `motifs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `libelle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `motifs`
--

INSERT INTO `motifs` (`id`, `libelle`, `created_at`, `updated_at`) VALUES
(1, 'Consultation pédiatrie', '2022-01-28 08:24:11', '2022-01-28 09:00:49'),
(2, 'Consultation radio', '2022-01-28 10:03:17', '2022-01-28 10:03:17');

-- --------------------------------------------------------

--
-- Structure de la table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('fff119de9a63f4aea272f69c9c60de0ba7d5965764d3ae6dc01ec908253d70eaecb2bf66a1ef62d8', 1, '955b3978-b0d6-458e-9e65-d75ce193dd60', 'Mulamba', '[]', 0, '2022-03-30 07:12:41', '2022-03-30 07:12:41', '2022-04-30 09:12:41'),
('295d7107c2ed935f8fd418edc8675c3263aebfa74def9d20910ab4aad65f5154b5073610c91a842e', 1, '955b3978-b0d6-458e-9e65-d75ce193dd60', 'Mulamba', '[]', 0, '2022-03-30 07:01:42', '2022-03-30 07:01:42', '2022-04-30 09:01:42'),
('20ccf3ed8cdc6ba4f8f768bc18c7f71783e63c2304b93c3d2bc2a2c66a11e9201ae686309c9f21fe', 1, '955b3978-b0d6-458e-9e65-d75ce193dd60', 'Mulamba', '[]', 0, '2022-03-30 07:11:41', '2022-03-30 07:11:41', '2022-04-30 09:11:41'),
('7287c9eadae02a151b79bea37f7189fe0aed3c1329f9a6553f02606937c2c56583399bccc29964a8', 4, '955b3978-b0d6-458e-9e65-d75ce193dd60', 'Tegra', '[]', 0, '2022-02-04 14:10:15', '2022-02-04 14:10:15', '2022-03-04 15:10:15'),
('12d47a431bd0a62bd8ca7c9d8b920fdf5c5c74c021479274e4c0e4709c9fe7290c1a871dc8c6b6b5', 3, '955b3978-b0d6-458e-9e65-d75ce193dd60', 'Tata', '[]', 0, '2022-02-01 15:13:27', '2022-02-01 15:13:27', '2022-03-01 16:13:27'),
('b4eaac12e811a324445dd7fd4ef002309845a6d052d55edee28c15a56e183809ec2afdd2c06f5101', 1, '955b3978-b0d6-458e-9e65-d75ce193dd60', 'Mulamba', '[]', 0, '2022-03-30 06:55:51', '2022-03-30 06:55:51', '2022-04-30 08:55:51'),
('b77e62e4d8426da94fc4bafd3f85368262fc36b3523fb62d18b590c3a62e1233402a43b01bb71caf', 1, '955b3978-b0d6-458e-9e65-d75ce193dd60', 'Mulamba', '[]', 0, '2022-03-30 07:00:33', '2022-03-30 07:00:33', '2022-04-30 09:00:33'),
('b1a21d55f5784f35af04534216e9ad5c2c486202d6ec5b94c747a6bc0c7f7d1ca51f69e9a321e263', 2, '955b3978-b0d6-458e-9e65-d75ce193dd60', 'Toto', '[]', 0, '2022-02-08 09:01:43', '2022-02-08 09:01:43', '2022-03-08 10:01:43'),
('aa6d19e887a706044ac853d9dab6c99f4955f2e9f3a346e27caa77b7ba6eafe4fd122fd0640b59ae', 4, '955b3978-b0d6-458e-9e65-d75ce193dd60', 'recept', '[]', 0, '2022-03-11 13:00:51', '2022-03-11 13:00:51', '2022-04-11 14:00:51'),
('66a658cccd8aecd15699eeae6e63b8068187a9f654c25b14ceb9d4d05c2828ce552914d5ee896694', 4, '955b3978-b0d6-458e-9e65-d75ce193dd60', 'recept', '[]', 0, '2022-03-11 13:00:58', '2022-03-11 13:00:58', '2022-04-11 14:00:58');

-- --------------------------------------------------------

--
-- Structure de la table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
('955b3978-b0d6-458e-9e65-d75ce193dd60', NULL, 'Laravel Personal Access Client', 'ZLD7Ohf5GkBqvSBTUtJ6FIyh3SXoeOsbjLDfdLc9', NULL, 'http://localhost', 1, 0, 0, '2022-01-15 03:59:47', '2022-01-15 03:59:47'),
('955b3978-b801-4f76-9ca2-860e11d46a49', NULL, 'Laravel Password Grant Client', 'p0TTDTiLnAm1XJ8sXxY7MJ35jkoZtB5zAHbrKrNp', 'users', 'http://localhost', 0, 1, 0, '2022-01-15 03:59:47', '2022-01-15 03:59:47');

-- --------------------------------------------------------

--
-- Structure de la table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, '955b3978-b0d6-458e-9e65-d75ce193dd60', '2022-01-15 03:59:47', '2022-01-15 03:59:47');

-- --------------------------------------------------------

--
-- Structure de la table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `patients`
--

DROP TABLE IF EXISTS `patients`;
CREATE TABLE IF NOT EXISTS `patients` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pays_id` bigint(20) UNSIGNED DEFAULT NULL,
  `residence_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `society_id` bigint(20) UNSIGNED DEFAULT NULL,
  `num_dossier` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nom` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_naiss` date DEFAULT NULL,
  `lieu_naiss` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_carte_ident` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `langue` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sexe` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `etat_civil` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adresse` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `boite_postal` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone_fixe` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone_mobile` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profession` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_deb` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patients_pays_id_foreign` (`pays_id`),
  KEY `patients_residence_id_foreign` (`residence_id`),
  KEY `patients_user_id_foreign` (`user_id`),
  KEY `patients_category_id_foreign` (`category_id`),
  KEY `patients_society_id_foreign` (`society_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `patient_society`
--

DROP TABLE IF EXISTS `patient_society`;
CREATE TABLE IF NOT EXISTS `patient_society` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `society_id` bigint(20) UNSIGNED NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_society_society_id_foreign` (`society_id`),
  KEY `patient_society_patient_id_foreign` (`patient_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `iso` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nicename` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `iso3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numcode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phonecode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=240 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `pays`
--

INSERT INTO `pays` (`id`, `iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `created_at`, `updated_at`) VALUES
(1, 'AF', 'AFGHANISTAN', 'Afghanistan', 'AFG', '4', '93', NULL, NULL),
(2, 'AL', 'ALBANIA', 'Albania', 'ALB', '8', '355', NULL, NULL),
(3, 'DZ', 'ALGERIA', 'Algeria', 'DZA', '12', '213', NULL, NULL),
(4, 'AS', 'AMERICAN SAMOA', 'American Samoa', 'ASM', '16', '1684', NULL, NULL),
(5, 'AD', 'ANDORRA', 'Andorra', 'AND', '20', '376', NULL, NULL),
(6, 'AO', 'ANGOLA', 'Angola', 'AGO', '24', '244', NULL, NULL),
(7, 'AI', 'ANGUILLA', 'Anguilla', 'AIA', '660', '1264', NULL, NULL),
(8, 'AQ', 'ANTARCTICA', 'Antarctica', NULL, NULL, '0', NULL, NULL),
(9, 'AG', 'ANTIGUA AND BARBUDA', 'Antigua and Barbuda', 'ATG', '28', '1268', NULL, NULL),
(10, 'AR', 'ARGENTINA', 'Argentina', 'ARG', '32', '54', NULL, NULL),
(11, 'AM', 'ARMENIA', 'Armenia', 'ARM', '51', '374', NULL, NULL),
(12, 'AW', 'ARUBA', 'Aruba', 'ABW', '533', '297', NULL, NULL),
(13, 'AU', 'AUSTRALIA', 'Australia', 'AUS', '36', '61', NULL, NULL),
(14, 'AT', 'AUSTRIA', 'Austria', 'AUT', '40', '43', NULL, NULL),
(15, 'AZ', 'AZERBAIJAN', 'Azerbaijan', 'AZE', '31', '994', NULL, NULL),
(16, 'BS', 'BAHAMAS', 'Bahamas', 'BHS', '44', '1242', NULL, NULL),
(17, 'BH', 'BAHRAIN', 'Bahrain', 'BHR', '48', '973', NULL, NULL),
(18, 'BD', 'BANGLADESH', 'Bangladesh', 'BGD', '50', '880', NULL, NULL),
(19, 'BB', 'BARBADOS', 'Barbados', 'BRB', '52', '1246', NULL, NULL),
(20, 'BY', 'BELARUS', 'Belarus', 'BLR', '112', '375', NULL, NULL),
(21, 'BE', 'BELGIUM', 'Belgium', 'BEL', '56', '32', NULL, NULL),
(22, 'BZ', 'BELIZE', 'Belize', 'BLZ', '84', '501', NULL, NULL),
(23, 'BJ', 'BENIN', 'Benin', 'BEN', '204', '229', NULL, NULL),
(24, 'BM', 'BERMUDA', 'Bermuda', 'BMU', '60', '1441', NULL, NULL),
(25, 'BT', 'BHUTAN', 'Bhutan', 'BTN', '64', '975', NULL, NULL),
(26, 'BO', 'BOLIVIA', 'Bolivia', 'BOL', '68', '591', NULL, NULL),
(27, 'BA', 'BOSNIA AND HERZEGOVINA', 'Bosnia and Herzegovina', 'BIH', '70', '387', NULL, NULL),
(28, 'BW', 'BOTSWANA', 'Botswana', 'BWA', '72', '267', NULL, NULL),
(29, 'BV', 'BOUVET ISLAND', 'Bouvet Island', NULL, NULL, '0', NULL, NULL),
(30, 'BR', 'BRAZIL', 'Brazil', 'BRA', '76', '55', NULL, NULL),
(31, 'IO', 'BRITISH INDIAN OCEAN TERRITORY', 'British Indian Ocean Territory', NULL, NULL, '246', NULL, NULL),
(32, 'BN', 'BRUNEI DARUSSALAM', 'Brunei Darussalam', 'BRN', '96', '673', NULL, NULL),
(33, 'BG', 'BULGARIA', 'Bulgaria', 'BGR', '100', '359', NULL, NULL),
(34, 'BF', 'BURKINA FASO', 'Burkina Faso', 'BFA', '854', '226', NULL, NULL),
(35, 'BI', 'BURUNDI', 'Burundi', 'BDI', '108', '257', NULL, NULL),
(36, 'KH', 'CAMBODIA', 'Cambodia', 'KHM', '116', '855', NULL, NULL),
(37, 'CM', 'CAMEROON', 'Cameroon', 'CMR', '120', '237', NULL, NULL),
(38, 'CA', 'CANADA', 'Canada', 'CAN', '124', '1', NULL, NULL),
(39, 'CV', 'CAPE VERDE', 'Cape Verde', 'CPV', '132', '238', NULL, NULL),
(40, 'KY', 'CAYMAN ISLANDS', 'Cayman Islands', 'CYM', '136', '1345', NULL, NULL),
(41, 'CF', 'CENTRAL AFRICAN REPUBLIC', 'Central African Republic', 'CAF', '140', '236', NULL, NULL),
(42, 'TD', 'CHAD', 'Chad', 'TCD', '148', '235', NULL, NULL),
(43, 'CL', 'CHILE', 'Chile', 'CHL', '152', '56', NULL, NULL),
(44, 'CN', 'CHINA', 'China', 'CHN', '156', '86', NULL, NULL),
(45, 'CX', 'CHRISTMAS ISLAND', 'Christmas Island', NULL, NULL, '61', NULL, NULL),
(46, 'CC', 'COCOS (KEELING) ISLANDS', 'Cocos (Keeling) Islands', NULL, NULL, '672', NULL, NULL),
(47, 'CO', 'COLOMBIA', 'Colombia', 'COL', '170', '57', NULL, NULL),
(48, 'KM', 'COMOROS', 'Comoros', 'COM', '174', '269', NULL, NULL),
(49, 'CG', 'CONGO', 'Congo', 'COG', '178', '242', NULL, NULL),
(50, 'CD', 'DEMOCRATIC REPUBLIC OF CONGO', 'Democratic Republic of congo', 'COD', '180', '243', NULL, NULL),
(51, 'CK', 'COOK ISLANDS', 'Cook Islands', 'COK', '184', '682', NULL, NULL),
(52, 'CR', 'COSTA RICA', 'Costa Rica', 'CRI', '188', '506', NULL, NULL),
(53, 'CI', 'COTE D\'IVOIRE', 'Cote D\'Ivoire', 'CIV', '384', '225', NULL, NULL),
(54, 'HR', 'CROATIA', 'Croatia', 'HRV', '191', '385', NULL, NULL),
(55, 'CU', 'CUBA', 'Cuba', 'CUB', '192', '53', NULL, NULL),
(56, 'CY', 'CYPRUS', 'Cyprus', 'CYP', '196', '357', NULL, NULL),
(57, 'CZ', 'CZECH REPUBLIC', 'Czech Republic', 'CZE', '203', '420', NULL, NULL),
(58, 'DK', 'DENMARK', 'Denmark', 'DNK', '208', '45', NULL, NULL),
(59, 'DJ', 'DJIBOUTI', 'Djibouti', 'DJI', '262', '253', NULL, NULL),
(60, 'DM', 'DOMINICA', 'Dominica', 'DMA', '212', '1767', NULL, NULL),
(61, 'DO', 'DOMINICAN REPUBLIC', 'Dominican Republic', 'DOM', '214', '1809', NULL, NULL),
(62, 'EC', 'ECUADOR', 'Ecuador', 'ECU', '218', '593', NULL, NULL),
(63, 'EG', 'EGYPT', 'Egypt', 'EGY', '818', '20', NULL, NULL),
(64, 'SV', 'EL SALVADOR', 'El Salvador', 'SLV', '222', '503', NULL, NULL),
(65, 'GQ', 'EQUATORIAL GUINEA', 'Equatorial Guinea', 'GNQ', '226', '240', NULL, NULL),
(66, 'ER', 'ERITREA', 'Eritrea', 'ERI', '232', '291', NULL, NULL),
(67, 'EE', 'ESTONIA', 'Estonia', 'EST', '233', '372', NULL, NULL),
(68, 'ET', 'ETHIOPIA', 'Ethiopia', 'ETH', '231', '251', NULL, NULL),
(69, 'FK', 'FALKLAND ISLANDS (MALVINAS)', 'Falkland Islands (Malvinas)', 'FLK', '238', '500', NULL, NULL),
(70, 'FO', 'FAROE ISLANDS', 'Faroe Islands', 'FRO', '234', '298', NULL, NULL),
(71, 'FJ', 'FIJI', 'Fiji', 'FJI', '242', '679', NULL, NULL),
(72, 'FI', 'FINLAND', 'Finland', 'FIN', '246', '358', NULL, NULL),
(73, 'FR', 'FRANCE', 'France', 'FRA', '250', '33', NULL, NULL),
(74, 'GF', 'FRENCH GUIANA', 'French Guiana', 'GUF', '254', '594', NULL, NULL),
(75, 'PF', 'FRENCH POLYNESIA', 'French Polynesia', 'PYF', '258', '689', NULL, NULL),
(76, 'TF', 'FRENCH SOUTHERN TERRITORIES', 'French Southern Territories', NULL, NULL, '0', NULL, NULL),
(77, 'GA', 'GABON', 'Gabon', 'GAB', '266', '241', NULL, NULL),
(78, 'GM', 'GAMBIA', 'Gambia', 'GMB', '270', '220', NULL, NULL),
(79, 'GE', 'GEORGIA', 'Georgia', 'GEO', '268', '995', NULL, NULL),
(80, 'DE', 'GERMANY', 'Germany', 'DEU', '276', '49', NULL, NULL),
(81, 'GH', 'GHANA', 'Ghana', 'GHA', '288', '233', NULL, NULL),
(82, 'GI', 'GIBRALTAR', 'Gibraltar', 'GIB', '292', '350', NULL, NULL),
(83, 'GR', 'GREECE', 'Greece', 'GRC', '300', '30', NULL, NULL),
(84, 'GL', 'GREENLAND', 'Greenland', 'GRL', '304', '299', NULL, NULL),
(85, 'GD', 'GRENADA', 'Grenada', 'GRD', '308', '1473', NULL, NULL),
(86, 'GP', 'GUADELOUPE', 'Guadeloupe', 'GLP', '312', '590', NULL, NULL),
(87, 'GU', 'GUAM', 'Guam', 'GUM', '316', '1671', NULL, NULL),
(88, 'GT', 'GUATEMALA', 'Guatemala', 'GTM', '320', '502', NULL, NULL),
(89, 'GN', 'GUINEA', 'Guinea', 'GIN', '324', '224', NULL, NULL),
(90, 'GW', 'GUINEA-BISSAU', 'Guinea-Bissau', 'GNB', '624', '245', NULL, NULL),
(91, 'GY', 'GUYANA', 'Guyana', 'GUY', '328', '592', NULL, NULL),
(92, 'HT', 'HAITI', 'Haiti', 'HTI', '332', '509', NULL, NULL),
(93, 'HM', 'HEARD ISLAND AND MCDONALD ISLANDS', 'Heard Island and Mcdonald Islands', NULL, NULL, '0', NULL, NULL),
(94, 'VA', 'HOLY SEE (VATICAN CITY STATE)', 'Holy See (Vatican City State)', 'VAT', '336', '39', NULL, NULL),
(95, 'HN', 'HONDURAS', 'Honduras', 'HND', '340', '504', NULL, NULL),
(96, 'HK', 'HONG KONG', 'Hong Kong', 'HKG', '344', '852', NULL, NULL),
(97, 'HU', 'HUNGARY', 'Hungary', 'HUN', '348', '36', NULL, NULL),
(98, 'IS', 'ICELAND', 'Iceland', 'ISL', '352', '354', NULL, NULL),
(99, 'IN', 'INDIA', 'India', 'IND', '356', '91', NULL, NULL),
(100, 'ID', 'INDONESIA', 'Indonesia', 'IDN', '360', '62', NULL, NULL),
(101, 'IR', 'IRAN, ISLAMIC REPUBLIC OF', 'Iran, Islamic Republic of', 'IRN', '364', '98', NULL, NULL),
(102, 'IQ', 'IRAQ', 'Iraq', 'IRQ', '368', '964', NULL, NULL),
(103, 'IE', 'IRELAND', 'Ireland', 'IRL', '372', '353', NULL, NULL),
(104, 'IL', 'ISRAEL', 'Israel', 'ISR', '376', '972', NULL, NULL),
(105, 'IT', 'ITALY', 'Italy', 'ITA', '380', '39', NULL, NULL),
(106, 'JM', 'JAMAICA', 'Jamaica', 'JAM', '388', '1876', NULL, NULL),
(107, 'JP', 'JAPAN', 'Japan', 'JPN', '392', '81', NULL, NULL),
(108, 'JO', 'JORDAN', 'Jordan', 'JOR', '400', '962', NULL, NULL),
(109, 'KZ', 'KAZAKHSTAN', 'Kazakhstan', 'KAZ', '398', '7', NULL, NULL),
(110, 'KE', 'KENYA', 'Kenya', 'KEN', '404', '254', NULL, NULL),
(111, 'KI', 'KIRIBATI', 'Kiribati', 'KIR', '296', '686', NULL, NULL),
(112, 'KP', 'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF', 'Korea, Democratic People\'s Republic of', 'PRK', '408', '850', NULL, NULL),
(113, 'KR', 'KOREA, REPUBLIC OF', 'Korea, Republic of', 'KOR', '410', '82', NULL, NULL),
(114, 'KW', 'KUWAIT', 'Kuwait', 'KWT', '414', '965', NULL, NULL),
(115, 'KG', 'KYRGYZSTAN', 'Kyrgyzstan', 'KGZ', '417', '996', NULL, NULL),
(116, 'LA', 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC', 'Lao People\'s Democratic Republic', 'LAO', '418', '856', NULL, NULL),
(117, 'LV', 'LATVIA', 'Latvia', 'LVA', '428', '371', NULL, NULL),
(118, 'LB', 'LEBANON', 'Lebanon', 'LBN', '422', '961', NULL, NULL),
(119, 'LS', 'LESOTHO', 'Lesotho', 'LSO', '426', '266', NULL, NULL),
(120, 'LR', 'LIBERIA', 'Liberia', 'LBR', '430', '231', NULL, NULL),
(121, 'LY', 'LIBYAN ARAB JAMAHIRIYA', 'Libyan Arab Jamahiriya', 'LBY', '434', '218', NULL, NULL),
(122, 'LI', 'LIECHTENSTEIN', 'Liechtenstein', 'LIE', '438', '423', NULL, NULL),
(123, 'LT', 'LITHUANIA', 'Lithuania', 'LTU', '440', '370', NULL, NULL),
(124, 'LU', 'LUXEMBOURG', 'Luxembourg', 'LUX', '442', '352', NULL, NULL),
(125, 'MO', 'MACAO', 'Macao', 'MAC', '446', '853', NULL, NULL),
(126, 'MK', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF', 'Macedonia, the Former Yugoslav Republic of', 'MKD', '807', '389', NULL, NULL),
(127, 'MG', 'MADAGASCAR', 'Madagascar', 'MDG', '450', '261', NULL, NULL),
(128, 'MW', 'MALAWI', 'Malawi', 'MWI', '454', '265', NULL, NULL),
(129, 'MY', 'MALAYSIA', 'Malaysia', 'MYS', '458', '60', NULL, NULL),
(130, 'MV', 'MALDIVES', 'Maldives', 'MDV', '462', '960', NULL, NULL),
(131, 'ML', 'MALI', 'Mali', 'MLI', '466', '223', NULL, NULL),
(132, 'MT', 'MALTA', 'Malta', 'MLT', '470', '356', NULL, NULL),
(133, 'MH', 'MARSHALL ISLANDS', 'Marshall Islands', 'MHL', '584', '692', NULL, NULL),
(134, 'MQ', 'MARTINIQUE', 'Martinique', 'MTQ', '474', '596', NULL, NULL),
(135, 'MR', 'MAURITANIA', 'Mauritania', 'MRT', '478', '222', NULL, NULL),
(136, 'MU', 'MAURITIUS', 'Mauritius', 'MUS', '480', '230', NULL, NULL),
(137, 'YT', 'MAYOTTE', 'Mayotte', NULL, NULL, '269', NULL, NULL),
(138, 'MX', 'MEXICO', 'Mexico', 'MEX', '484', '52', NULL, NULL),
(139, 'FM', 'MICRONESIA, FEDERATED STATES OF', 'Micronesia, Federated States of', 'FSM', '583', '691', NULL, NULL),
(140, 'MD', 'MOLDOVA, REPUBLIC OF', 'Moldova, Republic of', 'MDA', '498', '373', NULL, NULL),
(141, 'MC', 'MONACO', 'Monaco', 'MCO', '492', '377', NULL, NULL),
(142, 'MN', 'MONGOLIA', 'Mongolia', 'MNG', '496', '976', NULL, NULL),
(143, 'MS', 'MONTSERRAT', 'Montserrat', 'MSR', '500', '1664', NULL, NULL),
(144, 'MA', 'MOROCCO', 'Morocco', 'MAR', '504', '212', NULL, NULL),
(145, 'MZ', 'MOZAMBIQUE', 'Mozambique', 'MOZ', '508', '258', NULL, NULL),
(146, 'MM', 'MYANMAR', 'Myanmar', 'MMR', '104', '95', NULL, NULL),
(147, 'NA', 'NAMIBIA', 'Namibia', 'NAM', '516', '264', NULL, NULL),
(148, 'NR', 'NAURU', 'Nauru', 'NRU', '520', '674', NULL, NULL),
(149, 'NP', 'NEPAL', 'Nepal', 'NPL', '524', '977', NULL, NULL),
(150, 'NL', 'NETHERLANDS', 'Netherlands', 'NLD', '528', '31', NULL, NULL),
(151, 'AN', 'NETHERLANDS ANTILLES', 'Netherlands Antilles', 'ANT', '530', '599', NULL, NULL),
(152, 'NC', 'NEW CALEDONIA', 'New Caledonia', 'NCL', '540', '687', NULL, NULL),
(153, 'NZ', 'NEW ZEALAND', 'New Zealand', 'NZL', '554', '64', NULL, NULL),
(154, 'NI', 'NICARAGUA', 'Nicaragua', 'NIC', '558', '505', NULL, NULL),
(155, 'NE', 'NIGER', 'Niger', 'NER', '562', '227', NULL, NULL),
(156, 'NG', 'NIGERIA', 'Nigeria', 'NGA', '566', '234', NULL, NULL),
(157, 'NU', 'NIUE', 'Niue', 'NIU', '570', '683', NULL, NULL),
(158, 'NF', 'NORFOLK ISLAND', 'Norfolk Island', 'NFK', '574', '672', NULL, NULL),
(159, 'MP', 'NORTHERN MARIANA ISLANDS', 'Northern Mariana Islands', 'MNP', '580', '1670', NULL, NULL),
(160, 'NO', 'NORWAY', 'Norway', 'NOR', '578', '47', NULL, NULL),
(161, 'OM', 'OMAN', 'Oman', 'OMN', '512', '968', NULL, NULL),
(162, 'PK', 'PAKISTAN', 'Pakistan', 'PAK', '586', '92', NULL, NULL),
(163, 'PW', 'PALAU', 'Palau', 'PLW', '585', '680', NULL, NULL),
(164, 'PS', 'PALESTINIAN TERRITORY, OCCUPIED', 'Palestinian Territory, Occupied', NULL, NULL, '970', NULL, NULL),
(165, 'PA', 'PANAMA', 'Panama', 'PAN', '591', '507', NULL, NULL),
(166, 'PG', 'PAPUA NEW GUINEA', 'Papua New Guinea', 'PNG', '598', '675', NULL, NULL),
(167, 'PY', 'PARAGUAY', 'Paraguay', 'PRY', '600', '595', NULL, NULL),
(168, 'PE', 'PERU', 'Peru', 'PER', '604', '51', NULL, NULL),
(169, 'PH', 'PHILIPPINES', 'Philippines', 'PHL', '608', '63', NULL, NULL),
(170, 'PN', 'PITCAIRN', 'Pitcairn', 'PCN', '612', '0', NULL, NULL),
(171, 'PL', 'POLAND', 'Poland', 'POL', '616', '48', NULL, NULL),
(172, 'PT', 'PORTUGAL', 'Portugal', 'PRT', '620', '351', NULL, NULL),
(173, 'PR', 'PUERTO RICO', 'Puerto Rico', 'PRI', '630', '1787', NULL, NULL),
(174, 'QA', 'QATAR', 'Qatar', 'QAT', '634', '974', NULL, NULL),
(175, 'RE', 'REUNION', 'Reunion', 'REU', '638', '262', NULL, NULL),
(176, 'RO', 'ROMANIA', 'Romania', 'ROM', '642', '40', NULL, NULL),
(177, 'RU', 'RUSSIAN FEDERATION', 'Russian Federation', 'RUS', '643', '70', NULL, NULL),
(178, 'RW', 'RWANDA', 'Rwanda', 'RWA', '646', '250', NULL, NULL),
(179, 'SH', 'SAINT HELENA', 'Saint Helena', 'SHN', '654', '290', NULL, NULL),
(180, 'KN', 'SAINT KITTS AND NEVIS', 'Saint Kitts and Nevis', 'KNA', '659', '1869', NULL, NULL),
(181, 'LC', 'SAINT LUCIA', 'Saint Lucia', 'LCA', '662', '1758', NULL, NULL),
(182, 'PM', 'SAINT PIERRE AND MIQUELON', 'Saint Pierre and Miquelon', 'SPM', '666', '508', NULL, NULL),
(183, 'VC', 'SAINT VINCENT AND THE GRENADINES', 'Saint Vincent and the Grenadines', 'VCT', '670', '1784', NULL, NULL),
(184, 'WS', 'SAMOA', 'Samoa', 'WSM', '882', '684', NULL, NULL),
(185, 'SM', 'SAN MARINO', 'San Marino', 'SMR', '674', '378', NULL, NULL),
(186, 'ST', 'SAO TOME AND PRINCIPE', 'Sao Tome and Principe', 'STP', '678', '239', NULL, NULL),
(187, 'SA', 'SAUDI ARABIA', 'Saudi Arabia', 'SAU', '682', '966', NULL, NULL),
(188, 'SN', 'SENEGAL', 'Senegal', 'SEN', '686', '221', NULL, NULL),
(189, 'CS', 'SERBIA AND MONTENEGRO', 'Serbia and Montenegro', NULL, NULL, '381', NULL, NULL),
(190, 'SC', 'SEYCHELLES', 'Seychelles', 'SYC', '690', '248', NULL, NULL),
(191, 'SL', 'SIERRA LEONE', 'Sierra Leone', 'SLE', '694', '232', NULL, NULL),
(192, 'SG', 'SINGAPORE', 'Singapore', 'SGP', '702', '65', NULL, NULL),
(193, 'SK', 'SLOVAKIA', 'Slovakia', 'SVK', '703', '421', NULL, NULL),
(194, 'SI', 'SLOVENIA', 'Slovenia', 'SVN', '705', '386', NULL, NULL),
(195, 'SB', 'SOLOMON ISLANDS', 'Solomon Islands', 'SLB', '90', '677', NULL, NULL),
(196, 'SO', 'SOMALIA', 'Somalia', 'SOM', '706', '252', NULL, NULL),
(197, 'ZA', 'SOUTH AFRICA', 'South Africa', 'ZAF', '710', '27', NULL, NULL),
(198, 'GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 'South Georgia and the South Sandwich Islands', NULL, NULL, '0', NULL, NULL),
(199, 'ES', 'SPAIN', 'Spain', 'ESP', '724', '34', NULL, NULL),
(200, 'LK', 'SRI LANKA', 'Sri Lanka', 'LKA', '144', '94', NULL, NULL),
(201, 'SD', 'SUDAN', 'Sudan', 'SDN', '736', '249', NULL, NULL),
(202, 'SR', 'SURINAME', 'Suriname', 'SUR', '740', '597', NULL, NULL),
(203, 'SJ', 'SVALBARD AND JAN MAYEN', 'Svalbard and Jan Mayen', 'SJM', '744', '47', NULL, NULL),
(204, 'SZ', 'SWAZILAND', 'Swaziland', 'SWZ', '748', '268', NULL, NULL),
(205, 'SE', 'SWEDEN', 'Sweden', 'SWE', '752', '46', NULL, NULL),
(206, 'CH', 'SWITZERLAND', 'Switzerland', 'CHE', '756', '41', NULL, NULL),
(207, 'SY', 'SYRIAN ARAB REPUBLIC', 'Syrian Arab Republic', 'SYR', '760', '963', NULL, NULL),
(208, 'TW', 'TAIWAN, PROVINCE OF CHINA', 'Taiwan, Province of China', 'TWN', '158', '886', NULL, NULL),
(209, 'TJ', 'TAJIKISTAN', 'Tajikistan', 'TJK', '762', '992', NULL, NULL),
(210, 'TZ', 'TANZANIA, UNITED REPUBLIC OF', 'Tanzania, United Republic of', 'TZA', '834', '255', NULL, NULL),
(211, 'TH', 'THAILAND', 'Thailand', 'THA', '764', '66', NULL, NULL),
(212, 'TL', 'TIMOR-LESTE', 'Timor-Leste', NULL, NULL, '670', NULL, NULL),
(213, 'TG', 'TOGO', 'Togo', 'TGO', '768', '228', NULL, NULL),
(214, 'TK', 'TOKELAU', 'Tokelau', 'TKL', '772', '690', NULL, NULL),
(215, 'TO', 'TONGA', 'Tonga', 'TON', '776', '676', NULL, NULL),
(216, 'TT', 'TRINIDAD AND TOBAGO', 'Trinidad and Tobago', 'TTO', '780', '1868', NULL, NULL),
(217, 'TN', 'TUNISIA', 'Tunisia', 'TUN', '788', '216', NULL, NULL),
(218, 'TR', 'TURKEY', 'Turkey', 'TUR', '792', '90', NULL, NULL),
(219, 'TM', 'TURKMENISTAN', 'Turkmenistan', 'TKM', '795', '7370', NULL, NULL),
(220, 'TC', 'TURKS AND CAICOS ISLANDS', 'Turks and Caicos Islands', 'TCA', '796', '1649', NULL, NULL),
(221, 'TV', 'TUVALU', 'Tuvalu', 'TUV', '798', '688', NULL, NULL),
(222, 'UG', 'UGANDA', 'Uganda', 'UGA', '800', '256', NULL, NULL),
(223, 'UA', 'UKRAINE', 'Ukraine', 'UKR', '804', '380', NULL, NULL),
(224, 'AE', 'UNITED ARAB EMIRATES', 'United Arab Emirates', 'ARE', '784', '971', NULL, NULL),
(225, 'GB', 'UNITED KINGDOM', 'United Kingdom', 'GBR', '826', '44', NULL, NULL),
(226, 'US', 'UNITED STATES', 'United States', 'USA', '840', '1', NULL, NULL),
(227, 'UM', 'UNITED STATES MINOR OUTLYING ISLANDS', 'United States Minor Outlying Islands', NULL, NULL, '1', NULL, NULL),
(228, 'UY', 'URUGUAY', 'Uruguay', 'URY', '858', '598', NULL, NULL),
(229, 'UZ', 'UZBEKISTAN', 'Uzbekistan', 'UZB', '860', '998', NULL, NULL),
(230, 'VU', 'VANUATU', 'Vanuatu', 'VUT', '548', '678', NULL, NULL),
(231, 'VE', 'VENEZUELA', 'Venezuela', 'VEN', '862', '58', NULL, NULL),
(232, 'VN', 'VIET NAM', 'Viet Nam', 'VNM', '704', '84', NULL, NULL),
(233, 'VG', 'VIRGIN ISLANDS, BRITISH', 'Virgin Islands, British', 'VGB', '92', '1284', NULL, NULL),
(234, 'VI', 'VIRGIN ISLANDS, U.S.', 'Virgin Islands, U.s.', 'VIR', '850', '1340', NULL, NULL),
(235, 'WF', 'WALLIS AND FUTUNA', 'Wallis and Futuna', 'WLF', '876', '681', NULL, NULL),
(236, 'EH', 'WESTERN SAHARA', 'Western Sahara', 'ESH', '732', '212', NULL, NULL),
(237, 'YE', 'YEMEN', 'Yemen', 'YEM', '887', '967', NULL, NULL),
(238, 'ZM', 'ZAMBIA', 'Zambia', 'ZMB', '894', '260', NULL, NULL),
(239, 'ZW', 'ZIMBABWE', 'Zimbabwe', 'ZWE', '716', '263', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `libelle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descriptions` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `permissions`
--

INSERT INTO `permissions` (`id`, `libelle`, `descriptions`, `created_at`, `updated_at`) VALUES
(1, 'HOME.STAT', 'Voir les statistiques sur la page d\'accueil', NULL, NULL),
(2, 'ADMIN.LIST', 'Afficher la liste des administrateurs', NULL, NULL),
(3, 'ADMIN.ADD', 'Ajouter un administrateur', NULL, NULL),
(4, 'ADMIN.DELETE', 'Supprimer un adminstrateur', NULL, NULL),
(5, 'ADMIN.EDIT', 'Modfier les informations d\'un administrateur', NULL, NULL),
(6, 'ADMIN.ACTIVE', 'Activer ou desactiver le status d\'un adminstrateur', NULL, NULL),
(7, 'RECEPTIONNISTE.LIST', 'Afficher la liste des receptionnistes', NULL, NULL),
(8, 'RECEPTIONNISTE.ADD', 'Ajouter un receptionniste', NULL, NULL),
(9, 'RECEPTIONNISTE.DELETE', 'Supprimer un receptionniste', NULL, NULL),
(10, 'RECEPTIONNISTE.EDIT', 'Modfier les informations d\'un receptionniste', NULL, NULL),
(11, 'RECEPTIONNISTE.ACTIVE', 'Activer ou desactiver le status d\'un receptionniste', NULL, NULL),
(12, 'DOCTEUR.LIST', 'Afficher la liste des docteurs', NULL, NULL),
(13, 'DOCTEUR.ADD', 'Ajouter un docteur', NULL, NULL),
(14, 'DOCTEUR.DELETE', 'Supprimer un docteur', NULL, NULL),
(15, 'DOCTEUR.EDIT', 'Modfier les informations d\'un docteur', NULL, NULL),
(16, 'DOCTEUR.ACTIVE', 'Activer ou desactiver le status d\'un docteur', NULL, NULL),
(17, 'DOCTEUR.HORAIRE.UNIQUE', 'Afficher l\'horaire du docteur par lui-même ', NULL, NULL),
(18, 'DOCTEUR.HORAIRE.LIST', 'Afficher l\'horaire de n\'importe quel docteur', NULL, NULL),
(19, 'DOCTEUR.HORAIRE.EDIT', 'Modfier les informations de l\'horaire de n\'importe quel docteur', NULL, NULL),
(20, 'DOCTEUR.HORAIRE.EDIT.UNIQUE', 'Modfier les informations de l\'horaire d\'un docteur par lui-même ', NULL, NULL),
(21, 'SERVICES.LIST', 'Afficher la liste des services', NULL, NULL),
(22, 'SERVICES.ADD', 'Ajouter un service', NULL, NULL),
(23, 'SERVICES.DELETE', 'Supprimer un service', NULL, NULL),
(24, 'SERVICES.EDIT', 'Modfier les informations d\'un service', NULL, NULL),
(25, 'MOTIFS.LIST', 'Afficher la liste des motifs', NULL, NULL),
(26, 'MOTIFS.ADD', 'Ajouter un motif', NULL, NULL),
(27, 'MOTIFS.EDIT', 'Modfier les informations d\'un motif', NULL, NULL),
(28, 'MOTIFS.DELETE', 'Supprimer un motif', NULL, NULL),
(29, 'RDV.LIST', 'Afficher les rendez-vous', NULL, NULL),
(30, 'RDV.ADD', 'Ajouter un rendez-vous', NULL, NULL),
(31, 'RDV.APPROUVER', 'Approuver un rendez-vous', NULL, NULL),
(32, 'SOCIETES.LIST', 'Afficher la liste des sociétés', NULL, NULL),
(33, 'SOCIETES.ADD', 'Ajouter une société', NULL, NULL),
(34, 'SOCIETES.DELETE', 'Supprimer une société', NULL, NULL),
(35, 'SOCIETES.EDIT', 'Modfier les informations d\'une société', NULL, NULL),
(36, 'CATEGORIE_SOCIETES.LIST', 'Afficher la liste des catégories_société', NULL, NULL),
(37, 'CATEGORIE_SOCIETES.ADD', 'Ajouter une catégorie_société', NULL, NULL),
(38, 'CATEGORIE_SOCIETES.DELETE', 'Supprimer une catégorie_société', NULL, NULL),
(39, 'CATEGORIE_SOCIETES.EDIT', 'Modifier les informations d\'une catégorie_société', NULL, NULL),
(40, 'ROLES.LIST', 'Afficher la liste des rôles', NULL, NULL),
(41, 'ROLES.ADD', 'Ajouter un rôle', NULL, NULL),
(42, 'ROLES.DELETE', 'Supprimer un rôle', NULL, NULL),
(43, 'ROLES.EDIT', 'Modifier les informations d\'un rôle', NULL, NULL),
(44, 'PERMISSIONS.LIST', 'Affcher la liste des permissions ', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `libelle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `roles`
--

INSERT INTO `roles` (`id`, `libelle`, `created_at`, `updated_at`) VALUES
(1, 'Administrateur', NULL, NULL),
(2, 'Docteur', '2022-03-11 12:03:01', '2022-03-11 12:03:01'),
(3, 'Receptionniste', '2022-03-11 12:04:51', '2022-03-11 12:04:51');

-- --------------------------------------------------------

--
-- Structure de la table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
CREATE TABLE IF NOT EXISTS `role_permissions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_permissions_role_id_foreign` (`role_id`),
  KEY `role_permissions_permission_id_foreign` (`permission_id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `role_permissions`
--

INSERT INTO `role_permissions` (`id`, `role_id`, `permission_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 1, 2, NULL, NULL),
(3, 1, 3, NULL, NULL),
(4, 1, 4, NULL, NULL),
(5, 1, 5, NULL, NULL),
(6, 1, 6, NULL, NULL),
(7, 1, 7, NULL, NULL),
(8, 1, 8, NULL, NULL),
(9, 1, 9, NULL, NULL),
(10, 1, 10, NULL, NULL),
(11, 1, 11, NULL, NULL),
(12, 1, 12, NULL, NULL),
(13, 1, 13, NULL, NULL),
(14, 1, 14, NULL, NULL),
(15, 1, 15, NULL, NULL),
(16, 1, 16, NULL, NULL),
(17, 1, 18, NULL, NULL),
(18, 1, 19, NULL, NULL),
(19, 1, 21, NULL, NULL),
(20, 1, 22, NULL, NULL),
(21, 1, 23, NULL, NULL),
(22, 1, 24, NULL, NULL),
(23, 1, 25, NULL, NULL),
(24, 1, 26, NULL, NULL),
(25, 1, 27, NULL, NULL),
(26, 1, 28, NULL, NULL),
(27, 1, 29, NULL, NULL),
(30, 1, 32, NULL, NULL),
(31, 1, 33, NULL, NULL),
(32, 1, 34, NULL, NULL),
(33, 1, 35, NULL, NULL),
(34, 1, 36, NULL, NULL),
(35, 1, 37, NULL, NULL),
(36, 1, 38, NULL, NULL),
(37, 1, 39, NULL, NULL),
(38, 1, 40, NULL, NULL),
(39, 1, 41, NULL, NULL),
(40, 1, 42, NULL, NULL),
(41, 1, 43, NULL, NULL),
(42, 1, 44, NULL, NULL),
(43, 2, 1, NULL, NULL),
(44, 2, 17, NULL, NULL),
(45, 2, 20, NULL, NULL),
(46, 3, 1, NULL, NULL),
(47, 3, 12, NULL, NULL),
(48, 3, 13, NULL, NULL),
(49, 3, 14, NULL, NULL),
(50, 3, 15, NULL, NULL),
(51, 3, 16, NULL, NULL),
(52, 3, 18, NULL, NULL),
(53, 3, 19, NULL, NULL),
(54, 3, 29, NULL, NULL),
(55, 3, 30, NULL, NULL),
(56, 3, 31, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `services`
--

DROP TABLE IF EXISTS `services`;
CREATE TABLE IF NOT EXISTS `services` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `libelle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `services`
--

INSERT INTO `services` (`id`, `libelle`, `created_at`, `updated_at`) VALUES
(1, 'Pédiatrie', '2022-01-28 07:29:40', '2022-01-28 07:29:40');

-- --------------------------------------------------------

--
-- Structure de la table `societies`
--

DROP TABLE IF EXISTS `societies`;
CREATE TABLE IF NOT EXISTS `societies` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `libelle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `societies_category_id_foreign` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `societies`
--

INSERT INTO `societies` (`id`, `libelle`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 'Aucune', 1, '2022-02-04 12:08:41', '2022-03-22 11:10:24'),
(2, 'Orange', 3, '2022-02-04 12:08:55', '2022-02-04 14:02:13'),
(3, 'Equity Bank', 3, '2022-02-04 12:09:06', '2022-02-04 12:09:06'),
(4, 'Vodacom', 2, '2022-02-04 13:58:28', '2022-02-04 13:58:28');

-- --------------------------------------------------------

--
-- Structure de la table `tops`
--

DROP TABLE IF EXISTS `tops`;
CREATE TABLE IF NOT EXISTS `tops` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `doctor_id` bigint(20) UNSIGNED NOT NULL,
  `max_patient` int(11) NOT NULL,
  `date_appoint` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tops_doctor_id_foreign` (`doctor_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `tops`
--

INSERT INTO `tops` (`id`, `doctor_id`, `max_patient`, `date_appoint`, `created_at`, `updated_at`) VALUES
(1, 3, 2, '2022-02-04', '2022-02-03 19:21:29', '2022-02-11 13:55:53'),
(2, 3, 3, '2022-02-08', '2022-02-08 09:02:27', '2022-02-08 09:17:07'),
(3, 4, 2, '2022-02-08', '2022-02-08 09:24:00', '2022-02-08 09:24:44'),
(4, 5, 3, '2022-02-08', '2022-02-08 09:28:40', '2022-02-08 09:39:05'),
(5, 3, 2, '2022-02-02', '2022-02-11 13:57:20', '2022-02-11 13:57:41'),
(6, 4, 1, '2022-02-01', '2022-02-11 13:59:27', '2022-02-11 13:59:27');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_level` int(11) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `service_id` int(11) DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `theme` int(11) NOT NULL DEFAULT '1',
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `telephone`, `admin_level`, `is_active`, `service_id`, `remember_token`, `created_at`, `updated_at`, `theme`, `role_id`) VALUES
(1, 'Mulamba', 'bgi@gmail.com', NULL, '$2y$10$Nw8h4FA8XMUn2TRnBq6VhebQSCf1L28wpneSJ.1RmkMFPDkDTIWGi', '0852277379', 3, 1, 1, NULL, '2022-03-08 07:16:44', '2022-03-23 16:32:04', 1, 1),
(2, 'test', 'test@gmail.com', NULL, '$2y$10$2vR4DtSZVqOexmJnYZ6fHOqIGe7.BPvLxz5ydqatv2IfjmNuWpN5i', '08556465161', 3, 1, 1, NULL, '2022-03-08 10:38:31', '2022-03-11 12:05:44', 1, 1),
(3, 'Enock', 'emk1802@gmail.com', NULL, '$2y$10$kCGZgTtLHR0x8XXw7pfnfuq22zSPh/YwCMQiqbSECBNveIUoxlhNu', '08522773795', 2, 1, 1, NULL, '2022-03-08 11:04:57', '2022-03-11 12:06:18', 1, 2),
(4, 'recept', 'recept@gmail.com', NULL, '$2y$10$YLWsuQuwaJ4QpbSXMU2aTexyj9WvEkQ.O9FtQzkAorB3jT.0V4cTW', '08551484000', 1, 1, 1, NULL, '2022-03-08 12:15:02', '2022-03-22 08:33:33', 1, 3);

-- --------------------------------------------------------

--
-- Structure de la table `user_day`
--

DROP TABLE IF EXISTS `user_day`;
CREATE TABLE IF NOT EXISTS `user_day` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `day_id` bigint(20) UNSIGNED NOT NULL,
  `max_patient` int(11) NOT NULL,
  `heure_deb` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `heure_fin` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_day_user_id_foreign` (`user_id`),
  KEY `user_day_day_id_foreign` (`day_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
