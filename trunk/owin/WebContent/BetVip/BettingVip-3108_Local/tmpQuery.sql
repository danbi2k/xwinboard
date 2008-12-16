Create Database BettingVip
ON PRIMARY
(
	NAME='BettingVip',
	Filename='C:\Program Files\Microsoft SQL Server\MSSQL\Data\BettingVip_data',
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
	[Ssection] 	[varchar] (100) DEFAULT ('') NULL  ,
	[ip] 		[varchar] (50) NULL 
) 


insert into admin_tb (sid,spwd,Ssection) values('admin','1111','0')
update admin_tb set Ssection='0' 




--==��������������������==================================================================================================================
--drop table Leag_TB
--delete from Leag_TB
select * from Leag_TB

select convert(varchar(16),gsDate,120 ), convert(varchar(16),getdate(),120 ) from Game_TB

CREATE TABLE [dbo].[Leag_TB] (
	[Idx] 		[int] IDENTITY (1, 1) Primary Key NOT NULL ,
	[Sect]		[int] NOT NULL ,				--1.�߱�, 2.�౸, 3.��, 4.etc, 5�¹���
	[gName]	[varchar] (100) NULL ,			-- �߱�,�౸.... 
	[hcont]		[smallint]  NULL ,				-- ���������
	[vcont]		[smallint]  NULL ,				-- ���������
	[League] 	[varchar] (100) NULL ,			-- ����
	[WriteDay]	[datetime] Default(getdate())	NOT NULL
)



--drop table Game_TB
select gsDate,status from Game_TB
select gsDate,status from BetGame_TB order by idx desc

select Status from Game_TB where idx=3

select idx, convert(varchar(16),gsDate,120 ), convert(varchar(16),getdate(),120 ) from Game_TB

delete from game_tb where idx=18

select convert(varchar(16),gsDate,120 ), convert(varchar(16),getdate(),120 ) from Game_TB

select convert(varchar(16),DateAdd(n,-5,gsDate),120 ), convert(varchar(16),getdate(),120 ) from Game_TB

select Idx,status,convert(varchar(16),DateAdd(n,-5,gsDate),120 ), convert(varchar(16),getdate(),120 ) from Game_TB where
convert(varchar(16),DateAdd(n,-5,gsDate),120 ) <= convert(varchar(16),getdate(),120 )  

update game_tb set status=1

select convert(varchar(16),DateAdd(n,-5,getdate()),120 )  from Game_TB
update game_tb set sect=5, status=0
select * from game_tb

CREATE TABLE [dbo].[Game_TB] (
	[Idx] 		[int] IDENTITY (1, 1) Primary Key NOT NULL ,
	[Sect]		[int] NOT NULL ,				--1.�߱�, 2.�౸, 3.��, 4.etc, 5�¹���
	[gName]	[varchar] (100) NULL ,			-- �߱�,�౸.... 
	[hcont]		[smallint]  NULL ,				-- ���������
	[vcont]		[smallint]  NULL ,				-- ���������
	[gsDate] 	[varchar] (100) NULL ,			-- �����Ͻ�
	[League] 	[varchar] (100) NULL ,			-- ����
	[hTname]	[varchar] (100) NULL ,			-- ��(Ȩ��) �̸�, 
	[hAllot]		[varchar] (50) NULL ,			-- ��(Ȩ��) �����, 
	[hCap]	 	[varchar] (50) NULL ,			-- ��ĸ	(�����ϰ�� ���̾�)
	[HcapAllotl] 	[varchar] (50) NULL ,			-- ��ĸ ����� 	(�����ϰ�� ���̾�)
	[vTname]	[varchar] (100) NULL ,			-- ��(������) �̸�
	[vAllot] 		[varchar] (50) NULL ,			-- ��(������) �����
	[UpAllot] 	[varchar] (50) NULL ,			-- ���� ����� ��
	[Upflag] 	[smallint]  Default(0) NOT NULL ,		-- ��������(����� ��������) 0,�ƴ�, 1.����
	[rtel] 		[varchar] (100) NULL ,			-- �����
	[gResult] 	[smallint]  Default(0) NOT NULL ,		-- ����: 0.�����, 1.��(Ȩ��), 2.��(������) 3.��(���º�)  =============================
	[Status] 	[smallint]  Default(1) NOT NULL ,		-- ����: 0.����, 1.������(����), 2, �������, 3, ����
	[Event] 		[smallint]  Default(0) NOT NULL ,		-- ����: 0.�ƴϿ�, 1.��=============================
	[ChangId] 	[varchar] (500) NULL ,			-- ������ ���̵� --=====================
	[WriteDay]	[datetime] Default(getdate())	NOT NULL
)

