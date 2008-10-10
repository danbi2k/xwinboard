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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_access`
--

/*!40000 ALTER TABLE `tbl_access` DISABLE KEYS */;
INSERT INTO `tbl_access` (`ID`,`USERID`,`NICKNAME`,`DATE`,`IP_ADDR`) VALUES 
 (25,'xx','대박이','2008-10-09 22:41:11','127.0.0.1'),
 (26,'xx','대박이','2008-10-09 23:25:48','127.0.0.1'),
 (27,'xx','대박이','2008-10-09 23:28:22','127.0.0.1'),
 (28,'xx','대박이','2008-10-10 00:01:16','127.0.0.1'),
 (29,'xx','대박이','2008-10-10 00:05:50','127.0.0.1'),
 (30,'xx','대박이','2008-10-10 00:34:50','127.0.0.1'),
 (31,'phodo','포도','2008-10-10 01:04:35','127.0.0.1'),
 (32,'xx','대박이','2008-10-10 01:05:27','127.0.0.1'),
 (33,'xx','대박이','2008-10-10 02:24:42','127.0.0.1'),
 (34,'xx','대박이','2008-10-10 03:27:05','127.0.0.1'),
 (35,'xx','대박이','2008-10-10 03:33:52','127.0.0.1'),
 (36,'xx','대박이','2008-10-10 03:51:35','127.0.0.1'),
 (37,'xx','대박이','2008-10-10 03:57:05','127.0.0.1'),
 (38,'xx','대박이','2008-10-10 03:57:47','127.0.0.1'),
 (39,'xx','대박이','2008-10-10 03:58:56','127.0.0.1'),
 (40,'xx','대박이','2008-10-10 04:01:08','127.0.0.1'),
 (41,'xx','대박이','2008-10-10 04:06:32','127.0.0.1'),
 (42,'xx','대박이','2008-10-10 04:31:23','127.0.0.1'),
 (43,'xx','대박이','2008-10-10 05:45:40','127.0.0.1'),
 (44,'xx','대박이','2008-10-10 05:46:02','127.0.0.1');
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
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_account`
--

/*!40000 ALTER TABLE `tbl_account` DISABLE KEYS */;
INSERT INTO `tbl_account` (`ID`,`DATE`,`MONEY`,`BALANCE`,`DESCRIPTION`,`BETTING_ID`,`MONEYIN_ID`,`MONEYOUT_ID`,`TYPE`,`USERID`,`OLD_BALANCE`) VALUES 
 (150,'2008-10-10 03:25:54',100000,200000,NULL,NULL,'41',NULL,'AT003','xx',100000),
 (151,'2008-10-10 03:27:19',-50000,150000,NULL,NULL,NULL,NULL,'AT004','xx',200000),
 (152,'2008-10-10 03:32:48',100000,250000,NULL,NULL,'42',NULL,'AT003','xx',150000),
 (153,'2008-10-10 03:34:13',-5000,245000,NULL,'126',NULL,NULL,'AT001','xx',250000),
 (154,'2008-10-10 04:01:21',-5000,240000,NULL,'127',NULL,NULL,'AT001','xx',245000),
 (155,'2008-10-10 04:01:23',-5000,235000,NULL,'128',NULL,NULL,'AT001','xx',240000),
 (156,'2008-10-10 04:01:26',-5000,230000,NULL,'129',NULL,NULL,'AT001','xx',235000),
 (157,'2008-10-10 04:05:31',10000,240000,NULL,'129',NULL,NULL,'AT002','xx',230000);
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
 (2,'NOTICE','★ 입금계좌 변경안내 ★ 계좌를 확인하시고 충전신청바랍니다.  [bwin-kor@hotmail.com] 관리자 이메일(MSN)  ★ 배팅제한 최소1천원 ~ 최대100만원 적중지급상한 300만원 ★ 승무패, 핸디캡 다양한배팅방식 최고의 서비스 3분이내 입환전'),
 (3,'POPUP','긴급공지'),
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_bankbook`
--

/*!40000 ALTER TABLE `tbl_bankbook` DISABLE KEYS */;
INSERT INTO `tbl_bankbook` (`ID`,`BANKNAME`,`NUMBER`,`NAME`,`STATUS`) VALUES 
 (1,'한국','123-456789-01','김한국','BBS01');
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
  `ISNOTICE` varchar(45) NOT NULL default 'BTN01',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_board_comment`
--

