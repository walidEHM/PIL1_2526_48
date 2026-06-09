-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 09 juin 2026 à 18:49
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `mentorlink_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `annonce`
--

CREATE TABLE `annonce` (
  `idAnnonce` int(255) NOT NULL,
  `idUtilisateur` int(255) NOT NULL,
  `typeAnnonce` varchar(255) NOT NULL,
  `formatAnnonce` varchar(255) NOT NULL,
  `statutAnnonce` varchar(255) NOT NULL,
  `date_creationAnnonce` datetime NOT NULL DEFAULT current_timestamp(),
  `date_modificationAnnonce` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `annonce_competence`
--

CREATE TABLE `annonce_competence` (
  `idAnnonce` int(255) NOT NULL,
  `idCompetence` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `annonce_disponibilite`
--

CREATE TABLE `annonce_disponibilite` (
  `idAnnonce` int(255) NOT NULL,
  `idDisponibilite` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add filiere', 7, 'add_filiere'),
(26, 'Can change filiere', 7, 'change_filiere'),
(27, 'Can delete filiere', 7, 'delete_filiere'),
(28, 'Can view filiere', 7, 'view_filiere'),
(29, 'Can add utilisateur', 8, 'add_utilisateur'),
(30, 'Can change utilisateur', 8, 'change_utilisateur'),
(31, 'Can delete utilisateur', 8, 'delete_utilisateur'),
(32, 'Can view utilisateur', 8, 'view_utilisateur'),
(33, 'Can add competence', 9, 'add_competence'),
(34, 'Can change competence', 9, 'change_competence'),
(35, 'Can delete competence', 9, 'delete_competence'),
(36, 'Can view competence', 9, 'view_competence'),
(37, 'Can add utilisateur competence', 10, 'add_utilisateurcompetence'),
(38, 'Can change utilisateur competence', 10, 'change_utilisateurcompetence'),
(39, 'Can delete utilisateur competence', 10, 'delete_utilisateurcompetence'),
(40, 'Can view utilisateur competence', 10, 'view_utilisateurcompetence'),
(41, 'Can add disponibilite', 11, 'add_disponibilite'),
(42, 'Can change disponibilite', 11, 'change_disponibilite'),
(43, 'Can delete disponibilite', 11, 'delete_disponibilite'),
(44, 'Can view disponibilite', 11, 'view_disponibilite'),
(45, 'Can add annonce disponibilite', 12, 'add_annoncedisponibilite'),
(46, 'Can change annonce disponibilite', 12, 'change_annoncedisponibilite'),
(47, 'Can delete annonce disponibilite', 12, 'delete_annoncedisponibilite'),
(48, 'Can view annonce disponibilite', 12, 'view_annoncedisponibilite'),
(49, 'Can add annonce', 13, 'add_annonce'),
(50, 'Can change annonce', 13, 'change_annonce'),
(51, 'Can delete annonce', 13, 'delete_annonce'),
(52, 'Can view annonce', 13, 'view_annonce'),
(53, 'Can add annonce competence', 14, 'add_annoncecompetence'),
(54, 'Can change annonce competence', 14, 'change_annoncecompetence'),
(55, 'Can delete annonce competence', 14, 'delete_annoncecompetence'),
(56, 'Can view annonce competence', 14, 'view_annoncecompetence'),
(57, 'Can add match', 15, 'add_match'),
(58, 'Can change match', 15, 'change_match'),
(59, 'Can delete match', 15, 'delete_match'),
(60, 'Can view match', 15, 'view_match'),
(61, 'Can add conversation', 16, 'add_conversation'),
(62, 'Can change conversation', 16, 'change_conversation'),
(63, 'Can delete conversation', 16, 'delete_conversation'),
(64, 'Can view conversation', 16, 'view_conversation'),
(65, 'Can add message', 17, 'add_message'),
(66, 'Can change message', 17, 'change_message'),
(67, 'Can delete message', 17, 'delete_message'),
(68, 'Can view message', 17, 'view_message');

-- --------------------------------------------------------

--
-- Structure de la table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `competence`
--

CREATE TABLE `competence` (
  `idCompetence` int(255) NOT NULL,
  `nomCompetence` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `competence`
--

INSERT INTO `competence` (`idCompetence`, `nomCompetence`) VALUES
(1, 'python'),
(2, 'algo'),
(3, 'sql'),
(4, 'Mathematique'),
(5, 'Algorithmique'),
(6, 'Mathématiques'),
(7, 'Java'),
(8, 'HTML/CSS'),
(9, 'Machine Learning'),
(10, 'C/C++');

-- --------------------------------------------------------

--
-- Structure de la table `conversation`
--

CREATE TABLE `conversation` (
  `idConversation` int(11) NOT NULL,
  `idMatches` int(11) NOT NULL,
  `date_creationConversation` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `conversation`
--

INSERT INTO `conversation` (`idConversation`, `idMatches`, `date_creationConversation`) VALUES
(1, 6, '2026-06-09 12:42:04'),
(2, 7, '2026-06-09 14:35:02'),
(3, 8, '2026-06-09 14:35:08');

-- --------------------------------------------------------

--
-- Structure de la table `disponibilite`
--

CREATE TABLE `disponibilite` (
  `idDisponibilite` int(255) NOT NULL,
  `idUtilisateur` int(255) NOT NULL,
  `jourDisponibilite` varchar(255) NOT NULL,
  `heure_debutDisponibilite` time NOT NULL,
  `heure_finDisponibilite` time NOT NULL,
  `statutDisponibilite` varchar(255) NOT NULL,
  `date_creationDisponibilite` datetime NOT NULL DEFAULT current_timestamp(),
  `date_modificationDisponibilite` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `disponibilite`
--

INSERT INTO `disponibilite` (`idDisponibilite`, `idUtilisateur`, `jourDisponibilite`, `heure_debutDisponibilite`, `heure_finDisponibilite`, `statutDisponibilite`, `date_creationDisponibilite`, `date_modificationDisponibilite`) VALUES
(2, 1, 'Vendredi', '12:35:00', '18:00:00', 'disponible', '2026-06-09 08:03:07', '2026-06-09 08:03:07'),
(3, 2, 'Lundi', '08:00:00', '12:00:00', 'disponible', '2026-06-09 10:03:54', '2026-06-09 10:03:54'),
(4, 2, 'Mercredi', '14:00:00', '18:00:00', 'disponible', '2026-06-09 10:03:54', '2026-06-09 10:03:54'),
(5, 3, 'Mardi', '10:00:00', '14:00:00', 'disponible', '2026-06-09 10:03:55', '2026-06-09 10:03:55'),
(6, 3, 'Jeudi', '08:00:00', '12:00:00', 'disponible', '2026-06-09 10:03:55', '2026-06-09 10:03:55'),
(7, 4, 'Lundi', '14:00:00', '18:00:00', 'disponible', '2026-06-09 10:03:55', '2026-06-09 10:03:55'),
(8, 4, 'Vendredi', '08:00:00', '12:00:00', 'disponible', '2026-06-09 10:03:55', '2026-06-09 10:03:55'),
(9, 5, 'Mercredi', '08:00:00', '12:00:00', 'disponible', '2026-06-09 10:03:55', '2026-06-09 10:03:55'),
(10, 5, 'Samedi', '10:00:00', '14:00:00', 'disponible', '2026-06-09 10:03:55', '2026-06-09 10:03:55'),
(11, 6, 'Jeudi', '14:00:00', '18:00:00', 'disponible', '2026-06-09 10:03:56', '2026-06-09 10:03:56'),
(12, 6, 'Vendredi', '14:00:00', '18:00:00', 'disponible', '2026-06-09 10:03:56', '2026-06-09 10:03:56');

-- --------------------------------------------------------

--
-- Structure de la table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(9, 'accounts', 'competence'),
(11, 'accounts', 'disponibilite'),
(7, 'accounts', 'filiere'),
(8, 'accounts', 'utilisateur'),
(10, 'accounts', 'utilisateurcompetence'),
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(13, 'matching', 'annonce'),
(14, 'matching', 'annoncecompetence'),
(12, 'matching', 'annoncedisponibilite'),
(15, 'matching', 'match'),
(16, 'messaging', 'conversation'),
(17, 'messaging', 'message'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Structure de la table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-06-03 21:07:45.470928'),
(2, 'auth', '0001_initial', '2026-06-03 21:07:46.108909'),
(3, 'admin', '0001_initial', '2026-06-03 21:07:46.270669'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-06-03 21:07:46.287468'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-06-03 21:07:46.306075'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-06-03 21:07:46.437082'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-06-03 21:07:46.531441'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-06-03 21:07:46.576131'),
(9, 'auth', '0004_alter_user_username_opts', '2026-06-03 21:07:46.595083'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-06-03 21:07:46.720489'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-06-03 21:07:46.724250'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-06-03 21:07:46.732591'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-06-03 21:07:46.750542'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-06-03 21:07:46.764108'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-06-03 21:07:46.784778'),
(16, 'auth', '0011_update_proxy_permissions', '2026-06-03 21:07:46.791936'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-06-03 21:07:46.804027'),
(18, 'sessions', '0001_initial', '2026-06-03 21:07:46.853624'),
(19, 'accounts', '0001_initial', '2026-06-08 11:49:31.000000'),
(20, 'matching', '0001_initial', '2026-06-08 10:51:15.812157'),
(21, 'messaging', '0001_initial', '2026-06-08 10:51:15.867233'),
(22, 'accounts', '0002_alter_utilisateur_bio_and_more', '2026-06-08 13:13:25.281177'),
(23, 'accounts', '0003_alter_utilisateur_managers', '2026-06-09 07:19:14.104186'),
(24, 'matching', '0002_alter_annoncecompetence_unique_together_and_more', '2026-06-09 09:15:39.759757');

-- --------------------------------------------------------

--
-- Structure de la table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `filiere`
--

CREATE TABLE `filiere` (
  `idFiliere` int(255) NOT NULL,
  `nomFiliere` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `filiere`
--

INSERT INTO `filiere` (`idFiliere`, `nomFiliere`) VALUES
(1, 'GL'),
(2, 'IM'),
(3, 'SI'),
(4, 'IA'),
(5, 'IOT');

-- --------------------------------------------------------

--
-- Structure de la table `matches`
--

CREATE TABLE `matches` (
  `idMatches` int(255) NOT NULL,
  `idMentor` int(255) NOT NULL,
  `idMentore` int(255) NOT NULL,
  `score_compatibiliteMatch` float NOT NULL,
  `statutMatches` varchar(255) NOT NULL,
  `date_creationMatches` datetime NOT NULL DEFAULT current_timestamp(),
  `date_modificationMatches` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `matches`
--

INSERT INTO `matches` (`idMatches`, `idMentor`, `idMentore`, `score_compatibiliteMatch`, `statutMatches`, `date_creationMatches`, `date_modificationMatches`) VALUES
(6, 2, 1, 88.5, 'en_attente', '2026-06-09 10:40:50', '2026-06-09 10:40:50'),
(7, 3, 1, 75, 'en_attente', '2026-06-09 10:40:50', '2026-06-09 10:40:50'),
(8, 6, 1, 35, 'en_attente', '2026-06-09 10:40:50', '2026-06-09 15:38:31'),
(9, 4, 3, 80, 'en_attente', '2026-06-09 10:40:50', '2026-06-09 10:40:50'),
(10, 5, 4, 65, 'accepté', '2026-06-09 10:40:50', '2026-06-09 10:40:50'),
(11, 4, 1, 30, 'en_attente', '2026-06-09 10:51:02', '2026-06-09 15:38:31'),
(12, 1, 4, 50, 'en_attente', '2026-06-09 10:51:02', '2026-06-09 15:38:31'),
(13, 3, 2, 65, 'en_attente', '2026-06-09 12:43:49', '2026-06-09 15:49:53'),
(14, 2, 3, 65, 'en_attente', '2026-06-09 12:43:49', '2026-06-09 15:49:53'),
(15, 2, 4, 85, 'en_attente', '2026-06-09 12:43:49', '2026-06-09 15:49:53'),
(16, 6, 2, 70, 'en_attente', '2026-06-09 12:43:49', '2026-06-09 15:49:53');

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

CREATE TABLE `message` (
  `idMessage` int(11) NOT NULL,
  `idConversation` int(11) NOT NULL,
  `id_expediteurMessage` int(11) NOT NULL,
  `contenuMessage` text NOT NULL,
  `luMessage` tinyint(1) NOT NULL DEFAULT 0,
  `date_creationMessage` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `message`
--

INSERT INTO `message` (`idMessage`, `idConversation`, `id_expediteurMessage`, `contenuMessage`, `luMessage`, `date_creationMessage`) VALUES
(1, 1, 1, 'Bonjour', 1, '2026-06-09 12:42:11'),
(2, 1, 2, 'Salut', 1, '2026-06-09 12:44:11'),
(3, 1, 1, 'Comment ça va?', 1, '2026-06-09 12:44:29'),
(4, 1, 1, 'ça va?', 1, '2026-06-09 13:26:02'),
(5, 1, 2, 'oui ça va bien et toi?', 1, '2026-06-09 13:26:12'),
(6, 1, 1, 'je vais bien', 1, '2026-06-09 13:28:37'),
(7, 1, 2, 'quoi de neuf?', 1, '2026-06-09 13:28:46'),
(8, 1, 1, 'rien hein', 1, '2026-06-09 13:28:56'),
(9, 1, 1, 'ça va', 1, '2026-06-09 14:09:41'),
(10, 1, 2, 'cc', 1, '2026-06-09 14:09:53'),
(11, 1, 2, 'yo', 1, '2026-06-09 14:09:58'),
(12, 1, 2, 'yoy', 1, '2026-06-09 14:36:17'),
(13, 1, 2, 'yo', 1, '2026-06-09 14:36:18'),
(14, 1, 2, 'oui', 1, '2026-06-09 15:10:12'),
(15, 1, 1, 'comment ça va?', 1, '2026-06-09 15:10:29');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `idUtilisateur` int(255) NOT NULL,
  `nomUtilisateur` varchar(255) NOT NULL,
  `prenomUtilisateur` varchar(255) NOT NULL,
  `emailUtilisateur` varchar(255) NOT NULL,
  `telephoneUtilisateur` varchar(255) NOT NULL,
  `mot_de_passeUtilisateur` varchar(255) NOT NULL,
  `photoUtilisateur` varchar(255) DEFAULT NULL,
  `idFiliere` int(255) NOT NULL,
  `niveauUtilisateur` varchar(255) NOT NULL,
  `bioUtilisateur` text DEFAULT NULL,
  `centres_interetUtilisateur` text DEFAULT NULL,
  `date_CreationUtilisateur` datetime NOT NULL DEFAULT current_timestamp(),
  `username` varchar(150) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`idUtilisateur`, `nomUtilisateur`, `prenomUtilisateur`, `emailUtilisateur`, `telephoneUtilisateur`, `mot_de_passeUtilisateur`, `photoUtilisateur`, `idFiliere`, `niveauUtilisateur`, `bioUtilisateur`, `centres_interetUtilisateur`, `date_CreationUtilisateur`, `username`, `is_active`, `is_staff`, `is_superuser`, `last_login`) VALUES
(1, 'EL-HADJ MAMA', 'Abdoul-walid', 'elwalid2008@gmail.com', '+2290166493008', 'pbkdf2_sha256$600000$dhsR1mn4kSw45rR7andUrD$EdFJ18iCYwNnSHDU7IsOn/vUvfdvr8OA1yJ9dnJKQlc=', 'profils/photo.png', 4, 'L2', 'Focus', NULL, '2026-06-09 08:03:06', 'elwalid2008@gmail.com', 1, 1, 1, '2026-06-09 15:06:05.973780'),
(2, 'SOW', 'Amina', 'amina.sow@ifri.com', '+22960000001', 'pbkdf2_sha256$600000$3mdsSnf6pKSsheO2IFbnR5$F+8gBxnhbnAqb6b5HP0/5yit20qA1Mu67Z0gK8lQ5As=', '', 1, 'L3', 'Passionnée par le développement logiciel.', NULL, '2026-06-09 10:03:54', 'amina.sow@ifri.com', 1, 0, 0, '2026-06-09 12:43:49.460887'),
(3, 'MENSAH', 'Kofi', 'kofi.mensah@ifri.com', '+22960000002', 'pbkdf2_sha256$600000$wAXKeekv4FaTl3hNPAegmm$c2lvrhu/PZNOu0u1BA+RWWvzowwqKMPLyf5PNGYZWPQ=', '', 4, 'L2', 'Intéressé par l\'IA et le machine learning.', NULL, '2026-06-09 10:03:54', 'kofi.mensah@ifri.com', 1, 0, 0, NULL),
(4, 'DIALLO', 'Fatou', 'fatou.diallo@ifri.com', '+22960000003', 'pbkdf2_sha256$600000$SM70diChNsmUaaBmC2vDY5$X6I8K8lG5W5Smtf7MnRkYfK0Mwr3JEQNcn1zVTxFdk0=', '', 1, 'L2', 'Aime résoudre des problèmes complexes.', NULL, '2026-06-09 10:03:55', 'fatou.diallo@ifri.com', 1, 0, 0, NULL),
(5, 'KOUASSI', 'Yves', 'yves.kouassi@ifri.com', '+22960000004', 'pbkdf2_sha256$600000$dRjaBGCx7gJx3MRV28jd3J$mh3YY91Aycqp5TOo8qKjeY/fck3TTms7sxTCBtCZBBc=', '', 3, 'L3', 'Spécialiste des systèmes d\'information.', NULL, '2026-06-09 10:03:55', 'yves.kouassi@ifri.com', 1, 0, 0, NULL),
(6, 'BARRY', 'Aisha', 'aisha.barry@ifri.com', '+22960000005', 'pbkdf2_sha256$600000$R91Im6SVQxjSRqThv23F8A$n6L15RFoRnoSSMbgQv5ZPlXINCUSGZQWzSZ+3Yc+dro=', '', 4, 'L3', 'Passionnée par les mathématiques appliquées.', NULL, '2026-06-09 10:03:55', 'aisha.barry@ifri.com', 1, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur_competence`
--

