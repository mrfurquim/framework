CREATE TABLE `farmanimals` (
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `animalid` int(10) NOT NULL,
  `model` int(20) NOT NULL,
  `preset` int(2) NOT NULL,
  `name` varchar(50) NOT NULL,
  `xp` int(5) NOT NULL,
  `price` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