/*!40000 ALTER TABLE `tbl_board_comment` DISABLE KEYS */;
INSERT INTO `tbl_board_comment` (`ID`,`BOARD_ID`,`NICKNAME`,`PASSWORD`,`COMMENT`,`USERID`,`DATE`) VALUES 
 (1,'9','yy','1234','쿄쿄쿄','xx','2008-09-27 21:47:34'),
 (2,'10','yy','1234','쿄쿄쿄','xx','2008-09-28 12:25:49'),
 (3,'16','대박이',NULL,'ㅇㅇㅇㅇㅇ','xx','2008-10-06 18:38:25'),
 (4,'16','대박이',NULL,'ㄻㅇㄻㄴㄹ','xx','2008-10-06 18:38:30'),
 (5,'16','대박이',NULL,'ㄻㅇㄴㄻㄹㄴㅇㅁ','xx','2008-10-06 18:38:34'),
 (6,'19','대박이',NULL,'dddd','xx','2008-10-06 19:09:20'),
 (7,'19','대박이',NULL,'aaa','xx','2008-10-06 19:10:27'),
 (8,'19','대박이',NULL,'bbb','xx','2008-10-06 19:10:36'),
 (9,'19','대박이',NULL,'bbbdddd','xx','2008-10-06 19:11:19'),
 (10,'19','대박이',NULL,'dddd','xx','2008-10-06 19:12:58'),
 (11,'19','대박이',NULL,'eeee','xx','2008-10-06 19:13:01'),
 (12,'19','대박이',NULL,'gggg','xx','2008-10-06 19:13:04'),
 (13,'28','대박이',NULL,'fadfad','xx','2008-10-06 19:23:33'),
 (14,'28','대박이',NULL,'fadsffas','xx','2008-10-06 19:23:36'),
 (15,'30','대박이',NULL,'23423432432423','xx','2008-10-06 19:26:18'),
 (16,'30','대박이',NULL,'4324234','xx','2008-10-06 19:26:20'),
 (17,'30','대박이',NULL,'423423','xx','2008-10-06 19:26:23'),
 (18,'35','대박이',NULL,'fdfaafa','xx','2008-10-06 19:29:39'),
 (19,'35','대박이',NULL,'fadsfdafaf','xx','2008-10-06 19:29:42'),
 (20,'35','대박이',NULL,'fadfa','xx','2008-10-06 19:29:44'),
 (21,'38','테스트01',NULL,'ㅇㅇㅇㅇ','test01','2008-10-07 02:46:18'),
 (22,'32','테스트01',NULL,'ㅇㅇㅇㅇ','test01','2008-10-07 02:47:07'),
 (23,'37','관리자',NULL,'fa\n\nfad\n\nfads\nfads\n\nfadsfasfs','secadmin','2008-10-10 05:42:16'),
 (24,'36','관리자',NULL,'fdfad\n\nfad\n\nfad\n\nfad\n\nfadfdffa','secadmin','2008-10-10 05:43:27'),
 (25,'34','관리자',NULL,'fadf\nfad\nfaf','secadmin','2008-10-10 05:44:12');
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
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_board_item`
--

/*!40000 ALTER TABLE `tbl_board_item` DISABLE KEYS */;
INSERT INTO `tbl_board_item` (`ID`,`TITLE`,`USERID`,`DATE`,`READCOUNT`,`NICKNAME`,`CONTEXT`,`TYPE`,`BOARDNAME`,`STATUS`) VALUES 
 (1,'공지 공지 공지','xx','2008-09-27 00:23:20',55,'yy','fjkdfjakfjdf','BIT01','user','BIS01'),
 (2,'우가차카 우가차카','xx','2008-09-27 00:23:35',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01'),
 (3,'우가차카 우가차카','xx','2008-09-27 00:23:36',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01'),
 (4,'우가차카 우가차카','xx','2008-09-27 00:23:36',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01'),
 (5,'우가차카 우가차카','xx','2008-09-27 00:23:36',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01'),
 (6,'우가차카 우가차카','xx','2008-09-27 00:23:36',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01'),
 (7,'우가차카 우가차카','xx','2008-09-27 21:27:42',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01'),
 (8,'우가차카 우가차카','xx','2008-09-27 21:44:55',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01'),
 (9,'우가차카 우가차카','xx','2008-09-27 21:47:33',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01'),
 (10,'우가차카 우가차카','xx','2008-09-28 12:25:49',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01'),
 (11,'dd','xx','2008-10-05 23:55:57',0,'대박이','dd','BIT10','user','BIS01'),
 (12,'dd','xx','2008-10-05 23:59:06',14,'대박이','fdaf\r\nfasdf\r\n\r\n\r\nfsdafa\r\nsd\r\ndf\r\n\r\n\r\nfdsfsafsaf\r\nf\r\ndsf\r\nf\r\ndsf\r\nas\r\n\r\nfsdfsdaf\r\n\r\nfasdfs','BIT10','user','BIS01'),
 (13,'ddd','xx','2008-10-06 00:12:56',7,'대박이','dddfffdsfdsfdsfdsfsfdfdsfsfs','BIT10','user','BIS01'),
 (14,'안녕하세요','xx','2008-10-06 18:23:13',1,'대박이','반갑습니다\r\n반갑습니다\r\n','BIT10','user','BIS01'),
 (15,'ㅇㅇ','xx','2008-10-06 18:23:23',3,'대박이','ㅇㅇ\r\nㅇㅇ\r\nㅇㅇ\r\n','BIT10','user','BIS01'),
 (16,'안녕하세요','xx','2008-10-06 18:36:33',3,'대박이','안녕하세요\r\n안녕하세요\r\n안녕하세요','BIT10','user','BIS01'),
 (17,'dd','xx','2008-10-06 19:01:25',0,'대박이','dd','BIT10','user','BIS01'),
 (18,'dd','xx','2008-10-06 19:02:00',0,'대박이','dd','BIT10','user','BIS01'),
 (19,'ddd','xx','2008-10-06 19:04:35',4,'대박이','ddddd','BIT10','user','BIS01'),
 (20,'ddd','xx','2008-10-06 19:13:51',0,'대박이','ddd','BIT10','user','BIS01'),
 (21,'dd','xx','2008-10-06 19:14:12',0,'대박이','dddd','BIT10','user','BIS01'),
 (22,'dd','xx','2008-10-06 19:16:07',0,'대박이','dd','BIT10','user','BIS01'),
 (23,'dd','xx','2008-10-06 19:16:38',0,'대박이','dddd','BIT10','user','BIS01'),
 (24,'fdasfa','xx','2008-10-06 19:19:39',0,'대박이','fadsf','BIT10','user','BIS01'),
 (25,'fdasfa','xx','2008-10-06 19:20:00',0,'대박이','fadsf','BIT10','user','BIS01'),
 (26,'dd','xx','2008-10-06 19:22:03',0,'대박이','d','BIT10','user','BIS01'),
 (27,'dd','xx','2008-10-06 19:22:50',0,'대박이','dd','BIT10','user','BIS01'),
 (28,'fad','xx','2008-10-06 19:23:28',2,'대박이','fad','BIT10','user','BIS01'),
 (29,'fad','xx','2008-10-06 19:26:01',0,'대박이','fdas','BIT10','user','BIS01'),
 (30,'43243','xx','2008-10-06 19:26:07',3,'대박이','4324','BIT10','user','BIS01'),
 (31,'432432','xx','2008-10-06 19:26:29',1,'대박이','432','BIT10','user','BIS01'),
 (32,'4324','xx','2008-10-06 19:26:36',2,'대박이','432','BIT10','user','BIS01'),
 (33,'3','xx','2008-10-06 19:29:24',1,'대박이','3\r\n3\r\n3\r\n3\r\n3\r\n','BIT10','user','BIS01'),
 (34,'4324','xx','2008-10-06 19:29:31',0,'대박이','432','BIT10','qna','BIS01'),
 (35,'432432','xx','2008-10-06 19:29:35',3,'대박이','43244','BIT10','qna','BIS01'),
 (36,'ddd','xx','2008-10-06 19:36:01',0,'대박이','dd','BIT10','qna','BIS01'),
 (37,'dd','xx','2008-10-06 19:37:54',1,'대박이','dd','BIT10','qna','BIS01'),
 (38,'테스','test01','2008-10-07 02:45:40',3,'테스트01','ㅌㅌㅌㅌㅌㅌ','BIT10','user','BIS01');
/*!40000 ALTER TABLE `tbl_board_item` ENABLE KEYS */;


--
-- Definition of table `tbl_config`
--

DROP TABLE IF EXISTS `tbl_config`;
CREATE TABLE `tbl_config` (
  `NOTICE` text NOT NULL,
  `ACCOUNT` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_config`
