DROP TABLE IF EXISTS `xwin`.`tbl_access`;
CREATE TABLE  `apple`.`tbl_access` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `USERID` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `DATE` varchar(45) NOT NULL,
  `IP_ADDR` varchar(45) NOT NULL,
  `TYPE` varchar(45) DEFAULT NULL,
  `PASSWORD` varchar(45) DEFAULT NULL,
  `PIN` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Index_2` (`USERID`)
) ENGINE=InnoDB AUTO_INCREMENT=252295 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_log_otp`;
CREATE TABLE  `apple`.`tbl_log_otp` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PHONE` varchar(45) NOT NULL,
  `PIN` varchar(45) NOT NULL,
  `DATE` datetime NOT NULL,
  `IP_ADDR` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_account`;
CREATE TABLE  `xwin`.`tbl_account` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MONEY` int(11) NOT NULL,
  `BALANCE` bigint(20) NOT NULL DEFAULT '0',
  `NOTE` varchar(128) DEFAULT NULL,
  `BETTING_ID` varchar(45) DEFAULT NULL,
  `MONEYIN_ID` varchar(45) DEFAULT NULL,
  `MONEYOUT_ID` varchar(45) DEFAULT NULL,
  `TYPE` varchar(45) NOT NULL,
  `USERID` varchar(45) NOT NULL,
  `OLD_BALANCE` bigint(20) NOT NULL DEFAULT '0',
  `ISDELETED` varchar(8) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`ID`),
  KEY `Index_2` (`USERID`),
  CONSTRAINT `FK_tbl_account_1` FOREIGN KEY (`USERID`) REFERENCES `tbl_member` (`USERID`)
) ENGINE=InnoDB AUTO_INCREMENT=212518 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_admin`;
CREATE TABLE  `xwin`.`tbl_admin` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CONSTANT` varchar(45) NOT NULL,
  `VARIABLE` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_bankbook`;
CREATE TABLE  `xwin`.`tbl_bankbook` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `BANKNAME` varchar(45) NOT NULL,
  `NUMBER` varchar(45) NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `STATUS` varchar(45) NOT NULL,
  `DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_betting`;
CREATE TABLE  `xwin`.`tbl_betting` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `USERID` varchar(45) NOT NULL,
  `DATE` datetime NOT NULL,
  `RATE` float(8,2) DEFAULT NULL,
  `MONEY` int(10) unsigned NOT NULL,
  `EXPECT` bigint(20) NOT NULL,
  `STATUS` varchar(45) NOT NULL,
  `TOTAL_COUNT` int(10) unsigned NOT NULL DEFAULT '0',
  `SUCCESS_COUNT` int(10) unsigned NOT NULL DEFAULT '0',
  `FAILURE_COUNT` int(10) unsigned NOT NULL DEFAULT '0',
  `NOMATCH_COUNT` int(10) unsigned NOT NULL DEFAULT '0',
  `GAME_TYPE` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `HANDYDRAW_COUNT` int(10) unsigned NOT NULL DEFAULT '0',
  `CALC_STATUS` varchar(45) NOT NULL DEFAULT 'BTC01',
  `ISDELETED` varchar(8) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`ID`),
  KEY `FK_tbl_betting_1` (`USERID`),
  KEY `Index_3` (`STATUS`,`DATE`,`GAME_TYPE`) USING BTREE,
  CONSTRAINT `FK_tbl_betting_1` FOREIGN KEY (`USERID`) REFERENCES `tbl_member` (`USERID`)
) ENGINE=InnoDB AUTO_INCREMENT=146209 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_betting_game`;
CREATE TABLE  `xwin`.`tbl_betting_game` (
  `BETTING_ID` int(10) unsigned NOT NULL,
  `GAME_ID` int(10) unsigned NOT NULL,
  `GUESS` varchar(45) NOT NULL,
  `GUESS_RATE` float(5,2) DEFAULT '0.00',
  `WIN_RATE` float(5,2) DEFAULT NULL,
  `DRAW_RATE` float(5,2) DEFAULT NULL,
  `LOSE_RATE` float(5,2) DEFAULT NULL,
  `SEL_RATE` float(5,2) DEFAULT NULL,
  `RESULT_STATUS` varchar(16) DEFAULT NULL,
  `RESULT` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`BETTING_ID`,`GAME_ID`),
  KEY `FK_tbl_betting_game_1` (`GAME_ID`),
  CONSTRAINT `FK_tbl_betting_game_1` FOREIGN KEY (`GAME_ID`) REFERENCES `tbl_game` (`ID`),
  CONSTRAINT `FK_tbl_betting_game_2` FOREIGN KEY (`BETTING_ID`) REFERENCES `tbl_betting` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_betting_money_stat`;
