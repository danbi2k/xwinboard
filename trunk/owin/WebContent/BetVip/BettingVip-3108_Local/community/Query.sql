Create Database Betting
ON PRIMARY
(
	NAME='Betting',
	Filename='J:\Program Files\Microsoft SQL Server\MSSQL\Data\Betting_data',
	Size=5mb,
	FileGrowth=1mb
)


Use Betting

select * from Admin_TB

CREATE TABLE [dbo].[Admin_TB] (
	[Idx] 		[int] IDENTITY (1, 1) Primary Key NOT NULL ,
	[SId]	 	[varchar] (50) NOT NULL ,
	[Sname]	[varchar] (50) NULL ,
	[Spart] 		[varchar] (100) NULL ,
	[Spwd] 		[varchar] (50) NULL ,
	[Writeday] 	[smalldatetime] DEFAULT (getdate()) NULL ,
	[Ssection] 	[varchar] (100) DEFAULT ('') NULL 
) 


insert into admin_tb (sid,spwd) values('admin','1111')
update admin_tb set sname='관리자' 




--drop table Game_TB
--delete from Game_TB
select * from Game_TB

select convert(varchar(16),gsDate,120 ), convert(varchar(16),getdate(),120 ) from Game_TB

CREATE TABLE [dbo].[Game_TB] (
	[Idx] 		[int] IDENTITY (1, 1) Primary Key NOT NULL ,
	[Sect]		[int] NOT NULL ,				--1.야구, 2.축구, 3.농구, 4.etc, 5승무패
	[gName]	[varchar] (100) NULL ,			-- 야구,축구.... 
	[hcont]		[smallint]  NULL ,				-- 국기아이콘
	[vcont]		[smallint]  NULL ,				-- 국기아이콘
	[gsDate] 	[varchar] (100) NULL ,			-- 게임일시
	[League] 	[varchar] (100) NULL ,			-- 리그
	[hTname]	[varchar] (100) NULL ,			-- 승(홈팀) 이름, 
	[hAllot]		[varchar] (50) NULL ,			-- 승(홈팀) 배당율, 
	[hCap]	 	[varchar] (50) NULL ,			-- 핸캡	(무패일경우 같이씀)
	[HcapAllotl] 	[varchar] (50) NULL ,			-- 핸캡 배당율 	(무패일경우 같이씀)
	[vTname]	[varchar] (100) NULL ,			-- 패(원정팀) 이름
	[vAllot] 		[varchar] (50) NULL ,			-- 패(원정팀) 배당율
	[UpAllot] 	[varchar] (50) NULL ,			-- 변경 배당율 값
	[Upflag] 	[smallint]  Default(0) NOT NULL ,		-- 마감여부(배당율 변경유무) 0,아님, 1.변경
	[rtel] 		[varchar] (100) NULL ,			-- 경기경과
	[Status] 	[smallint]  Default(1) NOT NULL ,		-- 상태: 0.마감, 1.진행중(배팅), 2, 마감경기
	[WriteDay]	[datetime] Default(getdate())	NOT NULL
)


--drop table BetGame_TB
--delete BetGame_TB where idx=18 or idx=19 or idx=20 
select * from BetGame_TB order by idx desc

select convert(varchar(16),gsDate,120 ), convert(varchar(16),getdate(),120 ) from Game_TB
SELECT DISTINCT gCnt FROM BetGame_TB WHERE Id='neo4u'

SELECT DISTINCT gCnt FROM BetGame_TB order by gCnt

SELECT DISTINCT gCnt FROM BetGame_TB order by gCnt, ( SELECT TOP 10000000 Idx FROM BetGame_TB Order By Idx DESC)

SELECT DISTINCT gCnt FROM BetGame_TB WHERE ResuFlag='1' WHERE Id like '%sdf%'


SELECT DISTINCT gCnt FROM BetGame_TB WHERE Id='neo4u' And WriteDay 
BETWEEN convert(varchar(10),'2008-07-28',120 ) And convert(varchar(10),'2008-07-28',120 ) Order by gCnt DESC 

