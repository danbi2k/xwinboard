
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<%

			Session.Timeout = 1440
			Session("SYS_ID") = "IN"
			Session("SYS_Ssection") = 0
			Call descment("","Index.asp","")

%>