CREATE TABLE  `xwin`.`tbl_betting_money_stat` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DATE` datetime NOT NULL,
  `INMONEY` bigint(20) unsigned NOT NULL,
  `OUTMONEY` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_block_ip`;
CREATE TABLE  `xwin`.`tbl_block_ip` (
  `IP_ADDR` varchar(45) NOT NULL,
  `STATUS` varchar(8) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`IP_ADDR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_board_comment`;
CREATE TABLE  `xwin`.`tbl_board_comment` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `BOARD_ID` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `PASSWORD` varchar(45) DEFAULT NULL,
  `COMMENT` text NOT NULL,
  `USERID` varchar(45) NOT NULL,
  `DATE` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18640 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_board_item`;
CREATE TABLE  `xwin`.`tbl_board_item` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(256) NOT NULL,
  `USERID` varchar(45) NOT NULL,
  `DATE` datetime NOT NULL,
  `READCOUNT` int(10) unsigned NOT NULL DEFAULT '0',
  `NICKNAME` varchar(45) NOT NULL,
  `CONTEXT` text NOT NULL,
  `TYPE` varchar(45) NOT NULL,
  `BOARDNAME` varchar(45) NOT NULL,
  `STATUS` varchar(45) NOT NULL,
  `ISDELETED` varchar(8) NOT NULL DEFAULT 'N',
  `ISCHECKED` varchar(8) NOT NULL DEFAULT 'N',
  `GRADE` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12166 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_event_join`;
CREATE TABLE  `xwin`.`tbl_event_join` (
  `MOBILE` varchar(45) NOT NULL,
  PRIMARY KEY (`MOBILE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_game`;
CREATE TABLE  `xwin`.`tbl_game` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `HOME_TEAM` varchar(45) NOT NULL,
  `AWAY_TEAM` varchar(45) NOT NULL,
  `WIN_RATE` float(5,2) DEFAULT NULL,
  `DRAW_RATE` float(5,2) DEFAULT NULL,
  `LOSE_RATE` float(5,2) DEFAULT NULL,
  `STATUS` varchar(45) CHARACTER SET ucs2 DEFAULT NULL,
  `GAME_DATE` datetime NOT NULL,
  `LEAGUE_ID` int(10) unsigned NOT NULL,
  `TYPE` varchar(45) NOT NULL,
  `HOME_SCORE` int(10) unsigned DEFAULT NULL,
  `AWAY_SCORE` int(10) unsigned DEFAULT NULL,
  `RESULT` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `BET_STATUS` varchar(45) NOT NULL DEFAULT 'BTS02',
  `DP_STATUS` varchar(45) NOT NULL DEFAULT 'GMD02',
  `WIN_DENY` varchar(8) DEFAULT 'Y',
  `DRAW_DENY` varchar(8) DEFAULT 'Y',
  `LOSE_DENY` varchar(8) DEFAULT 'Y',
  `HANDY` float(5,2) DEFAULT NULL,
  `GRADE` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`),
  KEY `Index_2` (`STATUS`) USING BTREE,
  KEY `Index_3` (`GAME_DATE`),
  KEY `Index_4` (`TYPE`),
  KEY `Index_5` (`BET_STATUS`),
  KEY `Index_6` (`DP_STATUS`)
) ENGINE=InnoDB AUTO_INCREMENT=7397 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_ktfsms`;
CREATE TABLE  `xwin`.`tbl_ktfsms` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MSG_SEQ` varchar(16) DEFAULT NULL,
  `IN_DATE` varchar(16) DEFAULT NULL,
  `MSG` varchar(256) DEFAULT NULL,
  `SM` varchar(2) DEFAULT NULL,
  `CALL_BACK` varchar(16) DEFAULT NULL,
  `STATUS` varchar(45) NOT NULL DEFAULT 'MC001',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=762 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_league`;
CREATE TABLE  `xwin`.`tbl_league` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(45) NOT NULL,
  `IMAGE` varchar(45) DEFAULT NULL,
  `TYPE` varchar(45) DEFAULT NULL,
  `ISDELETED` varchar(8) DEFAULT 'N',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_log_hack`;
CREATE TABLE  `xwin`.`tbl_log_hack` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `USERID` varchar(45) DEFAULT NULL,
  `NICKNAME` varchar(45) DEFAULT NULL,
  `DATE` varchar(45) DEFAULT NULL,
  `VALUE` text,
  `MODE` varchar(128) DEFAULT NULL,
  `ISCHECKED` varchar(8) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_member`;
CREATE TABLE  `xwin`.`tbl_member` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `USERID` varchar(45) NOT NULL,
  `PASSWORD` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `MOBILE` varchar(45) DEFAULT NULL,
  `EMAIL` varchar(45) DEFAULT NULL,
  `PIN` varchar(45) DEFAULT NULL,
  `BALANCE` bigint(20) NOT NULL DEFAULT '0',
  `STATUS` varchar(45) NOT NULL,
  `GRADE` int(10) unsigned NOT NULL DEFAULT '1',
  `JOIN_DATE` datetime NOT NULL,
  `POINT` bigint(20) unsigned NOT NULL DEFAULT '0',
  `BANKNAME` varchar(45) NOT NULL DEFAULT '',
  `BANKNUMBER` varchar(45) NOT NULL DEFAULT '',
  `BANKOWNER` varchar(45) NOT NULL DEFAULT '',
  `BANKDATE` datetime DEFAULT NULL,
  `GET_SMS` varchar(8) NOT NULL DEFAULT 'Y',
  `DENYRITY` int(10) unsigned NOT NULL DEFAULT '0',
  `BETTING_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `Index_2` (`USERID`),
  KEY `Index_3` (`STATUS`,`GRADE`)
) ENGINE=InnoDB AUTO_INCREMENT=2505 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_member_bankbook`;
CREATE TABLE  `xwin`.`tbl_member_bankbook` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `BANKNAME` varchar(45) NOT NULL,
  `NUMBER` varchar(45) NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `STATUS` varchar(45) NOT NULL,
  `DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_member_memo`;
CREATE TABLE  `xwin`.`tbl_member_memo` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `USERID` varchar(45) NOT NULL,
  `MEMO` text NOT NULL,
  `DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ISREADED` varchar(8) NOT NULL DEFAULT 'N',
  `ISDELETED` varchar(8) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`ID`),
  KEY `FK_tbl_member_memo_1` (`USERID`),
  CONSTRAINT `FK_tbl_member_memo_1` FOREIGN KEY (`USERID`) REFERENCES `tbl_member` (`USERID`)
) ENGINE=InnoDB AUTO_INCREMENT=471 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_member_money_stat`;
CREATE TABLE  `xwin`.`tbl_member_money_stat` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `BALANCE` bigint(20) unsigned NOT NULL,
  `MONEY` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_money_in`;
CREATE TABLE  `xwin`.`tbl_money_in` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `USERID` varchar(45) NOT NULL,
  `MONEY` int(11) NOT NULL,
  `STATUS` varchar(45) NOT NULL,
  `REQ_DATE` datetime DEFAULT NULL,
  `NAME` varchar(45) DEFAULT NULL,
  `BANKBOOK_ID` int(10) unsigned DEFAULT NULL,
  `PROC_DATE` datetime DEFAULT NULL,
  `ISCHECKED` varchar(45) NOT NULL DEFAULT 'N',
  `NICKNAME` varchar(45) NOT NULL,
  `ISDELETED` varchar(45) NOT NULL DEFAULT 'N',
  `NOTE` varchar(128) DEFAULT NULL,
  `ISREMOVED` varchar(8) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`ID`),
  KEY `FK_tbl_money_in_1` (`BANKBOOK_ID`),
  KEY `FK_tbl_money_in_2` (`USERID`),
  KEY `Index_4` (`STATUS`) USING BTREE,
  CONSTRAINT `FK_tbl_money_in_1` FOREIGN KEY (`BANKBOOK_ID`) REFERENCES `tbl_bankbook` (`ID`),
  CONSTRAINT `FK_tbl_money_in_2` FOREIGN KEY (`USERID`) REFERENCES `tbl_member` (`USERID`)
) ENGINE=InnoDB AUTO_INCREMENT=24168 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_money_out`;
CREATE TABLE  `xwin`.`tbl_money_out` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `USERID` varchar(45) NOT NULL,
  `MONEY` int(11) NOT NULL,
  `BANKNAME` varchar(45) DEFAULT NULL,
  `NUMBER` varchar(45) DEFAULT NULL,
  `NAME` varchar(45) DEFAULT NULL,
  `REQ_DATE` datetime DEFAULT NULL,
  `PROC_DATE` datetime DEFAULT NULL,
  `STATUS` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `ISCHECKED` varchar(45) NOT NULL DEFAULT 'N',
  `ISDELETED` varchar(45) NOT NULL DEFAULT 'N',
  `NOTE` varchar(128) DEFAULT NULL,
  `ISREMOVED` varchar(8) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`ID`),
  KEY `FK_tbl_money_out_1` (`USERID`),
  KEY `Index_3` (`STATUS`) USING BTREE,
  CONSTRAINT `FK_tbl_money_out_1` FOREIGN KEY (`USERID`) REFERENCES `tbl_member` (`USERID`)
) ENGINE=InnoDB AUTO_INCREMENT=7141 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_point`;
CREATE TABLE  `xwin`.`tbl_point` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MONEY` int(11) NOT NULL,
  `BALANCE` bigint(20) NOT NULL DEFAULT '0',
  `NOTE` varchar(128) DEFAULT NULL,
  `BETTING_ID` varchar(45) DEFAULT NULL,
  `MONEYIN_ID` varchar(45) DEFAULT NULL,
  `MONEYOUT_ID` varchar(45) DEFAULT NULL,
  `TYPE` varchar(45) NOT NULL,
  `USERID` varchar(45) NOT NULL,
  `OLD_BALANCE` bigint(20) NOT NULL DEFAULT '0',
  `ISDELETED` varchar(8) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=156581 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_sms_wait`;