SELECT convert(varchar(10),WriteDay,120 ) FROM BetGame_TB WHERE Id='neo4u' And WriteDay 


CREATE TABLE [dbo].[BetGame_TB] (
	[Idx] 		[int] IDENTITY (1, 1) Primary Key NOT NULL ,
	[Sect]		[int] NOT NULL ,				--1.야구, 2.축구, 3.농구, 4.etc, 5승무패
	[gName]	[varchar] (100) NULL ,			-- 야구,축구.... 
	[hcont]		[smallint]  NULL ,				-- 국기아이콘
	[vcont]		[smallint]  NULL ,				-- 국기아이콘
	[gIdx]		[int] NOT NULL ,				-- 게임값
	[Id]		[varchar] (100) NULL ,			-- 야구,축구.... 
	[gsDate] 	[varchar] (100) NULL ,			-- 게임일시
	[League] 	[varchar] (100) NULL ,			-- 리그
	[hTname]	[varchar] (100) NULL ,			-- 승(홈팀) 이름, 
	[hAllot]		[varchar] (50) NULL ,			-- 승(홈팀) 배당율, 
	[hCap]	 	[varchar] (50) NULL ,			-- 핸캡
	[HcapAllotl] 	[varchar] (50) NULL ,			-- 핸캡 배당율
	[vTname]	[varchar] (100) NULL ,			-- 패(원정팀) 이름
	[vAllot] 		[varchar] (50) NULL ,			-- 패(원정팀) 배당율
	[gbTem]	[smallint]  NOT NULL ,			-- 베팅팀 (1:홈팀, 2원정팀, 3.무승부)
	[bMoney]	[int] NOT NULL ,				-- 베팅금액
	[rMoney]	[int] NULL ,				-- 정산금액
	[HaAllot]	[varchar] (50)NULL ,			-- 전체배당율
	[hMoney]	[int] NULL ,				-- 예상적중금액
	[GoldHit]	[TinyInt]  Default(0) NOT NULL ,		-- 적중유무 0.대기중, 1.적중, 2.미적중 
	[ResuFlag]	[TinyInt]  Default(0) NOT NULL ,		-- 정산결과 0.정산전, 1.정산완료 
	[rtel] 		[varchar] (100) NULL ,			-- 경기경과
	[Status] 	[smallint]  Default(1) NOT NULL ,		-- 상태: 1.진행중(배팅), 0.마감, 2.마감경기
	[gCnt] 		[bigint]  NULL ,				-- 베팅 구룹(한번에 같이 베팅한것끼리 그룹지음, 마이베팅 리스트업떄문)
	[WriteDay]	[datetime] Default(getdate())	NOT NULL
)




--drop table BetCart_TB
--delete from BetCart_TB
--delete from BetGame_TB
select * from BetCart_TB
select * from BetGame_TB
select DISTINCT gCnt from BetCart_TB



CREATE TABLE [dbo].[BetCart_TB] (
	[Idx] 		[int] IDENTITY (1, 1) Primary Key NOT NULL ,
	[Sect]		[int] NOT NULL ,				--1.야구, 2.축구, 3.농구, 4.etc
	[gName]	[varchar] (100) NULL ,			-- 야구,축구.... 
	[hcont]		[smallint]  NULL ,				-- 국기아이콘
	[vcont]		[smallint]  NULL ,				-- 국기아이콘
	[gIdx]		[int] NOT NULL ,				-- 게임값
	[Id]		[varchar] (100) NULL ,			-- 야구,축구.... 
	[gsDate] 	[varchar] (100) NULL ,			-- 게임일시
	[League] 	[varchar] (100) NULL ,			-- 리그
	[hTname]	[varchar] (100) NULL ,			-- 승(홈팀) 이름, 
	[hAllot]		[varchar] (50) NULL ,			-- 승(홈팀) 배당율
	[hCap]	 	[varchar] (100) NULL ,			-- 핸캡
	[HcapAllotl] 	[varchar] (50) NULL ,			-- 핸캡 배당율
	[vTname]	[varchar] (100) NULL ,			-- 패(원정팀) 이름
	[vAllot] 		[varchar] (50) NULL ,			-- 패(원정팀) 배당율
	[gbTem]	[smallint]  NOT NULL ,			-- 베팅팀 (1:홈팀, 2원정팀, 3무)
	[bMoney]	[int] NOT NULL ,				-- 베팅금액
	[rMoney]	[int] NULL ,				-- 정산금액			###############
	[HaAllot]	[varchar] (50)NULL ,			-- 전체배당율
	[hMoney]	[int] NULL ,				-- 예상적중금액
	[ResuFlag]	[smallint]  Default(0) NOT NULL ,		-- 정산결과 0.정산전, 1.정산완료 	###############
	[Status] 	[smallint]  Default(1) NOT NULL ,		-- 상태: 1.진행중(배팅), 0.마감    	###############
	[gCnt] 		[bigint]  NULL ,				-- 베팅 구룹(한번에 같이 베팅한것끼리 그룹지음, 마이베팅 리스트업떄문)
	[WriteDay]	[datetime] Default(getdate())	NOT NULL
)





