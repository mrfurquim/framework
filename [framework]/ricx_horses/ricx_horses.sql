CREATE TABLE IF NOT EXISTS `ricxhorses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `charid` int(5) NOT NULL,
  `selected` int(2) NOT NULL DEFAULT 0,
  `model` int(30) NOT NULL,
  `name` varchar(50) NOT NULL,
  `components`  varchar(5000) NOT NULL,
  `sex` int(2) NOT NULL DEFAULT 0,
  `xp`  int(7) NOT NULL DEFAULT 0,
  `injured` int(2) NOT NULL DEFAULT 0,
  `price` int(8) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `ricxhorsecomps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `charid` int(5) NOT NULL,
  `horseid` int(11) NOT NULL,
  `Blankets`  MEDIUMTEXT ,
  `Horns`  MEDIUMTEXT ,
  `Saddlebags`  MEDIUMTEXT ,
  `Tails`  MEDIUMTEXT ,
  `Manes`  MEDIUMTEXT ,
  `Saddle`  MEDIUMTEXT ,
  `Stirrup`  MEDIUMTEXT ,
  `Bedrolls`  MEDIUMTEXT ,
  `Lantern`  MEDIUMTEXT ,
  `Bridles`  MEDIUMTEXT ,
  `Masks`  MEDIUMTEXT ,
  `Mustaches`  MEDIUMTEXT ,
  `Shoes`  MEDIUMTEXT ,
  `Holster`  MEDIUMTEXT ,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `ricxhorsetrainer` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL DEFAULT '0',
  `charid` int(2) NOT NULL,
  `exp` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;