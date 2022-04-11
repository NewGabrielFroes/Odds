-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 11/04/2022 às 22:10
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
(1, 'Copa Libertadores'),
(2, 'Categoría Primera A'),
(3, 'Primera Nacional B');

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
(1, '16775', 'Betano', 1),
(2, '16940', 'Betano', 2),
(3, '17244', 'Betano', 3);

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
(1, '2022-04-14 00:00:00', 1, 2, 1),
(2, '2022-04-14 00:00:00', 3, 4, 1),
(3, '2022-04-14 00:00:00', 5, 6, 1);

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
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 1, 11),
(12, 1, 12),
(13, 1, 13),
(14, 1, 14),
(15, 1, 15),
(16, 1, 16),
(17, 1, 17),
(18, 1, 18),
(19, 1, 19),
(20, 2, 1),
(21, 2, 2),
(22, 2, 3),
(23, 2, 4),
(24, 2, 5),
(25, 2, 6),
(26, 2, 7),
(27, 2, 8),
(28, 2, 9),
(29, 2, 10),
(30, 2, 11),
(31, 2, 12),
(32, 2, 13),
(33, 2, 14),
(34, 2, 15),
(35, 2, 18),
(36, 2, 19),
(37, 3, 1),
(38, 3, 2),
(39, 3, 3),
(40, 3, 4),
(41, 3, 5),
(42, 3, 6),
(43, 3, 7),
(44, 3, 8),
(45, 3, 9),
(46, 3, 10),
(47, 3, 11),
(48, 3, 12),
(49, 3, 13),
(50, 3, 14),
(51, 3, 15),
(52, 3, 16),
(53, 3, 17),
(54, 3, 18),
(55, 3, 19);

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
(1, 1.57, '2022-04-11 20:06:51', 1),
(2, 3.6, '2022-04-11 20:06:51', 2),
(3, 7.2, '2022-04-11 20:06:51', 3),
(4, 1.07, '2022-04-11 20:06:51', 4),
(5, 8.5, '2022-04-11 20:06:51', 5),
(6, 1.3, '2022-04-11 20:06:51', 6),
(7, 3.55, '2022-04-11 20:06:51', 7),
(8, 1.9, '2022-04-11 20:06:51', 8),
(9, 1.91, '2022-04-11 20:06:51', 9),
(10, 3.15, '2022-04-11 20:06:51', 10),
(11, 1.37, '2022-04-11 20:06:51', 11),
(12, 5.8, '2022-04-11 20:06:51', 12),
(13, 1.14, '2022-04-11 20:06:51', 13),
(14, 10.25, '2022-04-11 20:06:51', 14),
(15, 1.05, '2022-04-11 20:06:51', 15),
(16, 15.5, '2022-04-11 20:06:51', 16),
(17, 1.015, '2022-04-11 20:06:51', 17),
(18, 1.83, '2022-04-11 20:06:51', 18),
(19, 1.9, '2022-04-11 20:06:51', 19),
(20, 2.52, '2022-04-11 20:06:52', 20),
(21, 3.2, '2022-04-11 20:06:52', 21),
(22, 2.92, '2022-04-11 20:06:52', 22),
(23, 1.11, '2022-04-11 20:06:52', 23),
(24, 6.7, '2022-04-11 20:06:52', 24),
(25, 1.5, '2022-04-11 20:06:52', 25),
(26, 2.6, '2022-04-11 20:06:52', 26),
(27, 2.47, '2022-04-11 20:06:52', 27),
(28, 1.55, '2022-04-11 20:06:52', 28),
(29, 4.7, '2022-04-11 20:06:52', 29),
(30, 1.19, '2022-04-11 20:06:52', 30),
(31, 9, '2022-04-11 20:06:52', 31),
(32, 1.06, '2022-04-11 20:06:52', 32),
(33, 14.5, '2022-04-11 20:06:52', 33),
(34, 1.02, '2022-04-11 20:06:52', 34),
(35, 2.07, '2022-04-11 20:06:52', 35),
(36, 1.7, '2022-04-11 20:06:52', 36),
(37, 1.5, '2022-04-11 20:06:54', 37),
(38, 4.05, '2022-04-11 20:06:54', 38),
(39, 7.2, '2022-04-11 20:06:54', 39),
(40, 1.08, '2022-04-11 20:06:54', 40),
(41, 8, '2022-04-11 20:06:54', 41),
(42, 1.36, '2022-04-11 20:06:54', 42),
(43, 3.15, '2022-04-11 20:06:54', 43),
(44, 2.05, '2022-04-11 20:06:54', 44),
(45, 1.78, '2022-04-11 20:06:54', 45),
(46, 3.55, '2022-04-11 20:06:54', 46),
(47, 1.3, '2022-04-11 20:06:54', 47),
(48, 6.7, '2022-04-11 20:06:54', 48),
(49, 1.11, '2022-04-11 20:06:54', 49),
(50, 11.75, '2022-04-11 20:06:54', 50),
(51, 1.04, '2022-04-11 20:06:54', 51),
(52, 16.5, '2022-04-11 20:06:54', 52),
(53, 1.01, '2022-04-11 20:06:54', 53),
(54, 2.15, '2022-04-11 20:06:54', 54),
(55, 1.65, '2022-04-11 20:06:54', 55);

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
(19, 'BTSCNão', 'Betano', 19);

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
(1, 'River Plate'),
(2, 'Fortaleza'),
(3, 'Nacional Montevideo'),
(4, 'Estudiantes de La Plata'),
(5, 'Atlético-MG'),
(6, 'América-MG');

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
(1, '106694', 'Betano', 1),
(2, '107254', 'Betano', 2),
(3, '108331', 'Betano', 3),
(4, '107342', 'Betano', 4),
(5, '108204', 'Betano', 5),
(6, '110161', 'Betano', 6);

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
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT de tabela `fixtures_markets_odds`
--
ALTER TABLE `fixtures_markets_odds`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT de tabela `markets`
--
ALTER TABLE `markets`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de tabela `markets_map`
--
ALTER TABLE `markets_map`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de tabela `teams`
--
ALTER TABLE `teams`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `teams_map`
--
ALTER TABLE `teams_map`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
