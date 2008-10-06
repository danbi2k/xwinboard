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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_account`
--

/*!40000 ALTER TABLE `tbl_account` DISABLE KEYS */;
INSERT INTO `tbl_account` (`ID`,`DATE`,`MONEY`,`BALANCE`,`DESCRIPTION`,`BETTING_ID`,`MONEYIN_ID`,`MONEYOUT_ID`,`TYPE`,`USERID`,`OLD_BALANCE`) VALUES 
 (32,'2008-10-06 19:34:49',-10000,2990000,NULL,'58',NULL,NULL,'AT001','test01',3000000),
 (33,'2008-10-06 19:43:02',20000,3010000,NULL,'58',NULL,NULL,'AT002','test01',2990000),
 (34,'2008-10-06 19:44:19',-10000,3000000,NULL,'59',NULL,NULL,'AT001','test01',3010000),
 (35,'2008-10-06 19:45:01',80000,3080000,NULL,'59',NULL,NULL,'AT002','test01',3000000),
 (36,'2008-10-06 19:45:57',-10000,3070000,NULL,'60',NULL,NULL,'AT001','test01',3080000),
 (37,'2008-10-06 19:46:58',-5000,3065000,NULL,'61',NULL,NULL,'AT001','test01',3070000),
 (38,'2008-10-06 19:47:48',-5000,3060000,NULL,'62',NULL,NULL,'AT001','test01',3065000),
 (39,'2008-10-06 19:50:34',-10000,3050000,NULL,'63',NULL,NULL,'AT001','test01',3060000);
/*!40000 ALTER TABLE `tbl_account` ENABLE KEYS */;


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
  `CANCEL_COUNT` int(10) unsigned NOT NULL default '0',
  `GAME_TYPE` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `HANDYDRAW_COUNT` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_betting`
--

