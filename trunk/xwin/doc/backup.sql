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
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

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
 (44,'xx','대박이','2008-10-10 05:46:02','127.0.0.1'),
 (45,'xx','대박이','2008-10-11 13:50:38','127.0.0.1'),
 (46,'xx','대박이','2008-10-11 15:15:56','127.0.0.1'),
 (47,'xx','대박이','2008-10-11 15:17:44','127.0.0.1'),
 (48,'xx','대박이','2008-10-11 15:21:02','127.0.0.1'),
 (49,'xx','대박이','2008-10-11 16:03:49','127.0.0.1'),
 (50,'xx','대박이','2008-10-11 16:06:08','127.0.0.1'),
 (51,'xx','대박이','2008-10-11 16:07:04','127.0.0.1'),
 (52,'xx','대박이','2008-10-11 16:20:11','127.0.0.1'),
 (53,'xx','대박이','2008-10-11 17:42:56','127.0.0.1'),
 (54,'xx','대박이','2008-10-11 17:47:51','127.0.0.1'),
 (55,'xx','대박이','2008-10-11 17:58:10','127.0.0.1'),
 (56,'xx','대박이','2008-10-11 18:24:10','127.0.0.1'),
 (57,'xx','대박이','2008-10-11 18:37:13','127.0.0.1'),
 (58,'xx','대박이','2008-10-11 19:21:05','127.0.0.1'),
 (59,'xx','대박이','2008-10-11 20:22:19','127.0.0.1'),
 (60,'xx','대박이','2008-10-11 21:15:17','127.0.0.1'),
 (61,'xx','대박이','2008-10-11 21:17:56','127.0.0.1');
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
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_account`
--

/*!40000 ALTER TABLE `tbl_account` DISABLE KEYS */;
INSERT INTO `tbl_account` (`ID`,`DATE`,`MONEY`,`BALANCE`,`DESCRIPTION`,`BETTING_ID`,`MONEYIN_ID`,`MONEYOUT_ID`,`TYPE`,`USERID`,`OLD_BALANCE`) VALUES 
 (184,'2008-10-11 17:58:34',-1,999994,NULL,NULL,NULL,NULL,'AT004','xx',999995),
 (185,'2008-10-11 17:58:44',-2,999992,NULL,NULL,NULL,NULL,'AT004','xx',999994),
 (186,'2008-10-11 17:58:57',-1,999991,NULL,NULL,NULL,NULL,'AT004','xx',999992),
 (187,'2008-10-11 18:13:11',800000,1799991,NULL,NULL,'17',NULL,'AT003','xx',999991),
 (188,'2008-10-11 18:13:12',700000,2499991,NULL,NULL,'16',NULL,'AT003','xx',1799991),
 (189,'2008-10-11 18:14:01',1,2499992,NULL,NULL,NULL,NULL,'AT007','xx',2499991),
 (190,'2008-10-11 18:14:03',1,2499993,NULL,NULL,NULL,NULL,'AT008','xx',2499992),
 (191,'2008-10-11 18:49:47',500000,2999991,NULL,NULL,'43',NULL,'AT003','xx',2499991),
 (192,'2008-10-11 18:49:48',500000,3499991,NULL,NULL,'42',NULL,'AT003','xx',2999991),
 (193,'2008-10-11 18:49:50',500000,3999991,NULL,NULL,'41',NULL,'AT003','xx',3499991),
 (194,'2008-10-11 18:49:51',500000,4499991,NULL,NULL,'40',NULL,'AT003','xx',3999991),
 (195,'2008-10-11 18:49:52',500000,4999991,NULL,NULL,'39',NULL,'AT003','xx',4499991),
 (196,'2008-10-11 18:49:53',500000,5499991,NULL,NULL,'38',NULL,'AT003','xx',4999991),
 (197,'2008-10-11 18:49:53',500000,5999991,NULL,NULL,'37',NULL,'AT003','xx',5499991),
 (198,'2008-10-11 18:49:54',500000,6499991,NULL,NULL,'36',NULL,'AT003','xx',5999991),
 (199,'2008-10-11 18:49:55',500000,6999991,NULL,NULL,'35',NULL,'AT003','xx',6499991),
 (200,'2008-10-11 18:49:55',500000,7499991,NULL,NULL,'34',NULL,'AT003','xx',6999991),
 (201,'2008-10-11 18:49:56',500000,7999991,NULL,NULL,'33',NULL,'AT003','xx',7499991),
 (202,'2008-10-11 18:49:57',500000,8499991,NULL,NULL,'32',NULL,'AT003','xx',7999991),
 (203,'2008-10-11 18:49:57',500000,8999991,NULL,NULL,'31',NULL,'AT003','xx',8499991),
 (204,'2008-10-11 18:49:58',500000,9499991,NULL,NULL,'30',NULL,'AT003','xx',8999991),
 (205,'2008-10-11 18:50:00',500000,9999991,NULL,NULL,'21',NULL,'AT003','xx',9499991),
 (206,'2008-10-11 18:50:02',500000,10499991,NULL,NULL,'29',NULL,'AT003','xx',9999991),
 (207,'2008-10-11 18:50:03',500000,10999991,NULL,NULL,'28',NULL,'AT003','xx',10499991),
 (208,'2008-10-11 18:50:05',500000,11499991,NULL,NULL,'27',NULL,'AT003','xx',10999991),
 (209,'2008-10-11 18:50:06',500000,11999991,NULL,NULL,'26',NULL,'AT003','xx',11499991),
 (210,'2008-10-11 18:50:07',500000,12499991,NULL,NULL,'25',NULL,'AT003','xx',11999991),
 (211,'2008-10-11 18:50:50',1,2000001,NULL,NULL,NULL,NULL,'AT007','test',2000000),
 (212,'2008-10-11 18:50:54',1,2000002,NULL,NULL,NULL,NULL,'AT007','test',2000001),
 (213,'2008-10-11 18:50:59',1,2000003,NULL,NULL,NULL,NULL,'AT007','test',2000002),
 (214,'2008-10-11 18:51:01',1,2000004,NULL,NULL,NULL,NULL,'AT007','test',2000003),
 (215,'2008-10-11 18:51:03',1,2000005,NULL,NULL,NULL,NULL,'AT007','test',2000004),
 (216,'2008-10-11 18:51:05',1,2000006,NULL,NULL,NULL,NULL,'AT007','test',2000005),
 (217,'2008-10-11 18:51:07',1,2000007,NULL,NULL,NULL,NULL,'AT007','test',2000006),
 (218,'2008-10-11 18:51:11',1,2000008,NULL,NULL,NULL,NULL,'AT007','test',2000007),
 (219,'2008-10-11 18:51:13',1,2000009,NULL,NULL,NULL,NULL,'AT007','test',2000008),
 (220,'2008-10-11 18:51:15',1,2000010,NULL,NULL,NULL,NULL,'AT007','test',2000009),
 (221,'2008-10-11 18:51:17',1,2000011,NULL,NULL,NULL,NULL,'AT007','test',2000010),
 (222,'2008-10-11 18:51:22',1,2000012,NULL,NULL,NULL,NULL,'AT007','test',2000011),
 (223,'2008-10-11 18:51:24',1,2000013,NULL,NULL,NULL,NULL,'AT007','test',2000012),
 (224,'2008-10-11 18:51:26',1,2000014,NULL,NULL,NULL,NULL,'AT007','test',2000013),
 (225,'2008-10-11 18:51:27',1,2000015,NULL,NULL,NULL,NULL,'AT007','test',2000014),
 (226,'2008-10-11 18:51:29',1,2000016,NULL,NULL,NULL,NULL,'AT007','test',2000015),
 (227,'2008-10-11 18:51:39',1,2000017,NULL,NULL,NULL,NULL,'AT007','test',2000016),
 (228,'2008-10-11 18:51:40',1,2000018,NULL,NULL,NULL,NULL,'AT007','test',2000017),
 (229,'2008-10-11 18:51:42',1,2000019,NULL,NULL,NULL,NULL,'AT007','test',2000018),
 (230,'2008-10-11 18:51:43',1,2000020,NULL,NULL,NULL,NULL,'AT007','test',2000019),
 (231,'2008-10-11 18:51:45',1,2000021,NULL,NULL,NULL,NULL,'AT007','test',2000020);
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
 (2,'NOTICE','★ 입금계좌 변경안내 계좌를 확인하시고 충전신청바랍니다.  [bwin-kor@hotmail.com] 관리자 이메일(MSN)  ★ 배팅제한 최소1천원 ~ 최대100만원 적중지급상한 300만원 ★ 승무패, 핸디캡 다양한배팅방식 최고의 서비스 3분이내 입환전'),
 (3,'POPUP','캬캬\r\n\r\n캬캬캬\r\n\r\n\r\n캬캬캬캬'),
 (4,'POPUPFLAG','Y');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_betting`