SELECT   CONVERT(varchar(10), WriteDay, 120)
FROM      BetGame_TB
WHERE   (gCnt = 11090) AND (CONVERT(varchar(10), WriteDay, 120) = '2008-09-08')
ORDER BY Idx DESC

alter table Game_TB add ChangId varchar (500)
--drop table BetGame_TB
--delete BetGame_TB where idx=18 or idx=19 or idx=20 
select * from BetGame_TB order by idx desc


select Sect,gname,gIdx,Id,gsDate,League,hTname,vTname,bmoney,gbTem, gCnt from BetGame_TB order by idx desc


SELECT DISTINCT gIdx FROM BetGame_TB

SELECT Sect, League,gIdx, gsDate, hTname, vTname, Sum(bmoney) FROM BetGame_TB group by gIdx, Sect,League, gsDate, hTname, vTname 

SELECT Sect, League,gIdx, gsDate, hTname, vTname, Sum(bmoney) FROM BetGame_TB group by gIdx, Sect,League, gsDate, hTname, vTname 

SELECT Sum(bmoney) FROM BetGame_TB WHERE gbTem=1 and gIdx=6 


Group By gIdx

select convert(varchar(16),gsDate,120 ), convert(varchar(16),getdate(),120 ) from Game_TB
SELECT DISTINCT gCnt FROM BetGame_TB WHERE Id='neo4u'
SELECT DISTINCT gCnt FROM BetGame_TB order by gCnt
SELECT DISTINCT gCnt FROM BetGame_TB order by gCnt, ( SELECT TOP 10000000 Idx FROM BetGame_TB Order By Idx DESC)
SELECT DISTINCT gCnt FROM BetGame_TB WHERE ResuFlag='1' WHERE Id like '%sdf%'


SELECT DISTINCT gCnt FROM BetGame_TB WHERE Id='neo4u' And WriteDay 
BETWEEN convert(varchar(10),'2008-07-28',120 ) And convert(varchar(10),'2008-07-28',120 ) Order by gCnt DESC 

SELECT convert(varchar(10),WriteDay,120 ) FROM BetGame_TB WHERE Id='neo4u' And WriteDay 
update BetGame_TB set ResuFlag=0

SELECT DISTINCT gCnt FROM BetGame_TB  group by gCnt order by gcnt desc


SELECT bmoney, rMoney, writeday from BetGame_TB Order By WriteDay ASC

SELECT gCnt, Id, Sum(bmoney) As TobMondy,Sum(rMoney) As TorMoney
FROM BetGame_TB 
group by gCnt,Id
Order By gCnt DESC

SELECT *
FROM BetGame_TB where gcnt=6337





SELECT Sum(bmoney) FROM BetGame_TB WHERE gbTem=1 and gIdx=2043
SELECT Sum(bmoney) FROM BetGame_TB WHERE gbTem=2 and gIdx=2043
SELECT Sum(bmoney) FROM BetGame_TB WHERE gbTem=3 and gIdx=2043

SELECT * FROM BetGame_TB WHERE gbTem=2 and gIdx=2047

SELECT COUNT(gbTem), SUM(bMoney) FROM BetGame_TB WHERE gIdx=2043 And gbTem=2
SELECT * FROM BetGame_TB 


SELECT bMoney FROM BetGame_TB WHERE 
convert(varchar(10),WriteDay,120 ) = '2008-08-18 '

