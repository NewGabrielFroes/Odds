-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 13/04/2022 às 15:27
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
(2, 'Taça Libertadores', 'Placard', 1),
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
(1, '2022', 1);

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
(20, '1x2{homeTeam}', 'Placard', 1),
(21, '1x2draw', 'Placard', 2),
(22, '1x2{awayTeam}', 'Placard', 2);

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
(6, '110161', 'Betano', 6),
(7, 'River Plate', 'Placard', 1),
(8, 'Fortaleza-Ce', 'Placard', 2),
(9, 'Nacional de Football', 'Placard', 3),
(10, 'Estudiantes de La Plata', 'Placard', 4),
(11, 'Atlético MG', 'Placard', 5),
(12, 'América Mineiro MG', 'Placard', 6);

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
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `fixtures`
--
ALTER TABLE `fixtures`
  MODIFY `id` bigint(80) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `fixtures_markets`
--
ALTER TABLE `fixtures_markets`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `fixtures_markets_odds`
--
ALTER TABLE `fixtures_markets_odds`
  MODIFY `id` bigint(90) NOT NULL AUTO_INCREMENT;

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