--

/*!40000 ALTER TABLE `tbl_betting` DISABLE KEYS */;
INSERT INTO `tbl_betting` (`ID`,`USERID`,`DATE`,`RATE`,`MONEY`,`EXPECT`,`STATUS`,`TOTAL_COUNT`,`SUCCESS_COUNT`,`FAILURE_COUNT`,`NOMATCH_COUNT`,`GAME_TYPE`,`NICKNAME`,`HANDYDRAW_COUNT`,`CALC_STATUS`,`ISNOTICE`) VALUES 
 (1,'xx','2008-10-11 15:21:21',2.00,5000,10000,'BS003',2,1,1,0,'wdl','대박이',0,'BTC01','BTN02'),
 (2,'xx','2008-10-11 15:21:25',1.00,5000,5000,'BS003',2,0,2,0,'wdl','대박이',0,'BTC01','BTN02'),
 (3,'xx','2008-10-11 15:21:29',1.00,5000,5000,'BS003',2,1,1,0,'wdl','대박이',0,'BTC01','BTN02');
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
INSERT INTO `tbl_betting_game` (`BETTING_ID`,`GAME_ID`,`GUESS`) VALUES 
 (1,1,'D'),
 (1,2,'D'),
 (2,1,'W'),
 (2,2,'L'),
 (3,1,'L'),
 (3,2,'W');
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

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
 (25,'34','관리자',NULL,'fadf\nfad\nfaf','secadmin','2008-10-10 05:44:12'),
 (26,'39','관리자',NULL,'알아서 하든지 말든지\r\n씨댕\r\n','secadmin','2008-10-11 13:52:26');
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
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_board_item`
--

/*!40000 ALTER TABLE `tbl_board_item` DISABLE KEYS */;
INSERT INTO `tbl_board_item` (`ID`,`TITLE`,`USERID`,`DATE`,`READCOUNT`,`NICKNAME`,`CONTEXT`,`TYPE`,`BOARDNAME`,`STATUS`,`ISDELETED`) VALUES 
 (1,'공지 공지 공지','xx','2008-09-27 00:23:20',55,'yy','fjkdfjakfjdf','BIT01','user','BIS01','Y'),
 (2,'우가차카 우가차카','xx','2008-09-27 00:23:35',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01','N'),
 (3,'우가차카 우가차카','xx','2008-09-27 00:23:36',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01','N'),
 (4,'우가차카 우가차카','xx','2008-09-27 00:23:36',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01','N'),
 (5,'우가차카 우가차카','xx','2008-09-27 00:23:36',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01','N'),
 (6,'우가차카 우가차카','xx','2008-09-27 00:23:36',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01','N'),
 (7,'우가차카 우가차카','xx','2008-09-27 21:27:42',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01','N'),
 (8,'우가차카 우가차카','xx','2008-09-27 21:44:55',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01','N'),
 (9,'우가차카 우가차카','xx','2008-09-27 21:47:33',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01','N'),
 (10,'우가차카 우가차카','xx','2008-09-28 12:25:49',55,'yy','fjkdfjakfjdf','BIT10','user','BIS01','N'),
 (11,'dd','xx','2008-10-05 23:55:57',0,'대박이','dd','BIT10','user','BIS01','N'),
 (12,'dd','xx','2008-10-05 23:59:06',14,'대박이','fdaf\r\nfasdf\r\n\r\n\r\nfsdafa\r\nsd\r\ndf\r\n\r\n\r\nfdsfsafsaf\r\nf\r\ndsf\r\nf\r\ndsf\r\nas\r\n\r\nfsdfsdaf\r\n\r\nfasdfs','BIT10','user','BIS01','N'),
 (13,'ddd','xx','2008-10-06 00:12:56',7,'대박이','dddfffdsfdsfdsfdsfsfdfdsfsfs','BIT10','user','BIS01','N'),
 (14,'안녕하세요','xx','2008-10-06 18:23:13',2,'대박이','반갑습니다\r\n반갑습니다\r\n','BIT10','user','BIS01','N'),
 (15,'ㅇㅇ','xx','2008-10-06 18:23:23',3,'대박이','ㅇㅇ\r\nㅇㅇ\r\nㅇㅇ\r\n','BIT10','user','BIS01','N'),
 (16,'안녕하세요','xx','2008-10-06 18:36:33',4,'대박이','안녕하세요\r\n안녕하세요\r\n안녕하세요','BIT10','user','BIS01','N'),
 (17,'dd','xx','2008-10-06 19:01:25',0,'대박이','dd','BIT10','user','BIS01','N'),
 (18,'dd','xx','2008-10-06 19:02:00',0,'대박이','dd','BIT10','user','BIS01','N'),
 (19,'ddd','xx','2008-10-06 19:04:35',4,'대박이','ddddd','BIT10','user','BIS01','N'),
 (20,'ddd','xx','2008-10-06 19:13:51',0,'대박이','ddd','BIT10','user','BIS01','N'),
 (21,'dd','xx','2008-10-06 19:14:12',0,'대박이','dddd','BIT10','user','BIS01','N'),
 (22,'dd','xx','2008-10-06 19:16:07',0,'대박이','dd','BIT10','user','BIS01','N'),
 (23,'dd','xx','2008-10-06 19:16:38',0,'대박이','dddd','BIT10','user','BIS01','N'),
 (24,'fdasfa','xx','2008-10-06 19:19:39',0,'대박이','fadsf','BIT10','user','BIS01','N'),
 (25,'fdasfa','xx','2008-10-06 19:20:00',0,'대박이','fadsf','BIT10','user','BIS01','N'),
 (26,'dd','xx','2008-10-06 19:22:03',0,'대박이','d','BIT10','user','BIS01','N'),
 (27,'dd','xx','2008-10-06 19:22:50',0,'대박이','dd','BIT10','user','BIS01','N'),
 (28,'fad','xx','2008-10-06 19:23:28',2,'대박이','fad','BIT10','user','BIS01','N'),
 (29,'fad','xx','2008-10-06 19:26:01',0,'대박이','fdas','BIT10','user','BIS01','N'),
 (30,'43243','xx','2008-10-06 19:26:07',3,'대박이','4324','BIT10','user','BIS01','N'),
 (31,'432432','xx','2008-10-06 19:26:29',1,'대박이','432','BIT10','user','BIS01','N'),
 (32,'4324','xx','2008-10-06 19:26:36',2,'대박이','432','BIT10','user','BIS01','N'),
 (33,'3','xx','2008-10-06 19:29:24',2,'대박이','3\r\n3\r\n3\r\n3\r\n3\r\n','BIT10','user','BIS01','N'),
 (34,'4324','xx','2008-10-06 19:29:31',0,'대박이','432','BIT10','qna','BIS01','N'),
 (35,'432432','xx','2008-10-06 19:29:35',3,'대박이','43244','BIT10','qna','BIS01','N'),
 (36,'ddd','xx','2008-10-06 19:36:01',0,'대박이','dd','BIT10','qna','BIS01','N'),
 (37,'dd','xx','2008-10-06 19:37:54',1,'대박이','dd','BIT10','qna','BIS01','N'),
 (38,'테스','test01','2008-10-07 02:45:40',3,'테스트01','ㅌㅌㅌㅌㅌㅌ','BIT10','user','BIS01','Y'),
 (39,'환전이 안되요','xx','2008-10-11 13:51:02',1,'대박이','환전햊세요\r\n\r\n플리즈','BIT10','qna','BIS01','N'),
 (40,'dd','secadmin','2008-10-11 14:58:15',0,'관리자','dd','BIT01','user','BIS01','Y'),
 (41,'dddd','secadmin','2008-10-11 15:10:35',0,'관리자','		Member admin = (Member) request.getSession().getAttribute(\"Admin\");\r\n		\r\n		String context = request.getParameter(\"context\");\r\n		String title = request.getParameter(\"title\");\r\n		\r\n		BoardItem boardItem = new BoardItem();\r\n		boardItem.setBoardName(\"user\");\r\n		boardItem.setContext(context);\r\n		boardItem.setDate(new Date());\r\n		boardItem.setNickName(admin.getNickName());\r\n		boardItem.setUserId(admin.getUserId());\r\n		boardItem.setTitle(title);\r\n		boardItem.setStatus(Code.BOARDITEM_STATUS_NORMAL);\r\n		boardItem.setType(Code.BOARDITEM_TYPE_NOTICE);\r\n		\r\n		boardDao.insertBoardItem(boardItem);','BIT01','user','BIS01','Y'),
 (42,'공지사항 1','secadmin','2008-10-11 15:15:41',1,'관리자',' \r\n   \r\n 광고 \r\n  \r\n \r\n(워싱턴=연합뉴스) 고승일 특파원 = 미국 정부는 이르면 11일(미국시간) 북한을 테러지원국 명단에서 삭제할 계획인 것으로 알려졌다.\r\n\r\n워싱턴의 외교소식통은 10일 \"미 행정부가 북한을 테러지원국 지정에서 아직까지 해제하지 않고 있으나, 11일 오전 중에 해제할 가능성이 있다\"고 말했다.\r\n\r\n이 소식통은 \"모든 일에 100% 확신이라는 것은 있을 수 없으나, 미국 정부의 움직임을 눈여겨 볼 필요가 있다\"고 강조했다.\r\n\r\nAP통신은 \"조시 부시 대통령이 금요일(10일) 북한을 테러지원국에서 해제하는데 서명했고, 토요일 테러지원국 해제를 발표할 계획\"이라고 보도했다.\r\n\r\n그러나 이번 해제는 잠정적인 것이며 북한이 검증 합의사항을 지키지 않을 경우 다시 테러지원국 명단에 포함될 것이라고 AP통신은 미 외교 소식통들을 인용해 밝혔다. \r\n\r\n미 행정부는 지/난 8월 11일 북한을 테러지원국에서 해제할 수 있는 행정 재량권을 확보했으나, 그간 북한이 `완전하고도 정확한\' 검증의정서에 합의를 하지 않는다는 이유로 해제조치를 미뤄왔다.\r\n\r\n미국은 북한을 테러지원국에서 해제해 주는 조건으로 검증을 위한 사찰의무를 준수하지 않을 경우 다시 테러지원국 명단에 올리겠다는 입장인 것으로 알려졌다.\r\n\r\n일각에서는 미 행정부가 막판까지 테러지원국 해제를 망설였던 이유는 경제위기 상황과 일본 정부의 거센 반발 때문이었다는 지적이 나오고 있다.\r\n\r\n부시 대통령이 10일 오전 금융위기와 관련한 대국민담화를 발표했기 때문에 이날 테러지원국 해제를 발표하는 것은 시의적절하지 않다고 판단했을 수 있다는 것이다.\r\n\r\n또 콘돌리자 라이스 국무장관은 이날 오전 나카소네 히로부미 일본 외상과 전화통화를 하면서 격한 대화를 주고 받은 것으로 알려졌다','BIT01','user','BIS01','N');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_game`
--

/*!40000 ALTER TABLE `tbl_game` DISABLE KEYS */;
INSERT INTO `tbl_game` (`ID`,`HOME_TEAM`,`AWAY_TEAM`,`WIN_RATE`,`DRAW_RATE`,`LOSE_RATE`,`STATUS`,`GAME_DATE`,`LEAGUE_ID`,`TYPE`,`HOME_SCORE`,`AWAY_SCORE`,`RESULT`,`HANDY`,`BET_STATUS`) VALUES 
 (1,'D','E',1.00,2.00,1.00,'GS004','2008-10-11 16:00:00',13,'wdl',2,2,0x44,NULL,'BTS01'),
 (2,'A','B',1.00,1.00,1.00,'GS004','2008-10-11 18:00:00',13,'wdl',4,1,0x57,NULL,'BTS01'),
 (3,'A','B',2.00,2.00,2.00,'GS002','2008-10-12 00:00:00',13,'wdl',NULL,NULL,NULL,NULL,'BTS01');
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
 (1,'xx','4444','대박이','010-3333-9997','jackpot@hotmail.com','1111',12499991,'US001','UG001','2008-09-29 00:00:00'),
 (2,'secadmin','3333','관리자','010-4444-4444','admin@admin.com','4444',0,'US001','UG100','2008-09-30 00:00:00'),
 (3,'test','test','테스트','010-2222-2222','test@test.com','test1111',2000021,'US001','UG001','2008-10-04 15:53:42'),
 (4,'test01','1111','테스트01','010-111-1111','1111@1111','1111',3741122,'US001','UG001','2008-10-05 20:12:29'),
 (5,'hong','1111','슈퍼홍','010-4878-4497','superhong@hotmail.com','1111',1000000,'US001','UG001','2008-10-09 16:13:12'),
 (6,'phodo','1234','포도','010-4444-9999','phodo@hotmail.com','1234',77,'undefined','UG001','2008-10-10 01:04:30');
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
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_money_in`
--