SELECT a.gCnt, a.bMoney, a.rMoney FROM (select DISTINCT gCnt,bmoney,rMoney from BetGame_TB WHERE convert(varchar(10),WriteDay,120 ) = '2008-08-18' ) as a 

SELECT a.gCnt, SUM(a.bMoney), SUM(a.rMoney) FROM (select DISTINCT gCnt,bmoney,rMoney from BetGame_TB WHERE convert(varchar(10),WriteDay,120 ) = '2008-08-18' ) as a 
GROUP BY a.gCnt 


select gname,gIdx,Id,gsDate,League,hTname,hAllot, hCap, HcapAllotl, vTname,vAllot, bmoney,rMoney, gbTem, gCnt, WriteDay 
from BetGame_TB WHERE convert(varchar(10),WriteDay,120 ) = '2008-08-01'

SELECT a.gCnt, a.bMoney, a.rMoney FROM (select DISTINCT gCnt, bmoney, rMoney from BetGame_TB WHERE convert(varchar(10),WriteDay,120 ) = convert(varchar(10),'2008-08-18',120 ) ) as a 

SELECT a.gCnt, SUM(a.bMoney), SUM(a.rMoney) FROM (select DISTINCT gCnt, bmoney, rMoney from BetGame_TB WHERE convert(varchar(10),WriteDay,120 ) = convert(varchar(10),'2008-08-18',120 ) ) as a 
GROUP BY a.gCnt 


SELECT a.bMoney, a.rMoney FROM (select DISTINCT SUM(bMoney) As bMoney, SUM(rMoney) As rMoney from BetGame_TB WHERE convert(varchar(10),WriteDay,120 ) = convert(varchar(10),'2008-08-18',120 ) GROUP BY gCnt ) as a 

SELECT a.bMoney, a.rMoney FROM (select DISTINCT SUM(bMoney) As bMoney, SUM(rMoney) As rMoney from BetGame_TB WHERE convert(varchar(10),WriteDay,120 ) = convert(varchar(10),'2008-08-18',120 ) GROUP BY gCnt ) as a 

SELECT DISTINCT SUM(bMoney) FROM BetGame_TB WHERE convert(varchar(10),WriteDay,120 ) = convert(varchar(10),'2008-08-01',120 ) 




SELECT bMoney FROM BetGame_TB 
WHERE gCnt = (SELECT DISTINCT gCnt FROM BetGame_TB )

GROUP BY gCnt ORDER BY gCnt DESC

WHERE convert(varchar(10),WriteDay,120 ) = convert(varchar(10),getdate(),120 ) 


select Id,SUM(bMoney) FROM BetGame_TB where Id='ppdw9845' group by Id

select sum(bmoney), Id FROM BetGame_TB where Id='ppdw9845' group by Id



select sum(bmoney) bmoney from (select  gCnt, bmoney  from BetGame_TB where  Id='ppdw9845' group by gCnt, bmoney ) a

select sum(bmoney) bmoney from (select  gCnt, bmoney  from BetGame_TB where  GoldHit=2 group by gCnt, bmoney ) a



select sum(bmoney) bmoney, sum(rmoney) rmoney from (select  gCnt, bmoney, rmoney  from BetGame_TB where convert(varchar(10),WriteDay,120 ) = '2008-08-01' group by gCnt, bmoney,rmoney   ) a
--BORG : 193919
--RORG : 123517



select sum(bmoney) bmoney  from 
(select  gCnt, bmoney from BetGame_TB where convert(varchar(10),WriteDay,120 ) = '2008-08-01' and GoldHit=2  group by gCnt, bmoney ) a

select sum(bmoney) bmoney  from 
(select  gCnt, bmoney from BetGame_TB where convert(varchar(10),WriteDay,120 ) = '2008-08-01' group by gCnt, bmoney ) a



--BORG : 193919 : ���ñݾ�
--RORG : 123517 : ���߱ݾ�
--MORG : 110503 :�����߱ݾ� (118753) (130520)

select Idx,gIdx,gsDate, bmoney,hmoney,rMoney, gCnt, GoldHit, writeday 
from BetGame_TB  WHERE convert(varchar(10),WriteDay,120 ) = '2008-08-01'