CREATE TABLE `utilisateur_competence` (
  `idUtilisateur` int(255) NOT NULL,
  `idCompetence` int(255) NOT NULL,
  `typeUtilisateur_Competence` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateur_competence`
--

INSERT INTO `utilisateur_competence` (`idUtilisateur`, `idCompetence`, `typeUtilisateur_Competence`) VALUES
(1, 1, 'competence'),
(1, 2, 'competence'),
(1, 4, 'lacune'),
(2, 1, 'competence'),
(2, 3, 'competence'),
(2, 5, 'competence'),
(2, 9, 'lacune'),
(3, 1, 'competence'),
(3, 3, 'lacune'),
(3, 5, 'lacune'),
(3, 6, 'competence'),
(3, 9, 'competence'),
(4, 1, 'lacune'),
(4, 3, 'lacune'),
(4, 5, 'competence'),
(4, 7, 'competence'),
(4, 10, 'competence'),
(5, 3, 'competence'),
(5, 7, 'competence'),
(5, 8, 'competence'),
(5, 9, 'lacune'),
(5, 10, 'lacune'),
(6, 1, 'competence'),
(6, 6, 'competence'),
(6, 7, 'lacune'),
(6, 8, 'lacune'),
(6, 9, 'competence');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur_groups`
--

CREATE TABLE `utilisateur_groups` (
  `id` bigint(20) NOT NULL,
  `utilisateur_id` int(255) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur_user_permissions`
--

CREATE TABLE `utilisateur_user_permissions` (
  `id` bigint(20) NOT NULL,
  `utilisateur_id` int(255) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `annonce`
--
ALTER TABLE `annonce`
  ADD PRIMARY KEY (`idAnnonce`),
  ADD KEY `idUtilisateur` (`idUtilisateur`);

--
-- Index pour la table `annonce_competence`
--
ALTER TABLE `annonce_competence`
  ADD PRIMARY KEY (`idAnnonce`,`idCompetence`),
  ADD KEY `idCompetence` (`idCompetence`),
  ADD KEY `annonce_competence_idAnnonce_7c275520` (`idAnnonce`);

--
-- Index pour la table `annonce_disponibilite`
--
ALTER TABLE `annonce_disponibilite`
  ADD PRIMARY KEY (`idAnnonce`,`idDisponibilite`),
  ADD KEY `idDisponibilite` (`idDisponibilite`);

--
-- Index pour la table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Index pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Index pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Index pour la table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Index pour la table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Index pour la table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Index pour la table `competence`
--
ALTER TABLE `competence`
  ADD PRIMARY KEY (`idCompetence`);

--
-- Index pour la table `conversation`
--
ALTER TABLE `conversation`
  ADD PRIMARY KEY (`idConversation`),
  ADD KEY `idMatches` (`idMatches`);

--
-- Index pour la table `disponibilite`
--
ALTER TABLE `disponibilite`
  ADD PRIMARY KEY (`idDisponibilite`),
  ADD KEY `idUtilisateur` (`idUtilisateur`);

--
-- Index pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Index pour la table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Index pour la table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Index pour la table `filiere`
--
ALTER TABLE `filiere`
  ADD PRIMARY KEY (`idFiliere`);

--
-- Index pour la table `matches`
--
ALTER TABLE `matches`
  ADD PRIMARY KEY (`idMatches`),
  ADD KEY `idMentor` (`idMentor`),
  ADD KEY `idMentore` (`idMentore`);

--
-- Index pour la table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`idMessage`),
  ADD KEY `idConversation` (`idConversation`),
  ADD KEY `id_expediteurMessage` (`id_expediteurMessage`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`idUtilisateur`),
  ADD UNIQUE KEY `emailUtilisateur` (`emailUtilisateur`),
  ADD UNIQUE KEY `telephoneUtilisateur` (`telephoneUtilisateur`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `idFiliere` (`idFiliere`) USING BTREE;

--
-- Index pour la table `utilisateur_competence`
--
ALTER TABLE `utilisateur_competence`
  ADD PRIMARY KEY (`idUtilisateur`,`idCompetence`),
  ADD KEY `idCompetence` (`idCompetence`);

--
-- Index pour la table `utilisateur_groups`
--
ALTER TABLE `utilisateur_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ug_utilisateur_id_group_id_uniq` (`utilisateur_id`,`group_id`),
  ADD KEY `ug_group_id_fk` (`group_id`);

--
-- Index pour la table `utilisateur_user_permissions`
--
ALTER TABLE `utilisateur_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uup_utilisateur_id_permission_id_uniq` (`utilisateur_id`,`permission_id`),
  ADD KEY `uup_permission_id_fk` (`permission_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `annonce`
--
ALTER TABLE `annonce`
  MODIFY `idAnnonce` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT pour la table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `competence`
--
ALTER TABLE `competence`
  MODIFY `idCompetence` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `conversation`
--
ALTER TABLE `conversation`
  MODIFY `idConversation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `disponibilite`
--
ALTER TABLE `disponibilite`
  MODIFY `idDisponibilite` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `filiere`
--
ALTER TABLE `filiere`
  MODIFY `idFiliere` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `matches`
--
ALTER TABLE `matches`
  MODIFY `idMatches` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `message`
--
ALTER TABLE `message`
  MODIFY `idMessage` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `idUtilisateur` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `utilisateur_groups`
--
ALTER TABLE `utilisateur_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `utilisateur_user_permissions`
--
ALTER TABLE `utilisateur_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `annonce`
--
ALTER TABLE `annonce`
  ADD CONSTRAINT `annonce_ibfk_1` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `annonce_competence`
--
ALTER TABLE `annonce_competence`
  ADD CONSTRAINT `annonce_competence_ibfk_1` FOREIGN KEY (`idAnnonce`) REFERENCES `annonce` (`idAnnonce`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `annonce_competence_ibfk_2` FOREIGN KEY (`idCompetence`) REFERENCES `competence` (`idCompetence`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `annonce_disponibilite`
--
ALTER TABLE `annonce_disponibilite`
  ADD CONSTRAINT `annonce_disponibilite_ibfk_1` FOREIGN KEY (`idAnnonce`) REFERENCES `annonce` (`idAnnonce`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `annonce_disponibilite_ibfk_2` FOREIGN KEY (`idDisponibilite`) REFERENCES `disponibilite` (`idDisponibilite`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Contraintes pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Contraintes pour la table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Contraintes pour la table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Contraintes pour la table `conversation`
--
ALTER TABLE `conversation`
  ADD CONSTRAINT `conversation_ibfk_1` FOREIGN KEY (`idMatches`) REFERENCES `matches` (`idMatches`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `disponibilite`
--
ALTER TABLE `disponibilite`
  ADD CONSTRAINT `disponibilite_ibfk_1` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Contraintes pour la table `matches`
--
ALTER TABLE `matches`
  ADD CONSTRAINT `matches_ibfk_1` FOREIGN KEY (`idMentor`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `matches_ibfk_2` FOREIGN KEY (`idMentore`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`idConversation`) REFERENCES `conversation` (`idConversation`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `message_ibfk_2` FOREIGN KEY (`id_expediteurMessage`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `utilisateur_ibfk_1` FOREIGN KEY (`idFiliere`) REFERENCES `filiere` (`idFiliere`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `utilisateur_competence`
--
ALTER TABLE `utilisateur_competence`
  ADD CONSTRAINT `utilisateur_competence_ibfk_1` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `utilisateur_competence_ibfk_2` FOREIGN KEY (`idCompetence`) REFERENCES `competence` (`idCompetence`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `utilisateur_groups`
--
ALTER TABLE `utilisateur_groups`
  ADD CONSTRAINT `ug_group_id_fk` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `ug_utilisateur_id_fk` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`idUtilisateur`);

--
-- Contraintes pour la table `utilisateur_user_permissions`
--
ALTER TABLE `utilisateur_user_permissions`
  ADD CONSTRAINT `uup_permission_id_fk` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `uup_utilisateur_id_fk` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`idUtilisateur`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
