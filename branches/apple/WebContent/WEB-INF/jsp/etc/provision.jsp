<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@include file="../header.jsp"%>
<div class='sub_ti1'>
		<img src='./img/sub_prov_ti.gif' alt='이용약관' class='ml10 mr10 fl'>
		<div class='sub_ti_desc'>· 이용약관 입니다.</div>
		<div class='state_bar'>
			<div class='state_bar_txt'>
			<span class='name'><%=member.getNickName()%></span> 님
			<span class='cash'>· Cash:<span class='val'><%=XwinUtil.comma3(member.getBalance())%></span></span> 
			<span class='apple'>· Apple:<span class='val'><%=XwinUtil.comma3(member.getPoint())%></span></span> 
			<!-- span class='link'><a href='myBet.aspx?mode=viewMyBettingList'>배팅내역보기</a></span -->
			</div>
		</div>
		<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='provision'>
			<ol>
				<li>
							배팅은 1~10경기까지 조합을 할 수 있다. <br>
							선택한 경기를 모두 맞힌 경우에만 배당금을 지급 하며, 배당금은 배당률과 배팅금액을 곱하여 계산한다. (소수점 3자리 이하 절사)
				</li>
				<li>
							공지된 배당률은 사항에 따라 변동될 수 있다. 배당률은 경기결과에 영향을 미칠 수 있는(주요 선수의 부상 및 결장)등 여러 가 지 예기치 못한 변수에 의해서 변경되며, 배당률이 변경될 경우 변경시점 이전에 배팅은 변경이전 배당률로 그대로 적용 받는다.
				</li>
				<li>
							특정조합에 지나치게 배팅이 집중될 경우 배팅을 차단할 수 있다.
				</li>
				<li>
							배팅한 경기중 취소된 경기는 배당률을 모두 1.0배로 처리하며, <br>
							선택한 경기 중 한 경기라도 결과가 확정 되었을 경우 그 배팅은 유효하게 처리된다. <br>
							단, 선택한 경기가 모두 취소가 되었을 경우는 환불한다. 
				</li>
				<li>
							대상경기 시간은 정규 경기시간까지의 결과를 적용한다. <br>
							축구 - 전/후반까지의 결과 적용(연장전 및 승부차기 제외)	
				</li>
				<li>
							마감시각은 한국시각을 기준으로 배팅은 경기시작 10분전에 순서와 시간별로 마감하며, 기타 운영상의 사유에 따라 변경될 수 있다.
				</li>
				<li>
							회원은 자신에 배팅캐쉬를 24시간 언제든지 인출을 요구할 수 있으며, 회사는 이러한 일들을 신속하게 처리할 것이다.
				</li>
				<li>
							배팅금제한(최저 1,000부터/최고 100만원)내에서 배팅이 가능하며 배팅상한선을 초과 배팅 할 경우 배팅이 제한된다.<br>
							최대 예상배당금은 300만원이며, 이를 초과할 경우 배팅이 제한된다. 
				</li>
				<li>
							배팅카트 내용을 확인하고 정상적으로 구매되었다면, 취소되거나 변경되지 않는다.<br>
							회원은 구매전 배팅카트의 내용을 다시 한번 확인하고, 구매후 구매가 정상적으로 완료 되었는지 확인한다.
				</li>
				<li>
							회사는 일부 악의 적인 회원에 대해 언제든지 계정을 취소 또는 정지 시킬 수 있는 권리가 있으며, 이때 보유 캐쉬는 모두 소진될 것이다.<br>
							그러나 회원 스스로 회원 자격을 버릴 경우 자신의 보유 캐쉬를 언제든지 신청하여 인출 할 수 있다.
				</li>
				<li>
							회사는 어떠한 정보통신 문제 때문에 발생되는 배팅 실패에 대한 책임은 지지 않는다.
				</li>
				<li>
							시스템 및 전산장비의 오류로 인하여 불가피하게 실수가 생기면 회사는 이를 변경, 취소할 권리를 갖는다.<br>
							배팅 및 정산과 관련된 일련의 모든 계산이 잘못된 부분이 있다면, 회원은 이를 회사에 즉시 알려야 할 책임이 있다.<br>
							회사에 알리지 않아 발생되는 회원의 손해를 회사는 책임지지 않는다.
				</li>
			</ol>
			</div>
		</div>
		<!-- sub_content1 -->
<%@include file="../footer.jsp"%>