SELECT  DISTINCT gCnt FROM BetGame_TB b
WHERE gCnt = (SELECT sum(bmoney) FROM BetGame_TB WHERE b.gCnt = gCnt and Id='ppdw9845')

group BY gCnt



select sum(bmoney) bmoney, sum(rmoney) rmoney from 
(select  gCnt, bmoney, rmoney  from BetGame_TB group by gCnt, bmoney,rmoney   ) a



select sum(bmoney) from 
(select  gCnt, bmoney from BetGame_TB group by gCnt, bmoney ) a

select sum(bmoney) , gCnt from 
(select  bmoney, gCnt from BetGame_TB group by gCnt, bmoney  ) a


select sum(distinct bmoney), Id from BetGame_TB 

where convert(varchar(10),WriteDay,120 ) = '2008-08-01'  group by Id


select sum(distinct bmoney) from BetGame_TB WHERE Id='ppdw9845' 
and gCnt in(SELECT DISTINCT gCnt FROM BetGame_TB)
group by [Id]

--502500

select Id, sum(bmoney) As Tomoney, sum(hmoney) As Tohmoney, sum(rmoney) As Tormoney   from BetGame_TB 
where idx in(select distinct gCnt from BetGame_TB ) 
group by Id order by id

where idx in(select distinct gCnt from BetGame_TB where Id='pcch7' ) 