/*!40000 ALTER TABLE `tbl_betting` DISABLE KEYS */;
INSERT INTO `tbl_betting` (`ID`,`USERID`,`DATE`,`RATE`,`MONEY`,`EXPECT`,`STATUS`,`TOTAL_COUNT`,`SUCCESS_COUNT`,`FAILURE_COUNT`,`CANCEL_COUNT`,`GAME_TYPE`,`NICKNAME`,`HANDYDRAW_COUNT`) VALUES 
 (57,'xx','2008-10-06 17:52:18',2.10,1000000,2100000,'BS007',1,0,0,0,'handy','대박이',1),
 (58,'test01','2008-10-06 19:34:49',2.00,10000,20000,'BS006',1,1,0,0,'wdl','테스트01',0),
 (59,'test01','2008-10-06 19:44:19',8.00,10000,80000,'BS006',3,3,0,0,'wdl','테스트01',0),
 (60,'test01','2008-10-06 19:45:57',4.00,10000,40000,'BS002',2,2,0,0,'wdl','테스트01',0),
 (61,'test01','2008-10-06 19:46:58',4.00,5000,20000,'BS003',2,1,1,0,'wdl','테스트01',0),
 (62,'test01','2008-10-06 19:47:48',2.00,5000,10000,'BS002',2,1,0,1,'wdl','테스트01',0),
 (63,'test01','2008-10-06 19:50:33',2.00,10000,20000,'BS002',1,1,0,0,'handy','테스트01',0);
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
 (57,136,'W'),
 (58,137,'W'),
 (59,138,'W'),
 (59,139,'W'),
 (59,140,'W'),
 (60,141,'W'),
 (60,142,'L'),
 (61,143,'W'),
 (61,144,'W'),
 (62,145,'W'),
 (62,146,'W'),
 (63,147,'W');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

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
 (20,'35','대박이',NULL,'fadfa','xx','2008-10-06 19:29:44');
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

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
 (31,'432432','xx','2008-10-06 19:26:29',0,'대박이','432','BIT10','user','BIS01'),
 (32,'4324','xx','2008-10-06 19:26:36',0,'대박이','432','BIT10','user','BIS01'),
 (33,'3','xx','2008-10-06 19:29:24',1,'대박이','3\r\n3\r\n3\r\n3\r\n3\r\n','BIT10','user','BIS01'),
 (34,'4324','xx','2008-10-06 19:29:31',0,'대박이','432','BIT10','qna','BIS01'),
 (35,'432432','xx','2008-10-06 19:29:35',3,'대박이','43244','BIT10','qna','BIS01'),
 (36,'ddd','xx','2008-10-06 19:36:01',0,'대박이','dd','BIT10','qna','BIS01'),
 (37,'dd','xx','2008-10-06 19:37:54',1,'대박이','dd','BIT10','qna','BIS01');
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
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_game`
--

/*!40000 ALTER TABLE `tbl_game` DISABLE KEYS */;
INSERT INTO `tbl_game` (`ID`,`HOME_TEAM`,`AWAY_TEAM`,`WIN_RATE`,`DRAW_RATE`,`LOSE_RATE`,`STATUS`,`GAME_DATE`,`LEAGUE_ID`,`TYPE`,`HOME_SCORE`,`AWAY_SCORE`,`RESULT`,`HANDY`,`BET_STATUS`) VALUES 
 (136,'삼성','부산',2.10,-1.00,3.20,'GS004','2008-10-06 21:00:00',13,'handy',3,2,0x44,NULL,'BTS01'),
 (137,'당첨','당첨',2.00,2.00,2.00,'GS004','2008-10-07 00:00:00',12,'wdl',2,1,0x57,NULL,'BTS01'),
 (138,'당첨','당첨',2.00,2.00,2.00,'GS004','2008-10-07 00:00:00',13,'wdl',2,1,0x57,NULL,'BTS01'),
 (139,'당첨','당첨',2.00,2.00,2.00,'GS004','2008-10-07 00:00:00',13,'wdl',2,1,0x57,NULL,'BTS01'),
 (140,'당첨','당첨',2.00,2.00,2.00,'GS004','2008-10-07 00:00:00',13,'wdl',2,1,0x57,NULL,'BTS01'),
 (141,'당첨','당첨',2.00,2.00,2.00,'GS004','2008-10-07 00:00:00',13,'wdl',2,1,0x57,NULL,'BTS01'),
 (142,'실패','실패',2.00,2.00,2.00,'GS004','2008-10-07 00:00:00',13,'wdl',1,2,0x4C,NULL,'BTS01'),
 (143,'당첨','당첨',2.00,2.00,2.00,'GS004','2008-10-07 00:00:00',13,'wdl',2,1,0x57,NULL,'BTS01'),
 (144,'실패','실패',2.00,2.00,2.00,'GS004','2008-10-07 00:00:00',13,'wdl',1,2,0x4C,NULL,'BTS01'),
 (145,'당첨','당첨',2.00,2.00,2.00,'GS004','2008-10-07 00:00:00',13,'wdl',2,1,0x57,NULL,'BTS01'),
 (146,'취소','취소',1.00,1.00,1.00,'GS005','2008-10-07 00:00:00',13,'wdl',NULL,NULL,NULL,NULL,'BTS01'),
 (147,'당첨','당첨',2.00,0.50,2.00,'GS004','2008-10-07 00:00:00',13,'handy',1,1,0x57,NULL,'BTS01');
/*!40000 ALTER TABLE `tbl_game` ENABLE KEYS */;


--
-- Definition of table `tbl_ktfsms`
--

DROP TABLE IF EXISTS `tbl_ktfsms`;
CREATE TABLE `tbl_ktfsms` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `MSG_SEQ` varchar(16) NOT NULL,
  `IN_DATE` varchar(16) NOT NULL,
  `MSG` varchar(256) NOT NULL,
  `SM` varchar(2) NOT NULL,
  `CALL_BACK` varchar(16) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_ktfsms`
--

