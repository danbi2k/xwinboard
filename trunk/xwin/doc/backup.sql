DROP TABLE IF EXISTS `xwin`.`tbl_access`;
CREATE TABLE  `xwin`.`tbl_access` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `DATE` varchar(45) NOT NULL,
  `IP_ADDR` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `Index_2` (`USERID`),
  CONSTRAINT `FK_tbl_access_1` FOREIGN KEY (`USERID`) REFERENCES `tbl_member` (`USERID`)
) ENGINE=InnoDB AUTO_INCREMENT=140899 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_account`;
CREATE TABLE  `xwin`.`tbl_account` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `DATE` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `MONEY` int(11) NOT NULL,
  `BALANCE` bigint(20) NOT NULL default '0',
  `NOTE` varchar(128) default NULL,
  `BETTING_ID` varchar(45) default NULL,
  `MONEYIN_ID` varchar(45) default NULL,
  `MONEYOUT_ID` varchar(45) default NULL,
  `TYPE` varchar(45) NOT NULL,
  `USERID` varchar(45) NOT NULL,
  `OLD_BALANCE` bigint(20) NOT NULL default '0',
  `ISDELETED` varchar(8) NOT NULL default 'N',
  PRIMARY KEY  (`ID`),
  KEY `Index_2` (`USERID`),
  CONSTRAINT `FK_tbl_account_1` FOREIGN KEY (`USERID`) REFERENCES `tbl_member` (`USERID`)
) ENGINE=InnoDB AUTO_INCREMENT=120764 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_admin`;
CREATE TABLE  `xwin`.`tbl_admin` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `CONSTANT` varchar(45) NOT NULL,
  `VARIABLE` text NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_bankbook`;
CREATE TABLE  `xwin`.`tbl_bankbook` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `BANKNAME` varchar(45) NOT NULL,
  `NUMBER` varchar(45) NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `STATUS` varchar(45) NOT NULL,
  `DATE` datetime default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_betting`;
CREATE TABLE  `xwin`.`tbl_betting` (
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
  `ISDELETED` varchar(8) NOT NULL default 'N',
  PRIMARY KEY  (`ID`),
  KEY `FK_tbl_betting_1` (`USERID`),
  KEY `Index_3` USING BTREE (`STATUS`,`DATE`,`GAME_TYPE`),
  CONSTRAINT `FK_tbl_betting_1` FOREIGN KEY (`USERID`) REFERENCES `tbl_member` (`USERID`)
) ENGINE=InnoDB AUTO_INCREMENT=82263 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_betting_game`;
CREATE TABLE  `xwin`.`tbl_betting_game` (
  `BETTING_ID` int(10) unsigned NOT NULL,
  `GAME_ID` int(10) unsigned NOT NULL,
  `GUESS` varchar(45) NOT NULL,
  `GUESS_RATE` float(5,2) default '0.00',
  `WIN_RATE` float(5,2) default NULL,
  `DRAW_RATE` float(5,2) default NULL,
  `LOSE_RATE` float(5,2) default NULL,
  `SEL_RATE` float(5,2) default NULL,
  `RESULT_STATUS` varchar(16) default NULL,
  `RESULT` varchar(8) default NULL,
  PRIMARY KEY  (`BETTING_ID`,`GAME_ID`),
  KEY `FK_tbl_betting_game_1` (`GAME_ID`),
  CONSTRAINT `FK_tbl_betting_game_1` FOREIGN KEY (`GAME_ID`) REFERENCES `tbl_game` (`ID`),
  CONSTRAINT `FK_tbl_betting_game_2` FOREIGN KEY (`BETTING_ID`) REFERENCES `tbl_betting` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_betting_money_stat`;
CREATE TABLE  `xwin`.`tbl_betting_money_stat` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `DATE` datetime NOT NULL,
  `INMONEY` bigint(20) unsigned NOT NULL,
  `OUTMONEY` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_block_ip`;
CREATE TABLE  `xwin`.`tbl_block_ip` (
  `IP_ADDR` varchar(45) NOT NULL,
  `STATUS` varchar(8) NOT NULL default 'Y',
  PRIMARY KEY  (`IP_ADDR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_board_comment`;
CREATE TABLE  `xwin`.`tbl_board_comment` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `BOARD_ID` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `PASSWORD` varchar(45) default NULL,
  `COMMENT` text NOT NULL,
  `USERID` varchar(45) NOT NULL,
  `DATE` datetime NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12656 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_board_item`;