select idx,sum(bmoney,gcnt from BetGame_TB 
where idx in(select distinct gCnt from BetGame_TB where Id='pcch7' ) 


--89360 (pcch7 ȸ����ü���ñݾ�)

select Idx,sect,gIdx,Id,bmoney,hmoney,rMoney, gCnt from BetGame_TB 
WHERE gCnt='6350' 

select Idx,sect,gIdx,Id,bmoney,hmoney,rMoney, gCnt from BetGame_TB 
WHERE Id='gokhyu' 



select Idx,gIdx,Id,gsDate,hTname,hAllot, hCap, HcapAllotl, vTname,vAllot, bmoney,hmoney,rMoney, gCnt 
from BetGame_TB 
WHERE Id='ppdw9845' order by gcnt desc

--121000 (ppdw9845 ȸ����ü���ñݾ�)


select * from Cash_TB
select * from Betcart_TB order By Idx DESC

select * from BetGame_TB
update BetGame_TB set goldhit=0

select b.Idx, b.sect, b.gIdx, b.Id, b.bmoney, b.hmoney, b.rMoney, b.gCnt from BetGame_TB b, Game_TB g where b.gIdx=g.Idx

delete from BetGame_TB where gcnt=6366
update BetGame_TB set goldhit=0

update member_TB set point=1030100 where id='neo4u'

update member_TB set point=1000000 where id='ehdeh18'


SELECT gCnt FROM BetGame_TB WHERE gIdx=2053

SELECT DISTINCT gCnt FROM BetGame_TB WHERE gIdx=2053

--drop table BetGame_TB
--delete BetGame_TB where idx=18 or idx=19 or idx=20 

SELECT A.Idx, A.Id, A.gCnt, A.WriteDay
  FROM BetGame_TB A JOIN (SELECT gCnt
                      FROM BetGame_TB
                     GROUP BY gCnt
                     HAVING COUNT(DISTINCT ID) > 1) B 
    ON A.gCnt = B.gCnt order by a.gCnt DESC  


delete from Community_TB where id='neo4u'

select getDate()

SELECT REPLACE(REPLACE(REPLACE(getDate(),':',''),' ',''),'-','')

SELECT CONVERT(float,getDate(),113)



--update Game_TB set Status = 1 where idx=8969


--delete from BetGame_TB
--delete from Cash_TB
--delete from SumBetGame_TB
--delete from DubleBet_TB

select * from BetGame_TB order by Idx DESC
select * from Cash_TB order by Idx DESC
select * from SumBetGame_TB order by Idx DESC
select * from DubleBet_TB order by Idx DESC





CREATE TABLE [dbo].[BetGame_TB] (
	[Idx] 		[int] IDENTITY (1, 1) Primary Key NOT NULL ,
	[Sect]		[TinyInt] NOT NULL ,			--1.�߱�, 2.�౸, 3.��, 4.etc, 5�¹���, 6.��Ÿ(�ڵ�ĸ)
	[gName]	[varchar] (100) NULL ,			-- �߱�,�౸.... 
	[hcont]		[smallint]  NULL ,				-- ���������
	[vcont]		[smallint]  NULL ,				-- ���������
	[gIdx]		[int] NOT NULL ,				-- ���Ӱ�
	[Id]		[varchar] (100) NULL ,			-- �߱�,�౸.... 
	[gsDate] 	[varchar] (100) NULL ,			-- �����Ͻ�
	[League] 	[varchar] (100) NULL ,			-- ����
	[hTname]	[varchar] (100) NULL ,			-- ��(Ȩ��) �̸�, 
	[hAllot]		[varchar] (50) NULL ,			-- ��(Ȩ��) �����, 
	[hCap]	 	[varchar] (50) NULL ,			-- ��ĸ
	[HcapAllotl] 	[varchar] (50) NULL ,			-- ��ĸ �����
	[vTname]	[varchar] (100) NULL ,			-- ��(������) �̸�
	[vAllot] 		[varchar] (50) NULL ,			-- ��(������) �����
	[gbTem]	[smallint]  NOT NULL ,			-- ������ (1:Ȩ��, 2������, 3.���º�)
	[bMoney]	[int] NOT NULL ,				-- ���ñݾ�
	[rMoney]	[int] Default(0) NULL ,			-- ����ݾ�  --=====================
	[HaAllot]	[varchar] (50)NULL ,			-- ��ü�����
	[hMoney]	[int] NULL ,				-- �������߱ݾ�
	[AHaAllot]	[varchar] (50) NULL ,			-- �������߱ݾ�
	[AhMoney]	[int] Default(0) NULL ,			-- ����ݾ�  --=====================
	[GoldHit]	[TinyInt]  Default(0) NOT NULL ,		-- �������� 0.�����, 1.����, 2.������ 
	[ResuFlag]	[smallint]  Default(0) NOT NULL ,		-- ������ 0.������, 1.����Ϸ� 
	[rtel] 		[varchar] (100) NULL ,			-- �����
	[Status] 	[smallint]  Default(1) NOT NULL ,		-- ����: 0.����, 1.������(����), 2, �������, 3, ���� =====================
	[gCnt] 		[bigint]   NULL ,			-- ���� ����(�ѹ��� ���� �����Ѱͳ��� �׷�����, ���̺��� ����Ʈ������)
	[UHiden]	[bit]   NULL ,			-- ���� ����(�ѹ��� ���� �����Ѱͳ��� �׷�����, ���̺��� ����Ʈ������)
	[EvEnt]		[TinyInt] Default(0)  NULL ,			-- ���� ����(�ѹ��� ���� �����Ѱͳ��� �׷�����, ���̺��� ����Ʈ������)
	[InType]	[varchar] (50) NULL ,			-- �������߱ݾ�
	[ChangId] 	[varchar] (500) NULL ,			-- ������ ���̵� --=====================
	[Visbled] 	[tinyint] default(0) NULL ,			-- ������ ����Ϸ� ���ӿ��� --=====================
	[VisbledBN] 	[bit] default(0) NULL ,			-- ������ ����Ϸ� ���ӿ��� --=====================
	[VisbledBL] 	[bit] default(0) NULL ,			-- ������ ����Ϸ� ���ӿ��� --=====================
	[VisbledDBN] 	[bit] default(0) NULL ,			-- ������ ����Ϸ� ���ӿ��� --=====================
	[MisPF] 	[bit] default(0) NULL ,			-- ������ ����Ϸ� ���ӿ��� --=====================
	[VipFlag] 	[tinyint] default(0) NULL ,			-- ������ ����Ϸ� ���ӿ��� --=====================
	[WriteDay]	[datetime] Default(getdate())	NOT NULL
)





--drop table DubleBet_TB
--delete from DubleBet_TB
select * from DubleBet_TB

CREATE TABLE [dbo].[DubleBet_TB] (
	[Idx] 		[int] IDENTITY (1, 1) Primary Key NOT NULL ,
	[gIdx]		[int] NOT NULL ,				-- ���Ӱ�
	[gCnt] 		[bigint] NOT NULL 			-- ���� ����(�ѹ��� ���� �����Ѱͳ��� �׷�����, ���̺��� ����Ʈ������)

)





--drop table BetCart_TB
--delete from BetCart_TB
--delete from BetGame_TB
select * from BetCart_TB
select * from BetGame_TB
select DISTINCT gCnt from BetCart_TB

SELECT bmoney, rMoney, hMoneyFROM BetGame_TB  WHERE gCnt=6384 Order By WriteDay ASC


CREATE TABLE [dbo].[BetCart_TB] (
	[Idx] 		[int] IDENTITY (1, 1) Primary Key NOT NULL ,
	[Sect]		[TinyInt] NOT NULL ,			--1.�߱�, 2.�౸, 3.��, 4.etc
	[gName]	[varchar] (100) NULL ,			-- �߱�,�౸.... 
	[hcont]		[smallint]  NULL ,				-- ���������
	[vcont]		[smallint]  NULL ,				-- ���������
	[gIdx]		[int] NOT NULL ,				-- ���Ӱ�
	[Id]		[varchar] (100) NULL ,			-- �߱�,�౸.... 
	[gsDate] 	[varchar] (100) NULL ,			-- �����Ͻ�
	[League] 	[varchar] (100) NULL ,			-- ����
	[hTname]	[varchar] (100) NULL ,			-- ��(Ȩ��) �̸�, 
	[hAllot]		[varchar] (50) NULL ,			-- ��(Ȩ��) �����
	[hCap]	 	[varchar] (100) NULL ,			-- ��ĸ
	[HcapAllotl] 	[varchar] (50) NULL ,			-- ��ĸ �����
	[vTname]	[varchar] (100) NULL ,			-- ��(������) �̸�
	[vAllot] 		[varchar] (50) NULL ,			-- ��(������) �����
	[gbTem]	[smallint]  NOT NULL ,			-- ������ (1:Ȩ��, 2������, 3��)
	[bMoney]	[int] NOT NULL ,				-- ���ñݾ�
	[rMoney]	[int] NULL ,				-- ����ݾ�			###############
	[HaAllot]	[varchar]  Default(0) (50)NULL ,		-- ��ü�����
	[hMoney]	[int]  Default(0) NULL ,			-- �������߱ݾ�
	[ResuFlag]	[smallint]  Default(0) NOT NULL ,		-- ������ 0.������, 1.����Ϸ� 	###############
	[Status] 	[smallint]  Default(1) NOT NULL ,		-- ����: 1.������(����), 0.����    	###############
	[gCnt] 		[varchar] (100)  NULL ,				-- ���� ����(�ѹ��� ���� �����Ѱͳ��� �׷�����, ���̺��� ����Ʈ������)
	[WriteDay]	[datetime] Default(getdate())	NOT NULL
)





--drop table TmpBetCart_TB
--delete from TmpBetCart_TB
select * from TmpBetCart_TB

--delete from BetGame_TB
select * from BetGame_TB



CREATE TABLE [dbo].[TmpBetCart_TB] (
	[Idx] 		[int] IDENTITY (1, 1) Primary Key NOT NULL ,
	[Sect]		[int] NOT NULL ,				--1.�߱�, 2.�౸, 3.��, 4.etc
	[gName]	[varchar] (100) NULL ,			-- �߱�,�౸.... 
	[hcont]		[smallint]  NULL ,				-- ���������
	[vcont]		[smallint]  NULL ,				-- ���������
	[gIdx]		[int] NOT NULL ,				-- ���Ӱ�
	[Id]		[varchar] (100) NULL ,			-- �߱�,�౸.... 
	[gsDate] 	[varchar] (100) NULL ,			-- �����Ͻ�
	[League] 	[varchar] (100) NULL ,			-- ����
	[hTname]	[varchar] (100) NULL ,			-- ��(Ȩ��) �̸�, 
	[hAllot]		[varchar] (50) NULL ,			-- ��(Ȩ��) �����
	[hCap]	 	[varchar] (100) NULL ,			-- ��ĸ
	[HcapAllotl] 	[varchar] (50) NULL ,			-- ��ĸ �����
	[vTname]	[varchar] (100) NULL ,			-- ��(������) �̸�
	[vAllot] 		[varchar] (50) NULL ,			-- ��(������) �����
	[gbTem]	[smallint]  NOT NULL ,			-- ������ (1:Ȩ��, 2������, 3��)
	[bMoney]	[int] NOT NULL ,				-- ���ñݾ�
	[rMoney]	[int] NULL ,				-- ����ݾ�			###############
	[HaAllot]	[varchar] (50)NULL ,			-- ��ü�����
	[hMoney]	[int] NULL ,				-- �������߱ݾ�
	[ResuFlag]	[smallint]  Default(0) NOT NULL ,		-- ������ 0.������, 1.����Ϸ� 	###############
	[Status] 	[smallint]  Default(1) NOT NULL ,		-- ����: 1.������(����), 0.����    	###############
	[gCnt] 		[bigint]  NULL ,				-- ���� ����(�ѹ��� ���� �����Ѱͳ��� �׷�����, ���̺��� ����Ʈ������)
	[WriteDay]	[datetime] Default(getdate())	NOT NULL
)




--drop table member_tb
--delete from member_tb
select * from member_tb
update member_TB set VipFlag='okbet-vip.com' where id='neo4u'
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
,	[WriteDay]	[datetime]	Default(getdate())	NOT NULL
,	[Writeip]	[Varchar] (20)	NULL					--============================== ���ʷα��� �����Ƿ� ��ü�ϰ� ���ʷα��� ������,��¥�� ��������...
,	[Seceid]   	[TinyInt]		Default(0)	NOT NULL
,	[Visitnum] 	[Smallint]	Default(0)	NOT NULL
,	[Flogin]		[datetime]	NULL
,	[FloginIp]	[Varchar] (20)	NULL
,	[Llogin]		[datetime]	NULL
,	[LloginIp]	[Varchar] (20)	NULL
,	[VipFlag]	[Varchar] (100)	Default('okbet888.com')	NULL		--ȸ��������==============================
)