--drop table TmpBetCart_TB
--delete from TmpBetCart_TB
select * from TmpBetCart_TB

--delete from BetGame_TB
select * from BetGame_TB



CREATE TABLE [dbo].[TmpBetCart_TB] (
	[Idx] 		[int] IDENTITY (1, 1) Primary Key NOT NULL ,
	[Sect]		[int] NOT NULL ,				--1.야구, 2.축구, 3.농구, 4.etc
	[gName]	[varchar] (100) NULL ,			-- 야구,축구.... 
	[hcont]		[smallint]  NULL ,				-- 국기아이콘
	[vcont]		[smallint]  NULL ,				-- 국기아이콘
	[gIdx]		[int] NOT NULL ,				-- 게임값
	[Id]		[varchar] (100) NULL ,			-- 야구,축구.... 
	[gsDate] 	[varchar] (100) NULL ,			-- 게임일시
	[League] 	[varchar] (100) NULL ,			-- 리그
	[hTname]	[varchar] (100) NULL ,			-- 승(홈팀) 이름, 
	[hAllot]		[varchar] (50) NULL ,			-- 승(홈팀) 배당율
	[hCap]	 	[varchar] (100) NULL ,			-- 핸캡
	[HcapAllotl] 	[varchar] (50) NULL ,			-- 핸캡 배당율
	[vTname]	[varchar] (100) NULL ,			-- 패(원정팀) 이름
	[vAllot] 		[varchar] (50) NULL ,			-- 패(원정팀) 배당율
	[gbTem]	[smallint]  NOT NULL ,			-- 베팅팀 (1:홈팀, 2원정팀, 3무)
	[bMoney]	[int] NOT NULL ,				-- 베팅금액
	[rMoney]	[int] NULL ,				-- 정산금액			###############
	[HaAllot]	[varchar] (50)NULL ,			-- 전체배당율
	[hMoney]	[int] NULL ,				-- 예상적중금액
	[ResuFlag]	[smallint]  Default(0) NOT NULL ,		-- 정산결과 0.정산전, 1.정산완료 	###############
	[Status] 	[smallint]  Default(1) NOT NULL ,		-- 상태: 1.진행중(배팅), 0.마감    	###############
	[gCnt] 		[bigint]  NULL ,				-- 베팅 구룹(한번에 같이 베팅한것끼리 그룹지음, 마이베팅 리스트업떄문)
	[WriteDay]	[datetime] Default(getdate())	NOT NULL
)




--drop table member_tb
--delete from member_tb
select * from member_tb