--

/*!40000 ALTER TABLE `tbl_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_config` ENABLE KEYS */;


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
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_member`
--

/*!40000 ALTER TABLE `tbl_member` DISABLE KEYS */;
INSERT INTO `tbl_member` (`ID`,`USERID`,`PASSWORD`,`NICKNAME`,`MOBILE`,`EMAIL`,`PIN`,`BALANCE`,`STATUS`,`GRADE`,`JOIN_DATE`) VALUES 
 (1,'xx','4444','대박이','010-2069-9997','jackpot@hotmail.com','1111',240000,'US001','UG001','2008-09-29 00:00:00'),
 (2,'secadmin','3333','관리자','010-4444-4444','admin@admin.com','4444',0,'US001','UG100','2008-09-30 00:00:00'),
 (3,'test','test','테스트','010-2222-2222','test@test.com','test1111',2000000,'US001','UG001','2008-10-04 15:53:42'),
 (4,'test01','1111','테스트01','010-111-1111','1111@1111','1111',3741122,'US001','UG001','2008-10-05 20:12:29'),
 (5,'hong','1111','슈퍼홍','010-4878-4497','superhong@hotmail.com','1111',1000000,'US001','UG001','2008-10-09 16:13:12'),
 (6,'phodo','1234','포도','010-4013-9992','phodo@hotmail.com','1234',0,'undefined','UG001','2008-10-10 01:04:30');
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
  `REQ_DATE` datetime NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `BANKBOOK_ID` int(10) unsigned NOT NULL,
  `PROC_DATE` datetime default NULL,
  `ISCHECKED` varchar(45) NOT NULL default 'N',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `BANKNAME` varchar(45) NOT NULL,
  `NUMBER` varchar(45) NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `REQ_DATE` datetime NOT NULL,
  `PROC_DATE` datetime default NULL,
  `STATUS` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_money_out`
--

/*!40000 ALTER TABLE `tbl_money_out` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_money_out` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