CREATE TABLE  `xwin`.`tbl_board_item` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `TITLE` varchar(256) NOT NULL,
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
  `GRADE` int(10) unsigned NOT NULL default '1',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8309 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_event_join`;
CREATE TABLE  `xwin`.`tbl_event_join` (
  `MOBILE` varchar(45) NOT NULL,
  PRIMARY KEY  (`MOBILE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_game`;
CREATE TABLE  `xwin`.`tbl_game` (
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
  `BET_STATUS` varchar(45) NOT NULL default 'BTS02',
  `DP_STATUS` varchar(45) NOT NULL default 'GMD02',
  `WIN_DENY` varchar(8) default 'Y',
  `DRAW_DENY` varchar(8) default 'Y',
  `LOSE_DENY` varchar(8) default 'Y',
  `HANDY` float(5,2) default NULL,
  `GRADE` int(10) unsigned NOT NULL default '1',
  PRIMARY KEY  (`ID`),
  KEY `Index_2` USING BTREE (`STATUS`),
  KEY `Index_3` (`GAME_DATE`),
  KEY `Index_4` (`TYPE`),
  KEY `Index_5` (`BET_STATUS`),
  KEY `Index_6` (`DP_STATUS`)
) ENGINE=InnoDB AUTO_INCREMENT=4499 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_ktfsms`;
CREATE TABLE  `xwin`.`tbl_ktfsms` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `MSG_SEQ` varchar(16) default NULL,
  `IN_DATE` varchar(16) default NULL,
  `MSG` varchar(256) default NULL,
  `SM` varchar(2) default NULL,
  `CALL_BACK` varchar(16) default NULL,
  `STATUS` varchar(45) NOT NULL default 'MC001',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=732 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_league`;
CREATE TABLE  `xwin`.`tbl_league` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `NAME` varchar(45) NOT NULL,
  `IMAGE` varchar(45) default NULL,
  `TYPE` varchar(45) default NULL,
  `ISDELETED` varchar(8) default 'N',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_log_hack`;