/*!40000 ALTER TABLE `tbl_ktfsms` DISABLE KEYS */;
INSERT INTO `tbl_ktfsms` (`ID`,`MSG_SEQ`,`IN_DATE`,`MSG`,`SM`,`CALL_BACK`) VALUES 
 (1,'23780636','20080808103009','아아[FW]','S','01029017589'),
 (2,'55550864','20080808152508','┏━━┓덥쥐?샤~\n┃▒▒~@ 에어컨\n┃    ┃~@ 바람\n┃    ┃느껴져?\n┗━━┛[FW]','S','01040179992'),
 (3,'175544526','20080808152405','오빠 바쁜 것같은데 일 열심히 하고!!오늘 집에서 봐용~쪽쪽쪽 허그허그허그~~~[FW]','S','01040179992'),
 (4,'204189641','20080811113819','오케이ㅋㅋ[FW]','S','01040179992'),
 (5,'55367543','20080811145435','[강남자생]권승로원장 8월17일부터 일요진료중단. 매주 수/일요일은 진료휴진입니다.','S','0232182000'),
 (6,'245061667','20080811140339','응 유리도시키는게나은지봐요[FW]','S','01040179992'),
 (7,'734882332','20080811133346','아 문자못봤다[FW]','S','01046991429'),
 (8,'444151359','20080812113154','ㅈㅈ[FW]','S','01040139992'),
 (9,'494131242','20080812112832','ㅎㅎ[FW]','S','01040139992'),
 (10,'744552495','20080812123846','밥잘ㄴ먹었어?문화센터얌[FW]','S','01040179992'),
 (11,'334842484','20080812132704','ㄹㅇㄹㅇㄹㅇㄹㅇㄹㅇㄹㅇㄹ','S','01040139992'),
 (12,'175693885','20080813154901','문화센터얌[FW]','S','01040179992'),
 (13,'665182804','20080813142351','응 배송얼마나걸리는지도봐여[FW]','S','01040179992'),
 (14,'695174259','20080813142225','응 따로사는게나을것같아키키[FW]','S','01040179992'),
 (15,'504579756','20080813124317','삼성카드\n08/13 12:43\n(주)코스트코코리\n100,000원\n일시불사용\n감사합니다[FW]','S','15888700'),
 (16,'454578686','20080813124307','삼성카드\n08/13 12:42\n(주)코스트코코리\n59,960원\n일시불사용\n감사합니다[FW]','S','15888700'),
 (17,'34542272','20080813123702','추석날동대구행카풀신청했는데입금하면되는건가요?[FW]','S','01028999592'),
 (18,'14474755','20080813122547','집에서 썼던것처럼[FW]','S','0167417589'),
 (19,'14474654','20080813122546','근데 연결이 가능은 한거야? 아님 내가 그런거 하나사서 외장 상태로둬도 되는데 엄마','S','0167417589'),
 (20,'2881266','20080813121430','글쿠나 내가 중국관련 동영상 다운받다가 하드용량 다잡아먹어서.. 담에 꼭 부탁 T.T','S','0167417589'),
 (21,'2419416','20080813121227','우리집 컴? 본체에 들어있어? 연결만 안되있고? 케이스를 분리한거야?','S','0167417589'),
 (22,'14379513','20080813120955','너한테 있는 외장하드 (채운사진있는거) 용량이 얼마?[FW]','S','0167417589'),
 (23,'743975978','20080813110241','아침에누룽지그냥먹고속괜찮았어?지금도마니바빠?괜찮을때전화해주세용[FW]','S','01040179992'),
 (24,'4452461','20080813093313','☎ 캐치콜 ☎\n(통화중) 고객님께 걸려온 전화입니다.\n☆ 캐치콜 조회 \n**070 (무☆료)','S','01020865925'),
 (25,'686713224','20080812183855','[KB카드]성시원님08월25일 KB카드결제하실금액 59,352원 감사합니다(08/08기준)[FW]','S','15881688'),
 (26,'36362710','20080812174028','진아가 미역국 끓였다면서? 고맙다고 전해줘 [FW]','S','0167417589'),
 (27,'246071553','20080812165158','지금요리해용 헤헤[FW]','S','01040179992');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_member`
--

/*!40000 ALTER TABLE `tbl_member` DISABLE KEYS */;
INSERT INTO `tbl_member` (`ID`,`USERID`,`PASSWORD`,`NICKNAME`,`MOBILE`,`EMAIL`,`PIN`,`BALANCE`,`STATUS`,`GRADE`,`JOIN_DATE`) VALUES 
 (1,'xx','4444','대박이','016-4444-4444','jackpot@hotmail.com','1111',1000000,'US001','UG001','2008-09-29 00:00:00'),
 (2,'secadmin','3333','관리자','010-4444-4444','admin@admin.com','4444',0,'US001','UG100','2008-09-30 00:00:00'),
 (3,'test','test','테스트','010-2222-2222','test@test.com','test1111',2000000,'US001','UG001','2008-10-04 15:53:42'),
 (4,'test01','1111','테스트01','010-111-1111','1111@1111','1111',3050000,'US001','UG001','2008-10-05 20:12:29');
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
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

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
