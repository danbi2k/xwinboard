-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.51b-community-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema xwin
--

CREATE DATABASE IF NOT EXISTS xwin;
USE xwin;

--
-- Definition of table `tbl_access`
--

DROP TABLE IF EXISTS `tbl_access`;
CREATE TABLE `tbl_access` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `DATE` varchar(45) NOT NULL,
  `IP_ADDR` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_access`
--

/*!40000 ALTER TABLE `tbl_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_access` ENABLE KEYS */;


--
-- Definition of table `tbl_account`
--

DROP TABLE IF EXISTS `tbl_account`;
CREATE TABLE `tbl_account` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `DATE` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `MONEY` int(11) NOT NULL,
  `BALANCE` bigint(20) NOT NULL default '0',
  `DESCRIPTION` varchar(45) default NULL,
  `BETTING_ID` varchar(45) default NULL,
  `MONEYIN_ID` varchar(45) default NULL,
  `MONEYOUT_ID` varchar(45) default NULL,
  `TYPE` varchar(45) NOT NULL,
  `USERID` varchar(45) NOT NULL,
  `OLD_BALANCE` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_account`
--

/*!40000 ALTER TABLE `tbl_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_account` ENABLE KEYS */;


--
-- Definition of table `tbl_admin`
--

DROP TABLE IF EXISTS `tbl_admin`;
CREATE TABLE `tbl_admin` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `CONSTANT` varchar(45) NOT NULL,
  `VARIABLE` text NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_admin`
--

/*!40000 ALTER TABLE `tbl_admin` DISABLE KEYS */;
INSERT INTO `tbl_admin` (`ID`,`CONSTANT`,`VARIABLE`) VALUES 
 (2,'NOTICE',''),
 (3,'POPUP',''),
 (4,'POPUPFLAG','N');
/*!40000 ALTER TABLE `tbl_admin` ENABLE KEYS */;


--
-- Definition of table `tbl_bankbook`
--

DROP TABLE IF EXISTS `tbl_bankbook`;
CREATE TABLE `tbl_bankbook` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `BANKNAME` varchar(45) NOT NULL,
  `NUMBER` varchar(45) NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `STATUS` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_bankbook`
--

/*!40000 ALTER TABLE `tbl_bankbook` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_bankbook` ENABLE KEYS */;


--
-- Definition of table `tbl_betting`
--

DROP TABLE IF EXISTS `tbl_betting`;
CREATE TABLE `tbl_betting` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(45) NOT NULL,
  `DATE` datetime NOT NULL,
  `RATE` float(8,2) default NULL,
  `MONEY` int(10) unsigned NOT NULL,
  `EXPECT` bigint(20) NOT NULL,
  `STATUS` varchar(45) NOT NULL,
  `TOTAL_COUNT` int(10) unsigned NOT NULL default '0',
  `SUCCESS_COUNT` int(10) unsigned NOT NULL default '0',
  `FAILURE_COUNT` int(10) unsigned NOT NULL default '0',
  `NOMATCH_COUNT` int(10) unsigned NOT NULL default '0',
  `GAME_TYPE` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `HANDYDRAW_COUNT` int(10) unsigned NOT NULL default '0',
  `CALC_STATUS` varchar(45) NOT NULL default 'BTC01',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_betting`
--

/*!40000 ALTER TABLE `tbl_betting` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_betting` ENABLE KEYS */;


--
-- Definition of table `tbl_betting_game`
--