--==============================================================================
update member_tb set writeip=FloginIp				--==============
update member_tb set FloginIp=NULL, Flogin=NULL			--==============
update member_tb set VipFlag='okbet888.com'			--==============
update member_tb set point =0					--==============
--==============--==============--==============--==============--==============



select writeip,FloginIp,Flogin from member_tb


select Idx,Id,Point, Type from Points_TB Order BY Idx desc

select Idx, Point, Type, Sum(Point)  from Points_TB Group By Idx, Point, Type Order BY Idx desc

SELECT Idx, SUBSTRING(CONVERT(Varchar(50),Point,0), 1, 1),Point FROM Points_TB ORDER BY Idx

SELECT SUM(Point) FROM Points_TB WHERE Id='neoo' SUBSTRING(CONVERT(Varchar(50),Point,0), 1, 1)<>'-'
SELECT Point FROM Points_TB WHERE Id='' 

SELECT TOP 1 ToPoint FROM Points_TB WHERE Id ='neo4u' Order By Idx DESC




--drop table Cash_TB
--delete from Cash_TB

select * from Cash_TB where id='jej87488' order by idx desc
delete from Cash_TB  where  id='jej87488' and idx <> 703
select * from Member_TB where id='neo4u' 
select * from betgame_TB  

update Member_TB set point=1012550 where id='neo4u' 
delete from betgame_TB  
select sum(point) from member_tb
update cash_TB set status=0 where idx=1