CREATE TABLE  `xwin`.`tbl_log_hack` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(45) default NULL,
  `NICKNAME` varchar(45) default NULL,
  `DATE` varchar(45) default NULL,
  `VALUE` text,
  `MODE` varchar(128) default NULL,
  `ISCHECKED` varchar(8) NOT NULL default 'N',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_member`;
CREATE TABLE  `xwin`.`tbl_member` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(45) NOT NULL,
  `PASSWORD` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `MOBILE` varchar(45) default NULL,
  `EMAIL` varchar(45) default NULL,
  `PIN` varchar(45) default NULL,
  `BALANCE` bigint(20) NOT NULL default '0',
  `STATUS` varchar(45) NOT NULL,
  `GRADE` int(10) unsigned NOT NULL default '1',
  `JOIN_DATE` datetime NOT NULL,
  `POINT` bigint(20) unsigned NOT NULL default '0',
  `BANKNAME` varchar(45) NOT NULL default '',
  `BANKNUMBER` varchar(45) NOT NULL default '',
  `BANKOWNER` varchar(45) NOT NULL default '',
  `BANKDATE` datetime default NULL,
  `GET_SMS` varchar(8) NOT NULL default 'Y',
  `DENYRITY` int(10) unsigned NOT NULL default '0',
  `BETTING_DATE` datetime default NULL,
  PRIMARY KEY  USING BTREE (`ID`),
  KEY `Index_2` (`USERID`),
  KEY `Index_3` (`STATUS`,`GRADE`)
) ENGINE=InnoDB AUTO_INCREMENT=2223 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_member_bankbook`;
CREATE TABLE  `xwin`.`tbl_member_bankbook` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `BANKNAME` varchar(45) NOT NULL,
  `NUMBER` varchar(45) NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `STATUS` varchar(45) NOT NULL,
  `DATE` datetime default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_member_memo`;
CREATE TABLE  `xwin`.`tbl_member_memo` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(45) NOT NULL,
  `MEMO` text NOT NULL,
  `DATE` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `ISREADED` varchar(8) NOT NULL default 'N',
  `ISDELETED` varchar(8) NOT NULL default 'N',
  PRIMARY KEY  (`ID`),
  KEY `FK_tbl_member_memo_1` (`USERID`),
  CONSTRAINT `FK_tbl_member_memo_1` FOREIGN KEY (`USERID`) REFERENCES `tbl_member` (`USERID`)
) ENGINE=InnoDB AUTO_INCREMENT=342 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_member_money_stat`;
CREATE TABLE  `xwin`.`tbl_member_money_stat` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `DATE` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `BALANCE` bigint(20) unsigned NOT NULL,
  `MONEY` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_money_in`;
CREATE TABLE  `xwin`.`tbl_money_in` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(45) NOT NULL,
  `MONEY` int(11) NOT NULL,
  `STATUS` varchar(45) NOT NULL,
  `REQ_DATE` datetime default NULL,
  `NAME` varchar(45) default NULL,
  `BANKBOOK_ID` int(10) unsigned default NULL,
  `PROC_DATE` datetime default NULL,
  `ISCHECKED` varchar(45) NOT NULL default 'N',
  `NICKNAME` varchar(45) NOT NULL,
  `ISDELETED` varchar(45) NOT NULL default 'N',
  `NOTE` varchar(128) default NULL,
  `ISREMOVED` varchar(8) NOT NULL default 'N',
  PRIMARY KEY  (`ID`),
  KEY `FK_tbl_money_in_1` (`BANKBOOK_ID`),
  KEY `FK_tbl_money_in_2` (`USERID`),
  KEY `Index_4` USING BTREE (`STATUS`,`ISDELETED`,`ISCHECKED`,`REQ_DATE`,`PROC_DATE`,`NICKNAME`,`NAME`),
  CONSTRAINT `FK_tbl_money_in_1` FOREIGN KEY (`BANKBOOK_ID`) REFERENCES `tbl_bankbook` (`ID`),
  CONSTRAINT `FK_tbl_money_in_2` FOREIGN KEY (`USERID`) REFERENCES `tbl_member` (`USERID`)
) ENGINE=InnoDB AUTO_INCREMENT=14096 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_money_out`;
CREATE TABLE  `xwin`.`tbl_money_out` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `USERID` varchar(45) NOT NULL,
  `MONEY` int(11) NOT NULL,
  `BANKNAME` varchar(45) default NULL,
  `NUMBER` varchar(45) default NULL,
  `NAME` varchar(45) default NULL,
  `REQ_DATE` datetime default NULL,
  `PROC_DATE` datetime default NULL,
  `STATUS` varchar(45) NOT NULL,
  `NICKNAME` varchar(45) NOT NULL,
  `ISCHECKED` varchar(45) NOT NULL default 'N',
  `ISDELETED` varchar(45) NOT NULL default 'N',
  `NOTE` varchar(128) default NULL,
  `ISREMOVED` varchar(8) NOT NULL default 'N',
  PRIMARY KEY  (`ID`),
  KEY `FK_tbl_money_out_1` (`USERID`),
  KEY `Index_3` (`NAME`,`REQ_DATE`,`PROC_DATE`,`STATUS`,`NICKNAME`,`ISCHECKED`,`ISDELETED`),
  CONSTRAINT `FK_tbl_money_out_1` FOREIGN KEY (`USERID`) REFERENCES `tbl_member` (`USERID`)
) ENGINE=InnoDB AUTO_INCREMENT=4224 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_point`;
CREATE TABLE  `xwin`.`tbl_point` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `DATE` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `MONEY` int(11) NOT NULL,
  `BALANCE` bigint(20) NOT NULL default '0',
  `NOTE` varchar(128) default NULL,
  `BETTING_ID` varchar(45) default NULL,
  `MONEYIN_ID` varchar(45) default NULL,
  `MONEYOUT_ID` varchar(45) default NULL,
  `TYPE` varchar(45) NOT NULL,
  `USERID` varchar(45) NOT NULL,
  `OLD_BALANCE` bigint(20) NOT NULL default '0',
  `ISDELETED` varchar(8) NOT NULL default 'N',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=87078 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_sms_wait`;
CREATE TABLE  `xwin`.`tbl_sms_wait` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `MSG` varchar(256) NOT NULL,
  `PHONE` varchar(45) NOT NULL,
  `CALLBACK` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `xwin`.`tbl_transaction`;