CREATE TABLE  `xwin`.`tbl_sms_wait` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MSG` varchar(256) NOT NULL,
  `PHONE` varchar(45) NOT NULL,
  `CALLBACK` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4901 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_transaction`;
CREATE TABLE  `xwin`.`tbl_transaction` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DATE` datetime NOT NULL,
  `TYPE` varchar(45) NOT NULL,
  `USERNAME` varchar(45) NOT NULL,
  `MONEY` bigint(20) DEFAULT NULL,
  `BALANCE` bigint(20) DEFAULT NULL,
  `ISCHARGE` varchar(8) NOT NULL DEFAULT '-',
  `MSG_SEQ` varchar(45) DEFAULT NULL,
  `IN_DATE` varchar(45) DEFAULT NULL,
  `MONEYIN_ID` int(10) unsigned DEFAULT NULL,
  `MONEYOUT_ID` int(10) unsigned DEFAULT NULL,
  `NOTE` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `unique_3` (`MSG_SEQ`,`IN_DATE`) USING BTREE,
  KEY `Index_2` (`ISCHARGE`)
) ENGINE=InnoDB AUTO_INCREMENT=18507 DEFAULT CHARSET=utf8;

DROP VIEW IF EXISTS `xwin`.`view_member_stat`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW  `xwin`.`view_member_stat` AS select `m`.`BETTING_DATE` AS `BETTING_DATE`,`m`.`ID` AS `ID`,`m`.`USERID` AS `USERID`,`m`.`PASSWORD` AS `PASSWORD`,`m`.`NICKNAME` AS `NICKNAME`,`m`.`MOBILE` AS `MOBILE`,`m`.`EMAIL` AS `EMAIL`,`m`.`PIN` AS `PIN`,`m`.`BALANCE` AS `BALANCE`,`m`.`STATUS` AS `STATUS`,`m`.`GRADE` AS `GRADE`,`m`.`JOIN_DATE` AS `JOIN_DATE`,`m`.`POINT` AS `POINT`,`m`.`BANKNAME` AS `BANKNAME`,`m`.`BANKNUMBER` AS `BANKNUMBER`,`m`.`BANKOWNER` AS `BANKOWNER`,`m`.`BANKDATE` AS `BANKDATE`,`m`.`GET_SMS` AS `GET_SMS`,`m`.`DENYRITY` AS `DENYRITY`,(select ifnull(sum(`min`.`MONEY`),0) AS `IFNULL(SUM(MONEY), 0)` from `tbl_money_in` `min` where ((`min`.`USERID` = `m`.`USERID`) and (`min`.`STATUS` = _utf8'MC002'))) AS `MONEYIN_SUM`,(select ifnull(sum(`mout`.`MONEY`),0) AS `IFNULL(SUM(MONEY), 0)` from `tbl_money_out` `mout` where ((`mout`.`USERID` = `m`.`USERID`) and (`mout`.`STATUS` = _utf8'ME002'))) AS `MONEYOUT_SUM`,(select ifnull(sum(`b`.`MONEY`),0) AS `IFNULL(SUM(MONEY), 0)` from `tbl_betting` `b` where ((`b`.`USERID` = `m`.`USERID`) and (`b`.`STATUS` = _utf8'BS001'))) AS `BETTING_SUM` from `tbl_member` `m` where (`m`.`GRADE` <> _utf8'100');

DROP VIEW IF EXISTS `xwin`.`view_money_in_out`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW  `xwin`.`view_money_in_out` AS (select `m`.`ID` AS `ID`,`m`.`USERID` AS `USERID`,`m`.`MONEY` AS `MONEY`,`m`.`STATUS` AS `STATUS`,`m`.`REQ_DATE` AS `REQ_DATE`,`b`.`BANKNAME` AS `BANKNAME`,`b`.`NUMBER` AS `NUMBER`,`m`.`NAME` AS `NAME`,`m`.`PROC_DATE` AS `PROC_DATE`,`m`.`NICKNAME` AS `NICKNAME`,`m`.`ISDELETED` AS `ISDELETED`,`m`.`ISCHECKED` AS `ISCHECKED`,`m`.`NOTE` AS `NOTE` from (`tbl_money_in` `m` left join `tbl_bankbook` `b` on((`m`.`BANKBOOK_ID` = `b`.`ID`)))) union (select `tbl_money_out`.`ID` AS `ID`,`tbl_money_out`.`USERID` AS `USERID`,-(`tbl_money_out`.`MONEY`) AS `- MONEY`,`tbl_money_out`.`STATUS` AS `STATUS`,`tbl_money_out`.`REQ_DATE` AS `REQ_DATE`,`tbl_money_out`.`BANKNAME` AS `BANKNAME`,`tbl_money_out`.`NUMBER` AS `NUMBER`,`tbl_money_out`.`NAME` AS `NAME`,`tbl_money_out`.`PROC_DATE` AS `PROC_DATE`,`tbl_money_out`.`NICKNAME` AS `NICKNAME`,`tbl_money_out`.`ISDELETED` AS `ISDELETED`,`tbl_money_out`.`ISCHECKED` AS `ISCHECKED`,`tbl_money_out`.`NOTE` AS `NOTE` from `tbl_money_out`);