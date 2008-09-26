DROP TABLE IF EXISTS `xwin`.`event`;
CREATE TABLE  `xwin`.`event` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `NAME` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

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

DROP TABLE IF EXISTS `xwin`.`tbl_betting`;
CREATE TABLE  `xwin`.`tbl_betting` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(45) NOT NULL,
  `DATE` varchar(45) NOT NULL,
  `RATE` varchar(45) NOT NULL,
  `MONEY` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_betting_game`;
CREATE TABLE  `xwin`.`tbl_betting_game` (
  `BETTING_ID` int(10) unsigned NOT NULL,
  `GAME_ID` int(10) unsigned NOT NULL,
  `GUESS` varchar(45) NOT NULL,
  PRIMARY KEY  (`BETTING_ID`,`GAME_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_game`;
CREATE TABLE  `xwin`.`tbl_game` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `HOME_TEAM` varchar(45) NOT NULL,
  `AWAY_TEAM` varchar(45) NOT NULL,
  `WIN_RATE` float(5,2) NOT NULL,
  `DRAW_RATE` float(5,2) NOT NULL,
  `LOSE_RATE` float(5,2) NOT NULL,
  `STATUS` varchar(45) character set ucs2 NOT NULL,
  `DATE` datetime NOT NULL,
  `LEAGUE_ID` int(10) unsigned NOT NULL,
  `TYPE` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_league`;
CREATE TABLE  `xwin`.`tbl_league` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `NAME` varchar(45) NOT NULL,
  `TYPE` varchar(45) NOT NULL default '',
  `IMAGE` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_member`;
CREATE TABLE  `xwin`.`tbl_member` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(45) NOT NULL,
  `PASSWORD` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `MOBILE` varchar(45) NOT NULL,
  `EMAIL` varchar(45) NOT NULL,
  `PIN` varchar(45) NOT NULL,
  `BALANCE` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`team`;
CREATE TABLE  `xwin`.`team` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `NAME` varchar(45) NOT NULL,
  `LEAGUE_ID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `FK_TEAM_1` (`LEAGUE_ID`),
  CONSTRAINT `FK_TEAM_1` FOREIGN KEY (`LEAGUE_ID`) REFERENCES `tbl_league` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`userinfo`;
CREATE TABLE  `xwin`.`userinfo` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(32) NOT NULL,
  `NICKNAME` varchar(32) NOT NULL,
  `EMAIL` varchar(64) NOT NULL,
  `BALANCE` float NOT NULL default '0',
  `PASSWORD` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;