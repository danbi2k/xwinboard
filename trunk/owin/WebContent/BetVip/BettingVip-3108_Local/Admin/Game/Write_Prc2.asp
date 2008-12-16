
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/BbsTransaction.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<!--	#include virtual=/common/asp/MemberClass.asp	-->
<%
	Dim arrName(40), arrValue(40)
	
	IntIdx		= Request("Idx")
	flag		= Request("flag")
	ScFlag		= Request("ScFlag")
	goPage		= "List.asp"
	If ScFlag = "2" Then goPage = "CloseList.asp"
'	Response.Write goPage
'	Response.End

			
			
			
			
			
			
			
			

'					RunSQL("UPDATE BetGame_TB Set Status=0 WHERE gIdx='"& IntIdx &"'")	'경기결과가 경기중이 아닐떄 무조건 게임완료로 자동변경
'					RunSQL("UPDATE Game_TB Set Status=0 WHERE Idx='"& IntIdx &"'")		'경기결과가 경기중이 아닐떄 무조건 게임완료로 자동변경
						
					SQL = "SELECT Idx, gbTem, gCnt, rMoney, Id, hMoney FROM BetGame_TB WHERE Id='neo4u' And Sect=5"
					Set Rss = RunSQLReturnRs(SQL)
					If Not Rss.EOF Then
						Do Until Rss.EOF
							If reInt(Rss("rMoney"),0) = 0 Then
								
								HitFlag = 0
								sSQL = "SELECT GoldHit FROM BetGame_TB WHERE gCnt='"& Rss("gCnt") &"'"
								Set Rss2 = RunSQLReturnRs(sSQL)
								If Not Rss2.EOF Then arrRs = Rss2.getRows() : arrRsCnt = Ubound(arrRs,2) : Set Rss2 = Nothing
									
'									Call CashChange(Rss("Id"), Rss("hMoney"), 3, 1, "배팅적중 적립")
									RunSQL("UPDATE BetGame_TB Set rMoney='"& Rss("hMoney") &"', ResuFlag=1 WHERE gCnt='"& Rss("gCnt") &"' And Id='neo4u' ")
									
							End If
						Rss.MoveNext
						Loop
					End If

			
		
		
		
		
%>
