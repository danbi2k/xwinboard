<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.*"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="org.apache.commons.lang.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../header.jsp"%>



			<tr><td><img src="img/menu_batting2.jpg"></td>
			</tr>
		
</table>
     <table width="850" border="0" cellpadding="0" cellspacing="0" bordercolor="dadada" bgcolor="e9e9e9" style="margin-top:20px;">
  <tr>
    <td style="padding-top:15px;padding-left:15px;padding-bottom:15px;padding-right:15px;"><table width="850" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="2"><span style="font-weight: bold">◎ 승무패 경기 베팅규정</span></td>
      </tr>
      <tr>
        <td width="3%" valign="top">1.</td>
        <td width="97%">승무패는 대상경기의(승/무/패)결과를 정확하게 적중 시키는 베팅을 말합니다. 선택한 경기를 모두 맞힌 것을 적중으로 하며, 적중금은 적중배당률과   베팅금액을 곱하여 계산합니다. 선택한 경기를 모두 적중했을 경우 적중배당률과 맞힌 경기결과 배당률의 곱이며, 소수점 셋 째 자리 절사 후 둘 째   자리에서 절상하여 계산 합니다. </td>
      </tr>
      <tr>
        <td valign="top" style="padding-top:12px;">2.</td>
        <td style="padding-top:12px;">공지된 배당률은 사항에 따라 변동될 수 있습니다. 배당률은 경기결과에 영향을 미칠 수 있는(주요 선수의 부상 및 결장)등 여러 가 지 예기치 못한 변수에 의해서 변경되며, 배당률이 변경될 경우 변경싯점 이전에 베팅은 변경이전 배당률로 그대로 적용 받게 됩니다. </td>
      </tr>
      <tr>
        <td valign="top"style="padding-top:12px;">3.</td>
        <td style="padding-top:12px;">특정조합에 베팅이 집중될 경우 베팅을 차단할 수 있습니다. </td>
      </tr>
      <tr>
        <td valign="top" style="padding-top:12px;">4.</td>
        <td style="padding-top:12px;">승무패 대상경기는 주7회 선정되며. 배당률공지는 매일 12시(정오)에 업데이트 됩니다. </td>
      </tr>
      <tr>
        <td valign="top" style="padding-top:12px;">5.</td>
        <td style="padding-top:12px;">베팅한 경기중 취소된 경기의 승무패 배당률은 모두1.0배로 처리하며, 선택한 경기 중 한 경기라도 결과가 확정 되었을 경우 그 베팅은 유효하게 처리 됩니다. 단, 선택한 경기가 모두 취소가 되었을 경우는 100% 환불 처리 됩니다. </td>
      </tr>
      <tr>
        <td valign="top" style="padding-top:12px;">6.</td>
        <td style="padding-top:12px;">대상경기 시간은 정규 경기시간 까지의 결과를 적용합니다.(야구,농구,배구제외) 축구 - 전/후반까지의 결과 적용(연장전 및 승부차기 제외) 농구   -1~4쿼터까지 승부나지 않을시 연장전 적용 배구 - 정규세트까지 승부결과가 나지않을시 연장전 경기결과 적용 야구 - 정규 9이닝 까지   승부결과가 나지않을시 연장전 경기결과적용 더블헤더 경기는 첫번째 개최되는 경기를 적용합니다.! </td>
      </tr>
	   <tr>
        <td valign="top" style="padding-top:12px;">7.</td>
        <td style="padding-top:12px;">마감시간은 한국시간을 기준으로 하며, 베팅은 경기시작 5분전에 베팅 선착순 시간대별로 마감하며, 기타 운영상의 사유에 따라 변경될 수 있습니다. </td>
      </tr>
	   <tr>
        <td valign="top" style="padding-top:12px;">8.</td>
        <td style="padding-top:12px;">회원은 자신에 베팅머니를 24시간 언제든지 인출을 요구할 수 있으며, [<%=SiteConfig.SITE_NAME%>]은 회원의 인출요구를 신속하게 처리 합니다. </td>
      </tr>
	   <tr>
        <td valign="top" style="padding-top:12px;">9.</td>
        <td style="padding-top:12px;">베팅금액은(\5,000 ~ \1,000,000)이며 베팅상한선을 초과 베팅 할 경우 베팅이 제한됩니다. 최대 적중금 상한가는 3백만원이며,   적중배당률과 구입금액의 곱이 3백만원을 초과할 경우 3백만원까지 지급됩니다.(<%=SiteConfig.SITE_NAME%>의 공지에 의해 변동가능) </td>
      </tr>
	   <tr>
        <td valign="top" style="padding-top:12px;">10.</td>
        <td style="padding-top:12px;">정상적인 베팅이라면, 취소되거나 변경되지 않습니다. 회원은 베팅한 내역을 반드시 확인 해야 합니다. </td>
      </tr>
	   <tr>
        <td valign="top" style="padding-top:12px;">11.</td>
        <td style="padding-top:12px;">[<%=SiteConfig.SITE_NAME%>]은 운영에 지장을 초래 하는 회원에 한해 계정을 취소 또는 정지 시킬 수 있는 권리가 있으며, 보유 머니 삭제 될수 있습니다. </td>
      </tr>
	   <tr>
        <td valign="top" style="padding-top:12px;">12.</td>
        <td style="padding-top:12px;">시스템 및 전산장비의 오류 또는 천재지변으로 인한 장애 발생시 [<%=SiteConfig.SITE_NAME%>]은 이를 변경, 취소할 수 있습니다. 베팅 및 정산과 관련된 오류 발생시, 회원은 이를 [<%=SiteConfig.SITE_NAME%>]에 즉시 알려야 할 책임이 있습니다. [<%=SiteConfig.SITE_NAME%>]이 인지 못한 오류로 발생되는 회원의 손실은 [<%=SiteConfig.SITE_NAME%>]이 책임지지 않습니다. </td>
      </tr>
    </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:20px;">
        <tr>
          <td colspan="2"><span style="font-weight: bold">◎ 핸디캡 경기 베팅규정</span></td>
        </tr>
        <tr>
          <td width="3%" valign="top">1.</td>
          <td width="97%" valign="top">핸디캡(야구/농구) 대상경기를 선택하여 승/패 결과를 예상하여 맞히는 방식입니다. </td>
        </tr>
        <tr>
          <td valign="top" style="padding-top:12px;">2.</td>
          <td valign="top" style="padding-top:12px;">선택한 경기를 모두 맞힌 것을 적중으로 하며, 적중금은 적중배당률과 베팅금액을 곱하여 계산합니다. </td>
        </tr>
        <tr>
          <td valign="top"style="padding-top:12px;">3.</td>
          <td style="padding-top:12px;">핸디캡과 배당률은 수시로 변동 됩니다. 배당률이 변경될 경우 변경싯점 이전에 베팅은 변경이전 배당률로 그대로 적용 받게 됩니다. </td>
        </tr>
        <tr>
          <td valign="top" style="padding-top:12px;">4.</td>
          <td style="padding-top:12px;">핸디캡 베팅상한선은 \5,000 ~ \1,000,000 까지이며 초과 베팅 할 경우 베팅이 제한됩니다. 최대 적중금 상한가는 3백만 원이며, 적중배당률과 구입금액의 곱이 3백만 원을 초과할 경우 적중금 지급이 제한됩니다.(애플벳의 공지에 의해 변동가능) </td>
        </tr>
        <tr>
          <td valign="top" style="padding-top:12px;">5.</td>
          <td valign="top" style="padding-top:12px;">핸디캡 대상경기는 주7회 선정되며. 배당률공지는 매일 12시(정오)에 업데이트 됩니다. </td>
        </tr>
        <tr>
          <td valign="top" style="padding-top:12px;">6.</td>
          <td valign="top" style="padding-top:12px;">취소된 경기는 모두1.0배로 처리하며, 선택한 경기중 한 경기라도 결과가 확정 되었을 경우 그 베팅은 유효하게 처리됩니다. 단, 선택한 경기가 모두 취소가 되었을 경우는 환불합니다. </td>
        </tr>
        <tr>
          <td valign="top" style="padding-top:12px;">7.</td>
          <td style="padding-top:12px;">대상경기 시간은 정규 경기시간까지의 결과를 적용합니다.(야구,농구,배구제외)<br />
            축구 - 전/후반까지의 결과 적용(연장전 및 승부차기   제외)<br />
            농구 -1~4쿼터까지 정규시간만 적용(연장전 제외) <br />
            배구 - 정규세트까지 승부결과가 나지않을시 연장전 경기결과적용<br />
          야구   - 정규 9이닝 까지 승부결과가 나지않을시 연장전 경기결과적용 더블헤더 경기 시에는 첫 번째 개최되는 경기를 적용합니다.! </td>
        </tr>
        <tr>
          <td valign="top" style="padding-top:12px;">8.</td>
          <td style="padding-top:12px;">베팅 시간은 경기시작 한국시간 기준으로 경기시작 5분전에 시간별로 마감됩니다. </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:20px;">
        <tr>
          <td colspan="2"><span style="font-weight: bold">◎ 승무패/핸디캡 경기 [조합베팅] 규정</span></td>
        </tr>
        <tr>
          <td width="3%" valign="top">1.</td>
          <td width="97%" valign="top">대상경기 들을 선택하여 승무패/핸디캡 경기 [조합베팅] 하는 방식입니다. </td>
        </tr>
        <tr>
          <td valign="top" style="padding-top:12px;">2.</td>
          <td valign="top" style="padding-top:12px;">선택한 경기를 모두 맞힌 것을 적중으로 하며, 적중금은 적중배당률과 베팅금액을 곱하여 계산합니다. </td>
        </tr>
        <tr>
          <td valign="top"style="padding-top:12px;">3.</td>
          <td style="padding-top:12px;">승무패/핸디캡 경기 [조합베팅]의 베팅상한선은 \5,000 ~ \1,000,000 까지이며 초과 베팅 할 경우 베팅이 제한됩니다. 최대 적중금 상한가는 3백만 원이며, 적중배당률과 구입금액의 곱이 3백만 원을 초과할 경우 적중금 지급이 제한됩니다.(애플벳의 공지에 의해 변동가능) </td>
        </tr>
        <tr>
          <td valign="top" style="padding-top:12px;">4.</td>
          <td style="padding-top:12px;">취소된 경기는 모두1.0배로 처리하며, 선택한 경기중 한 경기라도 결과가 확정 되었을 경우 그 베팅은 유효하게 처리됩니다. 단, 선택한 경기가 모두 취소가 되었을 경우는 환불합니다. </td>
        </tr>
        <tr>
          <td valign="top" style="padding-top:12px;">5.</td>
          <td valign="top" style="padding-top:12px;">대상경기 시간은 정규 경기시간까지의 결과를 적용합니다.(야구,농구,배구제외) 축구 - 전/후반까지의 결과 적용(연장전 및 승부차기 제외) 농구 -1~4쿼터까지 정규시간만 적용(연장전 제외) 배구 - 정규세트까지 승부결과가 나지않을시 연장전 경기결과적용 야구 - 정규 9이닝 까지 승부결과가 나지않을시 연장전 경기결과적용 더블헤더 경기 시에는 첫 번째 개최되는 경기를 적용합니다.! </td>
        </tr>
        <tr>
          <td valign="top" style="padding-top:12px;">6.</td>
          <td valign="top" style="padding-top:12px;">베팅 시간은 경기시작 한국시간 기준으로 경기시작 5분전에 시간별로 마감됩니다. </td>
        </tr>
      </table></td>
  </tr>
</table>


<%@include file="../footer.jsp"%>