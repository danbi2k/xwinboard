DROP TABLE IF EXISTS `xwin`.`event`;
CREATE TABLE  `xwin`.`event` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `NAME` varchar(32) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`game_wdl`;
CREATE TABLE  `xwin`.`game_wdl` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `HOME_TEAM_ID` int(10) unsigned NOT NULL,
  `AWAY_TEAM_ID` int(10) unsigned NOT NULL,
  `WIN_RATE` float(5,2) NOT NULL,
  `DRAW_RATE` float(5,2) NOT NULL,
  `LOSE_RATE` float(5,2) NOT NULL,
  `STATUS` char(5) character set ucs2 NOT NULL,
  `DATE` datetime NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`ktfsms`;
CREATE TABLE  `xwin`.`ktfsms` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `MSG_SEQ` varchar(16) NOT NULL,
  `IN_DATE` varchar(16) NOT NULL,
  `MSG` varchar(256) NOT NULL,
  `SM` varchar(2) NOT NULL,
  `CALL_BACK` varchar(16) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`league`;
CREATE TABLE  `xwin`.`league` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `NAME` varchar(45) NOT NULL,
  `TYPE` char(6) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`team`;
CREATE TABLE  `xwin`.`team` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `NAME` varchar(45) NOT NULL,
  `LEAGUE_ID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `FK_TEAM_1` (`LEAGUE_ID`),
  CONSTRAINT `FK_TEAM_1` FOREIGN KEY (`LEAGUE_ID`) REFERENCES `league` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;