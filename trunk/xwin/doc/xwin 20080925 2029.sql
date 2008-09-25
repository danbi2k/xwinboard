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
-- Definition of table `event`
--

DROP TABLE IF EXISTS `event`;
CREATE TABLE `event` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `NAME` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `event`
--

/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` (`ID`,`NAME`) VALUES 
 (5,'디바이스1'),
 (6,'디바이스2'),
 (7,'디바이스3');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;


--
-- Definition of table `ktfsms`
--

DROP TABLE IF EXISTS `ktfsms`;
CREATE TABLE `ktfsms` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `MSG_SEQ` varchar(16) NOT NULL,
  `IN_DATE` varchar(16) NOT NULL,
  `MSG` varchar(256) NOT NULL,
  `SM` varchar(2) NOT NULL,
  `CALL_BACK` varchar(16) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ktfsms`
--

/*!40000 ALTER TABLE `ktfsms` DISABLE KEYS */;
INSERT INTO `ktfsms` (`ID`,`MSG_SEQ`,`IN_DATE`,`MSG`,`SM`,`CALL_BACK`) VALUES 
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
/*!40000 ALTER TABLE `ktfsms` ENABLE KEYS */;


--
-- Definition of table `tbl_game_wdl`
--

DROP TABLE IF EXISTS `tbl_game_wdl`;
CREATE TABLE `tbl_game_wdl` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `HOME_TEAM` varchar(45) NOT NULL,
  `AWAY_TEAM` varchar(45) NOT NULL,
  `WIN_RATE` float(5,2) NOT NULL,
  `DRAW_RATE` float(5,2) NOT NULL,
  `LOSE_RATE` float(5,2) NOT NULL,
  `STATUS` char(5) character set ucs2 NOT NULL,
  `DATE` datetime NOT NULL,
  `LEAGUE_ID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_game_wdl`
--

/*!40000 ALTER TABLE `tbl_game_wdl` DISABLE KEYS */;
INSERT INTO `tbl_game_wdl` (`ID`,`HOME_TEAM`,`AWAY_TEAM`,`WIN_RATE`,`DRAW_RATE`,`LOSE_RATE`,`STATUS`,`DATE`,`LEAGUE_ID`) VALUES 
 (1,'LA 다저스','샌디에이고',1.30,0.00,2.30,'준비중','2008-09-25 14:52:05',1),
 (2,'LA 다저스','샌디에이고',1.30,0.00,2.30,'준비중','2008-09-25 14:58:27',1);
/*!40000 ALTER TABLE `tbl_game_wdl` ENABLE KEYS */;


--
-- Definition of table `tbl_league`
--

DROP TABLE IF EXISTS `tbl_league`;
CREATE TABLE `tbl_league` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `NAME` varchar(45) NOT NULL,
  `TYPE` varchar(45) NOT NULL default '',
  `IMAGE` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_league`
--

/*!40000 ALTER TABLE `tbl_league` DISABLE KEYS */;
INSERT INTO `tbl_league` (`ID`,`NAME`,`TYPE`,`IMAGE`) VALUES 
 (1,'MLB','BASEBALL',''),
 (2,'NBA','BASKETBALL',''),
 (3,'프리미어리그','SOCCER',''),
 (4,'WWE','ETC',''),
 (5,'KBO','BASEBALL','');
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
  `MOBILE` varchar(45) NOT NULL,
  `EMAIL` varchar(45) NOT NULL,
  `PIN` varchar(45) NOT NULL,
  `BALANCE` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_member`
--

/*!40000 ALTER TABLE `tbl_member` DISABLE KEYS */;
INSERT INTO `tbl_member` (`ID`,`USERID`,`PASSWORD`,`NICKNAME`,`MOBILE`,`EMAIL`,`PIN`,`BALANCE`) VALUES 
 (1,'xx','1111','yy','010-3333-3333','xx@yy','1111',1000000),
 (2,'tt','1111','tt','010-1111-1111','tt@tt','1111',50000);
/*!40000 ALTER TABLE `tbl_member` ENABLE KEYS */;


--
-- Definition of table `team`
--

DROP TABLE IF EXISTS `team`;
CREATE TABLE `team` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `NAME` varchar(45) NOT NULL,
  `LEAGUE_ID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `FK_TEAM_1` (`LEAGUE_ID`),
  CONSTRAINT `FK_TEAM_1` FOREIGN KEY (`LEAGUE_ID`) REFERENCES `tbl_league` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `team`
--

/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` (`ID`,`NAME`,`LEAGUE_ID`) VALUES 
 (1,'han',5),
 (2,'han',5),
 (3,'han',5),
 (4,'han',5),
 (5,'han',5);
/*!40000 ALTER TABLE `team` ENABLE KEYS */;


--
-- Definition of table `userinfo`
--

DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(32) NOT NULL,
  `NICKNAME` varchar(32) NOT NULL,
  `EMAIL` varchar(64) NOT NULL,
  `BALANCE` float NOT NULL default '0',
  `PASSWORD` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `userinfo`
--

/*!40000 ALTER TABLE `userinfo` DISABLE KEYS */;
INSERT INTO `userinfo` (`ID`,`USERID`,`NICKNAME`,`EMAIL`,`BALANCE`,`PASSWORD`) VALUES 
 (1,'yoshihiro','sakaguchi','yoshi@yahoo.com',1e+008,''),
 (2,'yoshihiro','sakaguchi','yoshi@yahoo.com',1e+008,''),
 (3,'yoshihiro','sakaguchi','yoshi@yahoo.com',1e+008,''),
 (4,'dfal','djfal','fdjla',319,'');
/*!40000 ALTER TABLE `userinfo` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