CREATE TABLE  `xwin`.`tbl_transaction` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `DATE` datetime NOT NULL,
  `TYPE` varchar(45) NOT NULL,
  `USERNAME` varchar(45) NOT NULL,
  `MONEY` bigint(20) default NULL,
  `BALANCE` bigint(20) default NULL,
  `ISCHARGE` varchar(8) NOT NULL default '-',
  `MSG_SEQ` varchar(45) default NULL,
  `IN_DATE` varchar(45) default NULL,
  `MONEYIN_ID` int(10) unsigned default NULL,
  `MONEYOUT_ID` int(10) unsigned default NULL,
  `NOTE` varchar(256) default NULL,
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `unique_3` USING BTREE (`MSG_SEQ`,`IN_DATE`),
  KEY `Index_2` (`ISCHARGE`)
) ENGINE=InnoDB AUTO_INCREMENT=6649 DEFAULT CHARSET=utf8;

DROP VIEW IF EXISTS `xwin`.`view_member_stat`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW  `xwin`.`view_member_stat` AS select `m`.`ID` AS `ID`,`m`.`USERID` AS `USERID`,`m`.`PASSWORD` AS `PASSWORD`,`m`.`NICKNAME` AS `NICKNAME`,`m`.`MOBILE` AS `MOBILE`,`m`.`EMAIL` AS `EMAIL`,`m`.`PIN` AS `PIN`,`m`.`BALANCE` AS `BALANCE`,`m`.`STATUS` AS `STATUS`,`m`.`GRADE` AS `GRADE`,`m`.`JOIN_DATE` AS `JOIN_DATE`,`m`.`POINT` AS `POINT`,`m`.`BANKNAME` AS `BANKNAME`,`m`.`BANKNUMBER` AS `BANKNUMBER`,`m`.`BANKOWNER` AS `BANKOWNER`,`m`.`BANKDATE` AS `BANKDATE`,`m`.`GET_SMS` AS `GET_SMS`,`m`.`DENYRITY` AS `DENYRITY`,(select ifnull(sum(`min`.`MONEY`),0) AS `IFNULL(SUM(MONEY), 0)` from `tbl_money_in` `min` where ((`min`.`USERID` = `m`.`USERID`) and (`min`.`STATUS` = _utf8'MC002'))) AS `MONEYIN_SUM`,(select ifnull(sum(`mout`.`MONEY`),0) AS `IFNULL(SUM(MONEY), 0)` from `tbl_money_out` `mout` where ((`mout`.`USERID` = `m`.`USERID`) and (`mout`.`STATUS` = _utf8'ME002'))) AS `MONEYOUT_SUM`,(select ifnull(sum(`b`.`MONEY`),0) AS `IFNULL(SUM(MONEY), 0)` from `tbl_betting` `b` where ((`b`.`USERID` = `m`.`USERID`) and (`b`.`STATUS` = _utf8'BS001'))) AS `BETTING_SUM` from `tbl_member` `m` where (`m`.`GRADE` <> _utf8'100');

DROP VIEW IF EXISTS `xwin`.`view_money_in_out`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW  `xwin`.`view_money_in_out` AS (select `m`.`ID` AS `ID`,`m`.`USERID` AS `USERID`,`m`.`MONEY` AS `MONEY`,`m`.`STATUS` AS `STATUS`,`m`.`REQ_DATE` AS `REQ_DATE`,`b`.`BANKNAME` AS `BANKNAME`,`b`.`NUMBER` AS `NUMBER`,`m`.`NAME` AS `NAME`,`m`.`PROC_DATE` AS `PROC_DATE`,`m`.`NICKNAME` AS `NICKNAME`,`m`.`ISDELETED` AS `ISDELETED`,`m`.`ISCHECKED` AS `ISCHECKED`,`m`.`NOTE` AS `NOTE` from (`tbl_money_in` `m` left join `tbl_bankbook` `b` on((`m`.`BANKBOOK_ID` = `b`.`ID`)))) union (select `tbl_money_out`.`ID` AS `ID`,`tbl_money_out`.`USERID` AS `USERID`,-(`tbl_money_out`.`MONEY`) AS `- MONEY`,`tbl_money_out`.`STATUS` AS `STATUS`,`tbl_money_out`.`REQ_DATE` AS `REQ_DATE`,`tbl_money_out`.`BANKNAME` AS `BANKNAME`,`tbl_money_out`.`NUMBER` AS `NUMBER`,`tbl_money_out`.`NAME` AS `NAME`,`tbl_money_out`.`PROC_DATE` AS `PROC_DATE`,`tbl_money_out`.`NICKNAME` AS `NICKNAME`,`tbl_money_out`.`ISDELETED` AS `ISDELETED`,`tbl_money_out`.`ISCHECKED` AS `ISCHECKED`,`tbl_money_out`.`NOTE` AS `NOTE` from `tbl_money_out`);