DROP TABLE IF EXISTS `tbl_betting_game`;
CREATE TABLE `tbl_betting_game` (
  `BETTING_ID` int(10) unsigned NOT NULL,
  `GAME_ID` int(10) unsigned NOT NULL,
  `GUESS` varchar(45) NOT NULL,
  PRIMARY KEY  (`BETTING_ID`,`GAME_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_betting_game`
--

/*!40000 ALTER TABLE `tbl_betting_game` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_betting_game` ENABLE KEYS */;


--
-- Definition of table `tbl_board_comment`
--

DROP TABLE IF EXISTS `tbl_board_comment`;
CREATE TABLE `tbl_board_comment` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `BOARD_ID` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `PASSWORD` varchar(45) default NULL,
  `COMMENT` text NOT NULL,
  `USERID` varchar(45) NOT NULL,
  `DATE` datetime NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_board_comment`
--

/*!40000 ALTER TABLE `tbl_board_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_board_comment` ENABLE KEYS */;


--
-- Definition of table `tbl_board_item`
--

DROP TABLE IF EXISTS `tbl_board_item`;
CREATE TABLE `tbl_board_item` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `TITLE` varchar(45) NOT NULL,
  `USERID` varchar(45) NOT NULL,
  `DATE` datetime NOT NULL,
  `READCOUNT` int(10) unsigned NOT NULL default '0',
  `NICKNAME` varchar(45) NOT NULL,
  `CONTEXT` text NOT NULL,
  `TYPE` varchar(45) NOT NULL,
  `BOARDNAME` varchar(45) NOT NULL,
  `STATUS` varchar(45) NOT NULL,
  `ISDELETED` varchar(8) NOT NULL default 'N',
  `ISCHECKED` varchar(8) NOT NULL default 'N',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_board_item`
--

/*!40000 ALTER TABLE `tbl_board_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_board_item` ENABLE KEYS */;


--
-- Definition of table `tbl_game`
--

DROP TABLE IF EXISTS `tbl_game`;
CREATE TABLE `tbl_game` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `HOME_TEAM` varchar(45) NOT NULL,
  `AWAY_TEAM` varchar(45) NOT NULL,
  `WIN_RATE` float(5,2) default NULL,
  `DRAW_RATE` float(5,2) default NULL,
  `LOSE_RATE` float(5,2) default NULL,
  `STATUS` varchar(45) character set ucs2 default NULL,
  `GAME_DATE` datetime NOT NULL,
  `LEAGUE_ID` int(10) unsigned NOT NULL,
  `TYPE` varchar(45) NOT NULL,
  `HOME_SCORE` int(10) unsigned default NULL,
  `AWAY_SCORE` int(10) unsigned default NULL,
  `RESULT` varchar(45) character set utf8 collate utf8_bin default NULL,
  `HANDY` float(5,2) default NULL,
  `BET_STATUS` varchar(45) NOT NULL default 'BTS02',
  `DP_STATUS` varchar(45) NOT NULL default 'GMD02',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_game`
--

/*!40000 ALTER TABLE `tbl_game` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_game` ENABLE KEYS */;


--
-- Definition of table `tbl_ktfsms`
--

DROP TABLE IF EXISTS `tbl_ktfsms`;
CREATE TABLE `tbl_ktfsms` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `MSG_SEQ` varchar(16) default NULL,
  `IN_DATE` varchar(16) default NULL,
  `MSG` varchar(256) default NULL,
  `SM` varchar(2) default NULL,
  `CALL_BACK` varchar(16) default NULL,
  `STATUS` varchar(45) NOT NULL default 'MC001',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_ktfsms`
--

/*!40000 ALTER TABLE `tbl_ktfsms` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_ktfsms` ENABLE KEYS */;


--
-- Definition of table `tbl_league`
--

DROP TABLE IF EXISTS `tbl_league`;
CREATE TABLE `tbl_league` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `NAME` varchar(45) NOT NULL,
  `IMAGE` varchar(45) default NULL,
  `TYPE` varchar(45) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_league`
--

/*!40000 ALTER TABLE `tbl_league` DISABLE KEYS */;
INSERT INTO `tbl_league` (`ID`,`NAME`,`IMAGE`,`TYPE`) VALUES 
 (10,'미국 MLB','image_usa_mlb.gif',NULL),
 (11,'미국 축구','image_usa_soc.gif',NULL),
 (12,'한국 KBO','image_kor_kbo.gif',NULL),
 (13,'한국 K리그','image_kor_kle.gif',NULL),
 (14,'잉글랜드 프리미어리그','image_eng_soc.gif',NULL),
 (15,'이탈리아 세리에A','image_ita_soc.gif',NULL),
 (16,'독일 분데스리가','image_ger_soc.gif',NULL),
 (17,'일본 NPB','image_jap_npb.gif',NULL),
 (18,'일본 J리그','image_jap_soc.gif',NULL),
 (19,'스페인 프리메라리가','image_spa_soc.gif',NULL);
/*!40000 ALTER TABLE `tbl_league` ENABLE KEYS */;


--
-- Definition of table `tbl_member`
--

DROP TABLE IF EXISTS `tbl_member`;
CREATE TABLE `tbl_member` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(45) NOT NULL,
  `PASSWORD` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `MOBILE` varchar(45) default NULL,
  `EMAIL` varchar(45) default NULL,
  `PIN` varchar(45) default NULL,
  `BALANCE` bigint(20) NOT NULL default '0',
  `STATUS` varchar(45) NOT NULL,
  `GRADE` varchar(45) NOT NULL,
  `JOIN_DATE` datetime NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_member`
--

/*!40000 ALTER TABLE `tbl_member` DISABLE KEYS */;
INSERT INTO `tbl_member` (`ID`,`USERID`,`PASSWORD`,`NICKNAME`,`MOBILE`,`EMAIL`,`PIN`,`BALANCE`,`STATUS`,`GRADE`,`JOIN_DATE`) VALUES 
 (1,'xx','4444','대박이','010-3333-9997','jackpot@hotmail.com','1111',8875080,'US001','UG001','2008-09-29 00:00:00'),
 (2,'secadmin','3333','관리자','010-4444-4444','admin@admin.com','4444',0,'US001','UG100','2008-09-30 00:00:00');
/*!40000 ALTER TABLE `tbl_member` ENABLE KEYS */;


--
-- Definition of table `tbl_money_in`
--

DROP TABLE IF EXISTS `tbl_money_in`;
CREATE TABLE `tbl_money_in` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(45) NOT NULL,
  `MONEY` int(10) unsigned NOT NULL,
  `STATUS` varchar(45) NOT NULL,
  `REQ_DATE` datetime default NULL,
  `NAME` varchar(45) default NULL,
  `BANKBOOK_ID` int(10) unsigned default NULL,
  `PROC_DATE` datetime default NULL,
  `ISCHECKED` varchar(45) NOT NULL default 'N',
  `NICKNAME` varchar(45) NOT NULL,
  `ISDELETED` varchar(45) NOT NULL default 'N',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_money_in`
--

/*!40000 ALTER TABLE `tbl_money_in` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_money_in` ENABLE KEYS */;


--
-- Definition of table `tbl_money_out`
--

DROP TABLE IF EXISTS `tbl_money_out`;
CREATE TABLE `tbl_money_out` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(45) NOT NULL,
  `MONEY` int(10) unsigned NOT NULL,
  `BANKNAME` varchar(45) default NULL,
  `NUMBER` varchar(45) default NULL,
  `NAME` varchar(45) default NULL,
  `REQ_DATE` datetime default NULL,
  `PROC_DATE` datetime default NULL,
  `STATUS` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `ISCHECKED` varchar(45) NOT NULL default 'N',
  `ISDELETED` varchar(45) NOT NULL default 'N',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_money_out`
--

/*!40000 ALTER TABLE `tbl_money_out` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_money_out` ENABLE KEYS */;


--
-- Definition of table `tbl_sms_wait`
--

DROP TABLE IF EXISTS `tbl_sms_wait`;
CREATE TABLE `tbl_sms_wait` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `MSG` varchar(45) NOT NULL,
  `PHONE` varchar(45) NOT NULL,
  `CALLBACK` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_sms_wait`
--

/*!40000 ALTER TABLE `tbl_sms_wait` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_sms_wait` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