SELECT SUM(ResultCash) FROM Cash_TB WHERE 
convert(varchar(10),WriteDay,120 ) = convert(varchar(10),'2008-08-30',120 ) 
idx in(select max(idx) from cash_TB group by id)

select * from Cash_TB

update cash_TB set status=0 where idx=1

Create Table [dbo].[Cash_TB] (
	[Idx]		[Int] NOT NULL Identity(1,1) Primary Key
,	[Id]		[Varchar] (20) NOT NULL
,	[RCash]	[int] Default(0) NULL		--����,ȯ�� ��û�ݾ� (�������� ����)
,	[TCash]		[int] Default(0) NULL		--����,ȯ�� �����ݾ� (�������� ����)
,	[ResultCash]	[int] Default(0) NULL		--������ ��ü�ݾ�(Point ����) ========================================
,	[Comment]	[Varchar] (100) NULL
,	[BankName]	[Varchar] (100) NULL
,	[BankCode]	[Varchar] (100) NULL
,	[Depos]		[Varchar] (50) NULL	-- ������
,	[Type]		[smallint] Default(0) NULL	--0 ������û, 1ȯ����û, 2����, 3�������� ����
,	[Status] 	[smallint] Default(0) NULL	--0 ����:������û, 1�Ϸ�
,	[Stops] 		[smallint] Default(0) NULL	--0 ���ǽ���, 1�������� ========================================
,	[InDay]		[Smalldatetime]	NULL
,	[gCnt]		[varchar] (100)	NULL
,	[WriteDay]	[datetime]	Default(getdate())	NOT NULL
)

