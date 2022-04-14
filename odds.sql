-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 14/04/2022 às 22:01
-- Versão do servidor: 10.4.22-MariaDB
-- Versão do PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `odds`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `competitions`
--

CREATE TABLE `competitions` (
  `id` bigint(90) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `competitions`
--

INSERT INTO `competitions` (`id`, `name`) VALUES
(1, 'Super Lig'),
(2, 'Ligue 1'),
(3, 'Superettan');

-- --------------------------------------------------------

--
-- Estrutura para tabela `competitions_map`
--

CREATE TABLE `competitions_map` (
  `id` bigint(90) NOT NULL,
  `identifier` varchar(90) NOT NULL,
  `field_type` varchar(80) NOT NULL,
  `competitions_id` bigint(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `competitions_map`
--

INSERT INTO `competitions_map` (`id`, `identifier`, `field_type`, `competitions_id`) VALUES
(1, '17093', 'Betano', 1),
(2, 'Süper Lig', 'Placard', 1),
(3, '215', 'Betano', 2),
(4, 'Ligue 1', 'Placard', 2),
(5, '17121', 'Betano', 3),
(6, 'Superettan', 'Betano', 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `competitions_seasons`
--

CREATE TABLE `competitions_seasons` (
  `id` bigint(90) NOT NULL,
  `season` varchar(80) NOT NULL,
  `competition_id` bigint(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `competitions_seasons`
--

INSERT INTO `competitions_seasons` (`id`, `season`, `competition_id`) VALUES
(1, '2022', 1),
(2, '2022', 2),
(3, '2022', 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `fixtures`
--

CREATE TABLE `fixtures` (
  `id` bigint(80) NOT NULL,
  `date` datetime NOT NULL,
  `home_team` bigint(90) NOT NULL,
  `away_team` bigint(90) NOT NULL,
  `competitions_seasons_id` bigint(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `fixtures`
--

INSERT INTO `fixtures` (`id`, `date`, `home_team`, `away_team`, `competitions_seasons_id`) VALUES
(1, '2022-04-17 10:30:00', 1, 2, 1),
(2, '2022-04-17 11:00:00', 3, 4, 1),
(3, '2022-04-17 11:00:00', 5, 6, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `fixtures_markets`
--

CREATE TABLE `fixtures_markets` (
  `id` bigint(90) NOT NULL,
  `fixtures_id` bigint(90) NOT NULL,
  `markets_id` bigint(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `fixtures_markets`
--

INSERT INTO `fixtures_markets` (`id`, `fixtures_id`, `markets_id`) VALUES
(1, 1, 3),
(2, 1, 1),
(3, 1, 2),
(4, 2, 3),
(5, 2, 2),
(6, 2, 1),
(7, 3, 3),
(8, 3, 1),
(9, 3, 2),
(10, 1, 4),
(11, 1, 5),
(12, 1, 6),
(13, 1, 7),
(14, 1, 8),
(15, 1, 9),
(16, 1, 10),
(17, 1, 11),
(18, 1, 12),
(19, 1, 13),
(20, 1, 14),
(21, 1, 15),
(22, 1, 16),
(23, 1, 17),
(24, 1, 18),
(25, 1, 19),
(26, 2, 4),
(27, 2, 5),
(28, 2, 6),
(29, 2, 7),
(30, 2, 8),
(31, 2, 9),
(32, 2, 10),
(33, 2, 11),
(34, 2, 12),
(35, 2, 13),
(36, 2, 14),
(37, 2, 15),
(38, 2, 16),
(39, 2, 17),
(40, 2, 18),
(41, 2, 19),
(42, 3, 4),
(43, 3, 5),
(44, 3, 6),
(45, 3, 7),
(46, 3, 8),
(47, 3, 9),
(48, 3, 10),
(49, 3, 11),
(50, 3, 12),
(51, 3, 13),
(52, 3, 14),
(53, 3, 15),
(54, 3, 16),
(55, 3, 17),
(56, 3, 18),
(57, 3, 19);

-- --------------------------------------------------------

--
-- Estrutura para tabela `fixtures_markets_odds`
--

CREATE TABLE `fixtures_markets_odds` (
  `id` bigint(90) NOT NULL,
  `odd` float NOT NULL,
  `date` datetime NOT NULL,
  `fixtures_markets_id` bigint(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `fixtures_markets_odds`
--

INSERT INTO `fixtures_markets_odds` (`id`, `odd`, `date`, `fixtures_markets_id`) VALUES
(1, 4, '2022-04-14 19:57:26', 1),
(2, 1.75, '2022-04-14 19:57:26', 2),
(3, 3.6, '2022-04-14 19:57:27', 3),
(4, 4.75, '2022-04-14 19:57:27', 4),
(5, 3.5, '2022-04-14 19:57:27', 5),
(6, 1.67, '2022-04-14 19:57:27', 6),
(7, 3.3, '2022-04-14 19:57:27', 7),
(8, 2.05, '2022-04-14 19:57:27', 8),
(9, 3.3, '2022-04-14 19:57:28', 9),
(10, 1.8, '2022-04-14 19:57:44', 2),
(11, 3.7, '2022-04-14 19:57:45', 3),
(12, 4.15, '2022-04-14 19:57:45', 1),
(13, 1.06, '2022-04-14 19:57:45', 10),
(14, 9.75, '2022-04-14 19:57:45', 11),
(15, 1.27, '2022-04-14 19:57:45', 12),
(16, 3.8, '2022-04-14 19:57:45', 13),
(17, 1.82, '2022-04-14 19:57:46', 14),
(18, 2, '2022-04-14 19:57:46', 15),
(19, 3, '2022-04-14 19:57:46', 16),
(20, 1.4, '2022-04-14 19:57:46', 17),
(21, 5.4, '2022-04-14 19:57:46', 18),
(22, 1.16, '2022-04-14 19:57:46', 19),
(23, 9.75, '2022-04-14 19:57:47', 20),
(24, 1.06, '2022-04-14 19:57:47', 21),
(25, 15, '2022-04-14 19:57:47', 22),
(26, 1.015, '2022-04-14 19:57:47', 23),
(27, 1.72, '2022-04-14 19:57:47', 24),
(28, 2.05, '2022-04-14 19:57:47', 25),
(29, 1.75, '2022-04-14 19:57:47', 6),
(30, 3.85, '2022-04-14 19:57:47', 5),
(31, 4.65, '2022-04-14 19:57:47', 4),
(32, 1.07, '2022-04-14 19:57:48', 26),
(33, 8.5, '2022-04-14 19:57:48', 27),
(34, 1.37, '2022-04-14 19:57:48', 28),
(35, 3.15, '2022-04-14 19:57:48', 29),
(36, 2.07, '2022-04-14 19:57:48', 30),
(37, 1.75, '2022-04-14 19:57:48', 31),
(38, 3.65, '2022-04-14 19:57:48', 32),
(39, 1.29, '2022-04-14 19:57:49', 33),
(40, 6.9, '2022-04-14 19:57:49', 34),
(41, 1.1, '2022-04-14 19:57:49', 35),
(42, 12, '2022-04-14 19:57:49', 36),
(43, 1.03, '2022-04-14 19:57:49', 37),
(44, 17, '2022-04-14 19:57:49', 38),
(45, 1.009, '2022-04-14 19:57:50', 39),
(46, 2, '2022-04-14 19:57:50', 40),
(47, 1.75, '2022-04-14 19:57:50', 41),
(48, 2.05, '2022-04-14 19:57:50', 8),
(49, 3.4, '2022-04-14 19:57:50', 9),
(50, 3.3, '2022-04-14 19:57:50', 7),
(51, 1.06, '2022-04-14 19:57:50', 42),
(52, 7.3, '2022-04-14 19:57:51', 43),
(53, 1.29, '2022-04-14 19:57:51', 44),
(54, 3.25, '2022-04-14 19:57:51', 45),
(55, 1.87, '2022-04-14 19:57:51', 46),
(56, 1.85, '2022-04-14 19:57:51', 47),
(57, 3.05, '2022-04-14 19:57:51', 48),
(58, 1.33, '2022-04-14 19:57:51', 49),
(59, 5.2, '2022-04-14 19:57:51', 50),
(60, 1.13, '2022-04-14 19:57:52', 51),
(61, 8.25, '2022-04-14 19:57:52', 52),
(62, 1.04, '2022-04-14 19:57:52', 53),
(63, 10.75, '2022-04-14 19:57:52', 54),
(64, 1.015, '2022-04-14 19:57:52', 55),
(65, 1.72, '2022-04-14 19:57:52', 56),
(66, 2, '2022-04-14 19:57:53', 57),
(67, 4, '2022-04-14 19:58:23', 1),
(68, 1.75, '2022-04-14 19:58:23', 2),
(69, 3.6, '2022-04-14 19:58:23', 3),
(70, 4.75, '2022-04-14 19:58:23', 4),
(71, 3.5, '2022-04-14 19:58:23', 5),
(72, 1.67, '2022-04-14 19:58:23', 6),
(73, 3.3, '2022-04-14 19:58:23', 7),
(74, 2.05, '2022-04-14 19:58:23', 8),
(75, 3.3, '2022-04-14 19:58:23', 9),
(76, 1.8, '2022-04-14 19:58:27', 2),
(77, 3.7, '2022-04-14 19:58:27', 3),
(78, 4.15, '2022-04-14 19:58:27', 1),
(79, 1.06, '2022-04-14 19:58:27', 10),
(80, 9.75, '2022-04-14 19:58:27', 11),
(81, 1.27, '2022-04-14 19:58:27', 12),
(82, 3.8, '2022-04-14 19:58:27', 13),
(83, 1.82, '2022-04-14 19:58:27', 14),
(84, 2, '2022-04-14 19:58:27', 15),
(85, 3, '2022-04-14 19:58:27', 16),
(86, 1.4, '2022-04-14 19:58:27', 17),
(87, 5.4, '2022-04-14 19:58:28', 18),
(88, 1.16, '2022-04-14 19:58:28', 19),
(89, 9.75, '2022-04-14 19:58:28', 20),
(90, 1.06, '2022-04-14 19:58:28', 21),
(91, 15, '2022-04-14 19:58:28', 22),
(92, 1.015, '2022-04-14 19:58:28', 23),
(93, 1.72, '2022-04-14 19:58:28', 24),
(94, 2.05, '2022-04-14 19:58:28', 25),
(95, 1.75, '2022-04-14 19:58:28', 6),
(96, 3.85, '2022-04-14 19:58:28', 5),
(97, 4.65, '2022-04-14 19:58:28', 4),
(98, 1.07, '2022-04-14 19:58:28', 26),
(99, 8.5, '2022-04-14 19:58:28', 27),
(100, 1.37, '2022-04-14 19:58:28', 28),
(101, 3.15, '2022-04-14 19:58:28', 29),
(102, 2.07, '2022-04-14 19:58:29', 30),
(103, 1.75, '2022-04-14 19:58:29', 31),
(104, 3.65, '2022-04-14 19:58:29', 32),
(105, 1.29, '2022-04-14 19:58:29', 33),
(106, 6.9, '2022-04-14 19:58:29', 34),
(107, 1.1, '2022-04-14 19:58:29', 35),
(108, 12, '2022-04-14 19:58:29', 36),
(109, 1.03, '2022-04-14 19:58:29', 37),
(110, 17, '2022-04-14 19:58:29', 38),
(111, 1.009, '2022-04-14 19:58:29', 39),
(112, 2, '2022-04-14 19:58:29', 40),
(113, 1.75, '2022-04-14 19:58:29', 41),
(114, 2.05, '2022-04-14 19:58:29', 8),
(115, 3.4, '2022-04-14 19:58:29', 9),
(116, 3.3, '2022-04-14 19:58:29', 7),
(117, 1.06, '2022-04-14 19:58:30', 42),
(118, 7.3, '2022-04-14 19:58:30', 43),
(119, 1.29, '2022-04-14 19:58:30', 44),
(120, 3.25, '2022-04-14 19:58:30', 45),
(121, 1.87, '2022-04-14 19:58:30', 46),
(122, 1.85, '2022-04-14 19:58:30', 47),
(123, 3.05, '2022-04-14 19:58:30', 48),
(124, 1.33, '2022-04-14 19:58:30', 49),
(125, 5.2, '2022-04-14 19:58:30', 50),
(126, 1.13, '2022-04-14 19:58:30', 51),
(127, 8.25, '2022-04-14 19:58:30', 52),
(128, 1.04, '2022-04-14 19:58:30', 53),
(129, 10.75, '2022-04-14 19:58:30', 54),
(130, 1.015, '2022-04-14 19:58:31', 55),
(131, 1.72, '2022-04-14 19:58:31', 56),
(132, 2, '2022-04-14 19:58:31', 57);

-- --------------------------------------------------------

--
-- Estrutura para tabela `markets`
--

CREATE TABLE `markets` (
  `id` bigint(90) NOT NULL,
  `name` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `markets`
--

INSERT INTO `markets` (`id`, `name`) VALUES
(1, 'hometeamwin'),
(2, 'draw'),
(3, 'awayteamwin'),
(4, 'Over 0.5 Goals'),
(5, 'Under 0.5 Goals'),
(6, 'Over 1.5 Goals'),
(7, 'Under 1.5 Goals'),
(8, 'Over 2.5 Goals'),
(9, 'Under 2.5 Goals'),
(10, 'Over 3.5 Goals'),
(11, 'Under 3.5 Goals'),
(12, 'Over 4.5 Goals'),
(13, 'Under 4.5 Goals'),
(14, 'Over 5.5 Goals'),
(15, 'Under 5.5 Goals'),
(16, 'Over 6.5 Goals'),
(17, 'Under 6.5 Goals'),
(18, 'Both Teams Score? Yes'),
(19, 'Both Teams Score? No');

-- --------------------------------------------------------

--
-- Estrutura para tabela `markets_map`
--

CREATE TABLE `markets_map` (
  `id` bigint(90) NOT NULL,
  `identifier` varchar(90) NOT NULL,
  `field_type` varchar(80) NOT NULL,
  `markets_id` bigint(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `markets_map`
--

INSERT INTO `markets_map` (`id`, `identifier`, `field_type`, `markets_id`) VALUES
(1, 'MRES1', 'Betano', 1),
(2, 'MRESX', 'Betano', 2),
(3, 'MRES2', 'Betano', 3),
(4, 'HCTGMais de 0.5', 'Betano', 4),
(5, 'HCTGMenos de 0.5', 'Betano', 5),
(6, 'HCTGMais de 1.5', 'Betano', 6),
(7, 'HCTGMenos de 1.5', 'Betano', 7),
(8, 'HCTGMais de 2.5', 'Betano', 8),
(9, 'HCTGMenos de 2.5', 'Betano', 9),
(10, 'HCTGMais de 3.5', 'Betano', 10),
(11, 'HCTGMenos de 3.5', 'Betano', 11),
(12, 'HCTGMais de 4.5', 'Betano', 12),
(13, 'HCTGMenos de 4.5', 'Betano', 13),
(14, 'HCTGMais de 5.5', 'Betano', 14),
(15, 'HCTGMenos de 5.5', 'Betano', 15),
(16, 'HCTGMais de 6.5', 'Betano', 16),
(17, 'HCTGMenos de 6.5', 'Betano', 17),
(18, 'BTSCSim', 'Betano', 18),
(19, 'BTSCNão', 'Betano', 19),
(20, '1x2awayTeam', 'Placard', 3),
(21, '1x2homeTeam', 'Placard', 1),
(22, '1x2draw', 'Placard', 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `teams`
--

CREATE TABLE `teams` (
  `id` bigint(90) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `teams`
--

INSERT INTO `teams` (`id`, `name`) VALUES
(1, 'Konyaspor'),
(2, 'Gaziantep FK'),
(3, 'Nice'),
(4, 'FC Lorient'),
(5, 'Västeras SK'),
(6, 'Utsiktens BK');

-- --------------------------------------------------------

--
-- Estrutura para tabela `teams_map`
--

CREATE TABLE `teams_map` (
  `id` bigint(90) NOT NULL,
  `identifier` varchar(90) NOT NULL,
  `field_type` varchar(80) NOT NULL,
  `teams_id` bigint(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `teams_map`
--

INSERT INTO `teams_map` (`id`, `identifier`, `field_type`, `teams_id`) VALUES
(1, '106559', 'Betano', 1),
(2, 'Konyaspor', 'Placard', 1),
(3, '1889566', 'Betano', 2),
(4, 'Gazisehir Gaziantep FK', 'Placard', 2),
(5, '106645', 'Betano', 3),
(6, 'Nice', 'Placard', 3),
(7, '106889', 'Betano', 4),
(8, 'Lorient', 'Placard', 4),
(9, '107132', 'Betano', 5),
(10, 'Vasteraas SK', 'Placard', 5),
(11, '109170', 'Betano', 6),
(12, 'Utsiktens BK', 'Placard', 6);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `competitions`
--
ALTER TABLE `competitions`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `competitions_map`
--
ALTER TABLE `competitions_map`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_competitionsmap_competitions` (`competitions_id`);

--
-- Índices de tabela `competitions_seasons`
--
ALTER TABLE `competitions_seasons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_competitionsseasons_competitions` (`competition_id`);

--
-- Índices de tabela `fixtures`
--
ALTER TABLE `fixtures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_fixtures_competitionsseasons` (`competitions_seasons_id`),
  ADD KEY `fk_fixtures_teamnsmap` (`home_team`),
  ADD KEY `fk2_fixtures_teamnsmap` (`away_team`);

--
-- Índices de tabela `fixtures_markets`
--
ALTER TABLE `fixtures_markets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_fixturesmarkets_markets` (`markets_id`),
  ADD KEY `fk_fixturesmarkets_fixtures` (`fixtures_id`);

--
-- Índices de tabela `fixtures_markets_odds`
--
ALTER TABLE `fixtures_markets_odds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_fixturesmarketsodds_fixturesmarkets` (`fixtures_markets_id`);

--
-- Índices de tabela `markets`
--
ALTER TABLE `markets`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `markets_map`
--
ALTER TABLE `markets_map`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_marketsmap_markets` (`markets_id`);

--
-- Índices de tabela `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `teams_map`
--
ALTER TABLE `teams_map`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_teamnsmap_teamns` (`teams_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `competitions`
--
ALTER TABLE `competitions`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `competitions_map`
--
ALTER TABLE `competitions_map`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `competitions_seasons`
--
ALTER TABLE `competitions_seasons`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `fixtures`
--
ALTER TABLE `fixtures`
  MODIFY `id` bigint(80) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `fixtures_markets`
--
ALTER TABLE `fixtures_markets`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de tabela `fixtures_markets_odds`
--
ALTER TABLE `fixtures_markets_odds`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT de tabela `markets`
--
ALTER TABLE `markets`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de tabela `markets_map`
--
ALTER TABLE `markets_map`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de tabela `teams`
--
ALTER TABLE `teams`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `teams_map`
--
ALTER TABLE `teams_map`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `competitions_map`
--
ALTER TABLE `competitions_map`
  ADD CONSTRAINT `fk_competitionsmap_competitions` FOREIGN KEY (`competitions_id`) REFERENCES `competitions` (`id`);

--
-- Restrições para tabelas `competitions_seasons`
--
ALTER TABLE `competitions_seasons`
  ADD CONSTRAINT `fk_competitionsseasons_competitions` FOREIGN KEY (`competition_id`) REFERENCES `competitions` (`id`);

--
-- Restrições para tabelas `fixtures`
--
ALTER TABLE `fixtures`
  ADD CONSTRAINT `fk2_fixtures_teamnsmap` FOREIGN KEY (`away_team`) REFERENCES `teams` (`id`),
  ADD CONSTRAINT `fk_fixtures_competitionsseasons` FOREIGN KEY (`competitions_seasons_id`) REFERENCES `competitions_seasons` (`id`),
  ADD CONSTRAINT `fk_fixtures_teamnsmap` FOREIGN KEY (`home_team`) REFERENCES `teams` (`id`);

--
-- Restrições para tabelas `fixtures_markets`
--
ALTER TABLE `fixtures_markets`
  ADD CONSTRAINT `fk_fixturesmarkets_fixtures` FOREIGN KEY (`fixtures_id`) REFERENCES `fixtures` (`id`),
  ADD CONSTRAINT `fk_fixturesmarkets_markets` FOREIGN KEY (`markets_id`) REFERENCES `markets` (`id`);

--
-- Restrições para tabelas `fixtures_markets_odds`
--
ALTER TABLE `fixtures_markets_odds`
  ADD CONSTRAINT `fk_fixturesmarketsodds_fixturesmarkets` FOREIGN KEY (`fixtures_markets_id`) REFERENCES `fixtures_markets` (`id`);

--
-- Restrições para tabelas `markets_map`
--
ALTER TABLE `markets_map`
  ADD CONSTRAINT `fk_marketsmap_markets` FOREIGN KEY (`markets_id`) REFERENCES `markets` (`id`);

--
-- Restrições para tabelas `teams_map`
--
ALTER TABLE `teams_map`
  ADD CONSTRAINT `fk_teamnsmap_teamns` FOREIGN KEY (`teams_id`) REFERENCES `teams` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
