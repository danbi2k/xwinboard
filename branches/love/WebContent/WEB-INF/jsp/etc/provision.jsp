<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.*"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="org.apache.commons.lang.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../header.jsp"%>



			<tr><td><img src="images/menu_login2.jpg" width="143" height="51"></td>
			</tr>
		
</table>
     <table width="850" border="0" cellpadding="0" cellspacing="0" bordercolor="dadada" bgcolor="e9e9e9" style="margin-top:20px;">
  <tr>
    <td style="padding-top:15px;padding-left:15px;padding-bottom:15px;padding-right:15px;"><table width="850" border="0" cellspacing="0" cellpadding="0">
    
      <tr>
        <td width="3%" valign="top">1.</td>
        <td width="97%"><span style="padding-top:12px;"><%=SiteConfig.SITE_NAME%>(이하 회사)은 회원님이 계정을 가지고 있을 때 아래의 내용에 대해 동의 한다고 가정합니다.</span></td>
      </tr>
      <tr>
        <td valign="top" style="padding-top:12px;">2.</td>
        <td style="padding-top:12px;">회사는 이용약관을 언제든지 변경하거나 추가 할 수 있습니다.<br />
          이용약관의 변경에 대한 내용은 사이트 내에 공지와 동시에 적용되며, 본 문서에 추가 됩니다. </td>
      </tr>
      <tr>
        <td valign="top"style="padding-top:12px;">3.</td>
        <td style="padding-top:12px;"><p>회원님들이 회원가입을 하시면 가입시의 절차에 따라 자동으로 회원 가입이 승인 됩니다.<br />
          특별히 회원 가입 승인에 제한을 두지 않으나, 악의적인 사용자와 사이트의 원활한 서비스를 위해 승인을 거부하거 나 취소 할 수 있습니다. <br />
          회사는 회원님들이 가입시 기재한 어떠한 정보도 제 3자에게 제공하거나 노출하지 않으며,  가능한 모든 방법을 동원하여 회원님들의 정보 보호에 만전을 다하고 있습니다만 불가항력적인 이유로정보가 노출 될 수도 있습니다.</p>          </td>
      </tr>
      <tr>
        <td valign="top" style="padding-top:12px;">4.</td>
        <td style="padding-top:12px;"><p>회원가입에 연령은 만 19세를 기준으로 합니다. 회사는 19세 미만의 고객이라고 판단되면 언제든지 해당회원의  접근을 제한하거나 가입 승인을 취소할 수 있습니다.</p>          </td>
      </tr>
      <tr>
        <td valign="top" style="padding-top:12px;">5.</td>
        <td style="padding-top:12px;"><p>회원은 자신의 회원아이디와 비밀번호의 비밀엄수에 대한 책임을 가지고 있습니다. 만약, 비밀번호가 노출되어  제 3자에 의해 만들어진 배팅이라 하더라도 유효한 것으로 간주 되며, 이에 따른 어떠한 책임도 회사는 지지 않습니다.</p>          </td>
      </tr>
      <tr>
        <td valign="top" style="padding-top:12px;">6.</td>
        <td valign="top" style="padding-top:12px;">회원은 언제든지 자신의 보유캐쉬를 사용하거나 환전신청하여 인출 할 수 있습니다.</td>
      </tr>
	   <tr>
        <td valign="top" style="padding-top:12px;">7.</td>
        <td valign="top" style="padding-top:12px;">만약 회원의 보유캐쉬와 관련된 배당금의 합계나 충전, 또는 환전에 따른 여러 계산에서 잘못된 점이 있다면 이 에 대한 신고와 재확인 요구는 회원에게 있습니다. <br />회원이 신고하거나 재확인 요구를 하지 않아서 발생한 직접 또는  간접적인 모든 배팅이나 충전, 환전 등 보유캐쉬와 관련된 일련의 모든 행위들은 모두 취소 처리 될 것입니다.          </td>
      </tr>
	   <tr>
        <td valign="top" style="padding-top:12px;">8.</td>
        <td style="padding-top:12px;"><p>회사는 모든 회원님들께 친절하고 편리한 서비스를 제공하는것을 목표로 삼고 있지만, 회사에 악의적인 특정한  계정에 대해서 회원자격을 박탈 할 수 있습니다.<br />
            이러한 경우에 해당 아이디의 모든 보유캐쉬는 몰수 되고 사이트 내에서의 모든 자격을 잃게 될 것입니다. <br />
          그러나 회원 스스로 회원 자격을 버릴 경우에는 자신의 보유캐쉬를 언제든지 신청하여 인출 할 수 있습니다.</p>          </td>
      </tr>
	   <tr>
        <td valign="top" style="padding-top:12px;">9.</td>
        <td style="padding-top:12px;"><p>회사는 언제나 정확한 정보를 제공하기 위해 최선의 노력을 다하고 있으나 예기치 않은 오류나 대응할 수 없는  불가 항력적인 사항의 경우 이에 따른 결과에 대해 수정할 권리를 가지고 있습니다.</p>          </td>
      </tr>
	   <tr>
        <td valign="top" style="padding-top:12px;">10.</td>
        <td style="padding-top:12px;"><p>회사는 어떤한 경우에도 불법적인 시도와 타협하거나 거래하지 않으며, 이를 막기 위해 가능한 모든 방법을 동원하고 있습니다.<br />
          회사는 불법적인 시도에 대한 모든 일련의 행위는 모두 취소 처리 할 권리가 있습니다.</p>
          </td>
      </tr>
    </table>
    </td>
  </tr>
</table>


<%@include file="../footer.jsp"%>