/*!40000 ALTER TABLE `tbl_money_in` DISABLE KEYS */;
INSERT INTO `tbl_money_in` (`ID`,`USERID`,`MONEY`,`STATUS`,`REQ_DATE`,`NAME`,`BANKBOOK_ID`,`PROC_DATE`,`ISCHECKED`,`NICKNAME`) VALUES 
 (15,'xx',600000,'MC001','2008-10-11 17:58:14','1',1,NULL,'N','대박이'),
 (16,'xx',700000,'MC002','2008-10-11 17:58:18','1',1,'2008-10-11 18:13:12','N','대박이'),
 (17,'xx',800000,'MC002','2008-10-11 17:58:22','1',1,'2008-10-11 18:13:11','N','대박이'),
 (18,'xx',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:14:01','N','대박이'),
 (19,'xx',500000,'MC001','2008-10-11 18:24:15','1',1,NULL,'N','대박이'),
 (20,'xx',500000,'MC001','2008-10-11 18:24:21','1',1,NULL,'N','대박이'),
 (21,'xx',500000,'MC002','2008-10-11 18:24:25','1',1,'2008-10-11 18:50:00','N','대박이'),
 (22,'xx',500000,'MC001','2008-10-11 18:24:41','1',1,NULL,'N','대박이'),
 (23,'xx',500000,'MC001','2008-10-11 18:24:44','1',1,NULL,'N','대박이'),
 (24,'xx',500000,'MC001','2008-10-11 18:24:47','1',1,NULL,'N','대박이'),
 (25,'xx',500000,'MC002','2008-10-11 18:24:51','1',1,'2008-10-11 18:50:07','N','대박이'),
 (26,'xx',500000,'MC002','2008-10-11 18:24:54','1',1,'2008-10-11 18:50:06','N','대박이'),
 (27,'xx',500000,'MC002','2008-10-11 18:24:57','1',1,'2008-10-11 18:50:05','N','대박이'),
 (28,'xx',500000,'MC002','2008-10-11 18:25:00','1',1,'2008-10-11 18:50:03','N','대박이'),
 (29,'xx',500000,'MC002','2008-10-11 18:25:03','1',1,'2008-10-11 18:50:02','N','대박이'),
 (30,'xx',500000,'MC002','2008-10-11 18:25:06','1',1,'2008-10-11 18:49:58','N','대박이'),
 (31,'xx',500000,'MC002','2008-10-11 18:25:08','1',1,'2008-10-11 18:49:57','N','대박이'),
 (32,'xx',500000,'MC002','2008-10-11 18:25:11','1',1,'2008-10-11 18:49:57','N','대박이'),
 (33,'xx',500000,'MC002','2008-10-11 18:25:14','1',1,'2008-10-11 18:49:56','N','대박이'),
 (34,'xx',500000,'MC002','2008-10-11 18:25:17','1',1,'2008-10-11 18:49:55','N','대박이'),
 (35,'xx',500000,'MC002','2008-10-11 18:25:20','a',1,'2008-10-11 18:49:55','N','대박이'),
 (36,'xx',500000,'MC002','2008-10-11 18:25:23','a ',1,'2008-10-11 18:49:54','N','대박이'),
 (37,'xx',500000,'MC002','2008-10-11 18:25:25','a',1,'2008-10-11 18:49:53','N','대박이'),
 (38,'xx',500000,'MC002','2008-10-11 18:25:28','a',1,'2008-10-11 18:49:53','N','대박이'),
 (39,'xx',500000,'MC002','2008-10-11 18:25:31','a',1,'2008-10-11 18:49:52','N','대박이'),
 (40,'xx',500000,'MC002','2008-10-11 18:25:33','a',1,'2008-10-11 18:49:51','N','대박이'),
 (41,'xx',500000,'MC002','2008-10-11 18:25:36','a',1,'2008-10-11 18:49:50','N','대박이'),
 (42,'xx',500000,'MC002','2008-10-11 18:25:47','a',1,'2008-10-11 18:49:48','N','대박이'),
 (43,'xx',500000,'MC002','2008-10-11 18:25:51','aa',1,'2008-10-11 18:49:47','N','대박이'),
 (44,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:50:50','N','테스트'),
 (45,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:50:54','N','테스트'),
 (46,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:50:59','N','테스트'),
 (47,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:01','N','테스트'),
 (48,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:03','N','테스트'),
 (49,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:05','N','테스트'),
 (50,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:07','N','테스트'),
 (51,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:11','N','테스트'),
 (52,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:13','N','테스트'),
 (53,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:15','N','테스트'),
 (54,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:17','N','테스트'),
 (55,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:22','N','테스트'),
 (56,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:24','N','테스트'),
 (57,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:26','N','테스트'),
 (58,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:27','N','테스트'),
 (59,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:29','N','테스트'),
 (60,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:39','N','테스트'),
 (61,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:40','N','테스트'),
 (62,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:42','N','테스트'),
 (63,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:43','N','테스트'),
 (64,'test',1,'MC004',NULL,NULL,NULL,'2008-10-11 18:51:45','N','테스트');
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
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_money_out`
--

/*!40000 ALTER TABLE `tbl_money_out` DISABLE KEYS */;
INSERT INTO `tbl_money_out` (`ID`,`USERID`,`MONEY`,`BANKNAME`,`NUMBER`,`NAME`,`REQ_DATE`,`PROC_DATE`,`STATUS`,`NICKNAME`) VALUES 
 (11,'xx',1,'국민','33333333','3333333','2008-10-11 17:58:34',NULL,'ME001','대박이'),
 (12,'xx',2,'국민','3333333','333333','2008-10-11 17:58:44','2008-10-11 18:13:17','ME002','대박이'),
 (13,'xx',1,'국민','44444444','4444','2008-10-11 17:58:57','2008-10-11 18:13:15','ME002','대박이'),
 (14,'xx',1,NULL,NULL,NULL,NULL,'2008-10-11 18:14:03','ME004','대박이');
/*!40000 ALTER TABLE `tbl_money_out` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