Create Table [dbo].[Member_TB] (
	[Id]		[Varchar] (12)	Primary Key
,	[name]		[Varchar] (12)	NOT NULL
,	[Pwd]		[Varchar] (15)	NOT NULL
,	[Jumin]		[Varchar] (14)	NULL
,	[Birth]		[Varchar] (50)	NULL
,	[BirthTy]	[Varchar] (10)	NULL
,	[Mail]		[Varchar] (100)	NULL
,	[Tel]		[Varchar] (14)	NULL
,	[Cell]		[Varchar] (14)	NULL
,	[zipcode]	[Varchar] (7)	NULL
,	[Addr]		[Varchar] (200)	NULL
,	[gMail]		[Varchar] (10)	NULL
,	[gSms]		[Varchar] (10)	NULL
,	[Content]	[Varchar] (3000)	NULL
,	[Point]		[Int]		Default(0)	NULL
,	[WriteDay]	[Smalldatetime]	Default(getdate())	NOT NULL
,	[Seceid]   	[TinyInt]		Default(0)	NOT NULL
,	[Visitnum] 	[Smallint]	Default(0)	NOT NULL
,	[Flogin]		[Smalldatetime]	NULL
,	[FloginIp]	[Varchar] (20)	NULL
,	[Llogin]		[Smalldatetime]	NULL
,	[LloginIp]	[Varchar] (20)	NULL
)

select Idx,Id,Point, Type from Points_TB Order BY Idx desc

select Idx, Point, Type, Sum(Point)  from Points_TB Group By Idx, Point, Type Order BY Idx desc

SELECT Idx, SUBSTRING(CONVERT(Varchar(50),Point,0), 1, 1),Point FROM Points_TB ORDER BY Idx

SELECT SUM(Point) FROM Points_TB WHERE Id='neoo' SUBSTRING(CONVERT(Varchar(50),Point,0), 1, 1)<>'-'
SELECT Point FROM Points_TB WHERE Id='' 

SELECT TOP 1 ToPoint FROM Points_TB WHERE Id ='neo4u' Order By Idx DESC


--drop table MemOut_TB
--delete table MemOut_TB
select * from MemOut_TB

CREATE TABLE [dbo].[MemOut_TB] (
	[Id] 		[Varchar] (20) NOT NULL ,
	[Whi] 		[varchar] (100) NULL ,			/* 구매갯수 */
	[WriteDay] 	[smalldatetime] Default(Getdate()) NOT NULL 
)


--drop table Cash_TB
--delete from Cash_TB

select * from Cash_TB

select * from Member_TB
update cash_TB set status=0 where idx=1

Create Table [dbo].[Cash_TB] (
	[Idx]		[Int] NOT NULL Identity(1,1) Primary Key
,	[Id]		[Varchar] (20) NOT NULL
,	[RCash]	[int] Default(0) NULL
,	[TCash]		[int] Default(0) NULL
,	[Comment]	[Varchar] (100) NULL
,	[BankName]	[Varchar] (100) NULL
,	[BankCode]	[Varchar] (100) NULL
,	[Depos]		[Varchar] (50) NULL
,	[Type]		[smallint] Default(0) NULL	--0 충전요청, 1환전요청
,	[Status] 	[smallint] Default(0) NULL	--0 충전:완전요청, 1완료
,	[InDay]		[Smalldatetime]	NULL
,	[WriteDay]	[Smalldatetime]	Default(getdate())	NOT NULL
)



--drop table Community_TB
--delete from Community_TB
select * from Community_TB

CREATE TABLE [dbo].[Community_TB] (
	[Idx] 		[int] NOT NULL Primary Key  ,
	[Id]	 	[varchar] (20) NULL ,
	[Sect]	 	[TinyInt] NULL ,			/* 1공지, 2이벤트,  3,1:1친절상담, 4(커)자유게시판, 5(커)내작품 소개, 6(커)나만의 레시피, 7(커)입금자 확인, 8(커)묻고답하기, 9(레)레시피 팁*/
	[Subject] 	[varchar] (100) NULL ,
	[Refidx]	 	[int] NULL ,
	[Star]	 	[int] Default(1) NULL ,
	[Writer] 		[varchar] (20) NULL ,
	[PRef] 		[int] NULL ,
	[Email] 		[varchar] (100) NULL ,
	[HomePage]	[varchar] (100) NULL ,
	[File1] 		[varchar] (100) NULL ,
	[File2] 		[varchar] (100) NULL ,
	[File3] 		[varchar] (100) NULL ,
	[Pwd] 		[varchar] (15) NULL ,
	[WriteDay] 	[smalldatetime] Default(Getdate()) NOT NULL ,
	[Content] 	[text] NULL ,
	[Hit] 		[smallint] Default(0) NULL ,
	[Html] 		[smallint] NULL ,
	[Addoption]	[char] (5) NULL ,
	[Ip] 		[varchar] (20) NULL ,
	[Ref] 		[int] NULL ,
	[Re_Step] 	[smallint] NULL ,
	[Re_Level] 	[smallint] NULL ,
	[Notk] 		[smallint] Default(0) NOT NULL ,
	[HotNew]	[smallint] Default(0) NOT NULL 
) 
SELECT Subject, Writer, Email, Homepage, Writeday, Content, Hit, Html, ref, file1, file2, Notk, addOption, Pwd, ip FROM BunSca_TB WHERE Idx = 3 
/*################################# 분양일정 테이블 ###################################*/

