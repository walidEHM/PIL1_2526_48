-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 04 juin 2026 à 21:22
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
-- Base de données : `bdifri_mentorlink`
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
-- Structure de la table `competence`
--

CREATE TABLE `competence` (
  `idCompetence` int(255) NOT NULL,
  `nomCompetence` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `conversation`
--

CREATE TABLE `conversation` (
  `idConversation` int(11) NOT NULL,
  `idMatches` int(11) NOT NULL,
  `date_creationConversation` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Structure de la table `filiere`
--

CREATE TABLE `filiere` (
  `idFiliere` int(255) NOT NULL,
  `nomFiliere` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

CREATE TABLE `message` (
  `idMessage` int(11) NOT NULL,
  `idConversation` int(11) NOT NULL,
  `id_expediteurMessage` int(11) NOT NULL,
  `contenuMessage` TEXT NOT NULL,
  `luMessage` TINYINT(1) NOT NULL DEFAULT 0, 
  `date_creationMessage` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `photoUtilisateur` varchar(255) NULL,
  `idFiliere` int(255) NOT NULL,
  `niveauUtilisateur` varchar(255) NOT NULL,
  `bioUtilisateur` text NULL,
  `centres_interetUtilisateur` text NULL,
  `date_CreationUtilisateur` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  ADD KEY `idCompetence` (`idCompetence`);

--
-- Index pour la table `annonce_disponibilite`
--
ALTER TABLE `annonce_disponibilite`
  ADD PRIMARY KEY (`idAnnonce`,`idDisponibilite`),
  ADD KEY `idDisponibilite` (`idDisponibilite`);

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
  ADD KEY `idFiliere` (`idFiliere`) USING BTREE;

--
-- Index pour la table `utilisateur_competence`
--
ALTER TABLE `utilisateur_competence`
  ADD PRIMARY KEY (`idUtilisateur`,`idCompetence`),
  ADD KEY `idCompetence` (`idCompetence`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `annonce`
--
ALTER TABLE `annonce`
  MODIFY `idAnnonce` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `competence`
--
ALTER TABLE `competence`
  MODIFY `idCompetence` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `conversation`
--
ALTER TABLE `conversation`
  MODIFY `idConversation` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `disponibilite`
--
ALTER TABLE `disponibilite`
  MODIFY `idDisponibilite` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `filiere`
--
ALTER TABLE `filiere`
  MODIFY `idFiliere` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `matches`
--
ALTER TABLE `matches`
  MODIFY `idMatches` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `message`
--
ALTER TABLE `message`
  MODIFY `idMessage` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `idUtilisateur` int(255) NOT NULL AUTO_INCREMENT;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