--==============================================================================

alter table Cash_TB drop column NCash int Default(0) 		--==============
select point into NCash Cash_TB  from member_tb where d.Id=f.Id 	--==============

--==============--==============--==============


--drop table Community_TB
--delete from Community_TB

select count(idx),ref from Community_TB WHERE Sect=3 And Ref=Ref and Re_Step<>0 group by ref

SELECT COUNT(Idx) FROM Community_TB WHERE Re_Step=0
SELECT COUNT(Idx) FROM Community_TB WHERE Sect=3 And Ref=Ref and Re_Step<>0 group by ref
SELECT COUNT(Idx) FROM Community_TB WHERE Sect=3 And PRef<>1

CREATE TABLE [dbo].[Community_TB] (
	[Idx] 		[int] NOT NULL Primary Key  ,
	[Id]	 	[varchar] (20) NULL ,
	[Sect]	 	[TinyInt] NULL ,			/* 1����, 2�̺�Ʈ,  3,1:1ģ�����, 4(Ŀ)�����Խ���, 5(Ŀ)����ǰ �Ұ�, 6(Ŀ)������ ������, 7(Ŀ)�Ա��� Ȯ��, 8(Ŀ)������ϱ�, 9(��)������ ��*/
	[Subject] 	[varchar] (100) NULL ,
	[Refidx]	 	[int] NULL ,
	[Star]	 	[int] Default(1) NULL ,
	[Writer] 		[varchar] (20) NULL ,
	[PRef] 		[int] Default(0) NULL ,
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
/*################################# �о����� ���̺� ###################################*/

/*################################# �о����� �ڸ�Ʈ ���̺� ###################################*/
--drop table Community_TB_comment
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




--drop table Sms_TB
--delete from Sms_TB

CREATE TABLE [dbo].[Sms_TB] (
	[Idx] 		[int] IDENTITY (1, 1) Primary Key NOT NULL ,
	[ReCode]	[varchar] (100) NULL ,			-- �޼��� �߼� ����    00 : ���� , �� ���� �� : ����
	[TransCnt]	[varchar] (100) NULL ,			-- �߼۰Ǽ�
	[SendType]	[varchar] (100)NULL ,				-- �޼��� �߼� ��� 0 : ���,  1 : ����
	[rIdx]		[int] NULL ,				-- �߼� �޼����� ������ȣ (��ȸ, ���� ������ ���� �� �ʿ�)
	[Id]		[varchar] (1000) NULL ,			-- �߱�,�౸.... 
	[SumCnt]	[varchar] (100) NULL ,			-- �ܿ� �� �� 
	[ErrCode]	[varchar] (100) NULL ,			-- ���� �ڵ� (���� �ڵ�ǥ ����)
	[WriteDay]	[datetime] Default(getdate())	NOT NULL
)



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