/*################################# 분양일정 코멘트 테이블 ###################################*/
--drop table Community_TB_comment
--delete from Community_TB_comment
select * from Community_TB_comment


CREATE TABLE [dbo].[Community_TB_comment] (
	[num] 		[int] Primary Key Identity(1,1) NOT NULL ,
	[Id]	 	[varchar] (20) NULL ,
	[bnum] 		[int] NOT NULL ,
	[Cname] 	[varchar] (20) NULL ,
	[pwd] 		[varchar] (15) NULL ,
	[Ccomment] 	[varchar] (1000) NULL ,
	[rCnt]	 	[int] NULL ,
	[ip] 		[char] (20) NULL ,
	[WriteDay] 	[smalldatetime] DEFAULT (getdate()) NOT NULL 
)





--delete from VisitCnt_TB
select * from Blog_TB

insert into Blog_TB (idx,Content,file1) values(1,'sdfsdfsdf','panksso2.gif')

update Blog_TB set file1='panksso2.gif'

CREATE TABLE [dbo].[VisitCnt_TB] (
	[idx] 		[int] PRIMARY KEY IDENTITY (1, 1) NOT NULL ,
	[hit_date] 	[smalldatetime] NOT NULL ,
	[SessionID] 	[int] NOT NULL ,
	[REMOTE_HOST] [varchar] (15) NOT NULL ,
	[http_referer] 	[varchar] (255) NULL ,
	[cmon] 		[tinyint] NULL ,
	[cDay] 		[tinyint] NULL ,
	[cHour] 	[tinyint] NULL ,
	[cWeek] 	[tinyint] NULL ,
	[csite] 		[varchar] (50) NULL ,
	[cSearch] 	[varchar] (50) NULL ,
	[cOS] 		[varchar] (50) NULL ,
	[cbrowser] 	[varchar] (50) NULL ,
	[cpage] 	[varchar] (50) NULL 
)
SELECT COUNT(Idx) FROM VisitCnt_TB  WHERE convert(varchar(10),hit_date,121)='2006-12-22'


SELECT convert(varchar(10),hit_date,121) FROM VisitCnt_TB  WHERE convert(varchar(15),hit_date,121)='2006-12-22'

SELECT c.Idx, c.Product, c.unit, p.imgs, c.Options, p.Idx, p.AddOpt, c.Price, c.Point, p.UnitCnt, p.Doss FROM Carts_TB c,Products_TB P WHERE sessionId = '420476510' and c.RefIdx=p.Idx 

--drop table Rec_TB
--delete from Rec_TB where idx=2
select * from Rec_TB



select * FROM Community_TB WHERE Id='neo4u'
select * FROM Community_TB_comment WHERE Id='neo4u'
select * FROM GiftCard_TB WHERE Id='neo4u'
select * FROM InCheck_TB WHERE Id='neo4u'
select * FROM Member_TB WHERE Id='neo4u'
select * FROM MemOut_TB WHERE Id='neo4u'
select * FROM MyCuopn_TB WHERE Id='neo4u'
select * FROM MyWish_TB WHERE Id='neo4u'
select * FROM OrderDetail_TB WHERE Id='neo4u'
select * FROM Points_TB WHERE Id='neo4u'
select * FROM Product_comment WHERE Id='neo4u'		
select * FROM ToDayView_TB WHERE Id='neo4u'