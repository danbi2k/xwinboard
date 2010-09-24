<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@include file="../header.jsp"%>
			<tr><td><img src="images/menu13.jpg" border="0"></td></tr>
		
            </table>
            <table align="center" cellpadding="0" cellspacing="0" width="771" height="213">   
		    <tr>
		        <td width="680" background="images/minit_02.jpg" valign="top" style="padding:20">
		            <p>
			<div class='handicap'>
<h3>· 용어설명</h3>
<div class='box'>
	<dl>
	<dt>홈 팀</dt>
	<dd>자신의 근거지에서 경기를 치루는 팀 또는 개인.</dd>
	<dt>원정팀</dt>
	<dd>상대팀의 근거지에서 경기를 치루는 팀 이나 개인.</dd>
	<dt>Player1,Player2</dt>
	<dd>홈과 원정 구분이 없는 경기에서 각 팀이나 개인을 구분.</dd>
	<dt>핸디캡</dt>
	<dd>
	전력이 우수한 팀에게 주어지는 불리한 조건.<br>
	상대적으로 전력이 우수한 팀에게 불리한 조건을 주어 경기의 균형을 맞춤.
	</dd>
	<dt>배당율</dt>
	<dd>
	회원이 배팅한 금액에 대한 경기 종료 후 결과를 맞췄을 때 받아 가는 정산 시 이익율.<br>
	예를 들어 10,000원을 배팅했을 때 배당율이 90% 이라면 정산 후 회원은 총 19,000 원의 배당금을 수령할 수 있음을 의미함.
	</dd>
	</dl>
</div>
<h3>· 핸디캡의 종류</h3>
<div class='box'>
	<ul>
	<li>- A팀 : 핸디를 준 팀으로 가정하여 핸디를 주었다는 것은 실력이 월등한 팀을 이야기합니다.</li>
	<li>- B팀 : 핸드리르 받은 팀으로 가정하며, 핸디를 받았다는 것은 실력이 열등한 팀을 이야기 합니다.</li>
	<li>- A팀의 배당률은 90% B팀의 배당률은 100%로 가정합니다.</li>
	<li>- 핸디를 준 팀에는 핸디 앞에 "-"로 표시하고, 핸디를 받은 팀에는 핸디 앞에 "+"로 표시합니다.</li>
	<li>- 위의 4개 항목과 함께 10,000원을 배팅했을 경우 가정하여 설명합니다.</li>
	</ul>
</div>


<h3>· 0</h3>
<div class='box'>
	<table>
	<tr><th colspan="4">A팀</th><th colspan="4">B팀</th></tr>
	<tr>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
	</tr>
	<tr>
		<td rowspan="3">0</td>
		<td>승</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
		<td rowspan="3">0</td>
		<td>패</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
	</tr>
	<tr>
		<td>무</td>
		<td>N</td>
		<td>금액변화 없음</td>
		<td>무</td>
		<td>N</td>
		<td>금액 변화 없음</td>
	</tr>
	<tr>
		<td>패</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>승</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	</table>

	핸디가 0인 상태는 A팀이나 B팀간에 우열을 가릴 수 없는 박빙의 승부의 경우를 뜻하는 것으로 핸디가 없는 것입니다. 이때 경기 결과가 비겼을 경우에는 배팅한 금액을 다시 돌려 받게 되고, 경기 결과 패했을 경우에는 배팅금액 전부를 잃게 됩니다. 반대로 경기 결과 배팅한 팀이 승리했을 경우에은 배당률의 100%를 획득학 되는데, 현재의 설명에서 A팀은 배당률이 90%, B팀은 배당률이 100%로 가정했으므로, A팀에 배팅하고 A팀이 승리했을 경우에는 10,000원+9,000원(배당률이 90%이므로)=19,000원을 획득하게 되고 B팀에 배팅하고 B팀이 승리했을 경우에는 10,000원+10,000원(배당률이 100%이므로)=20,000원을 획득하게 됩니다.
</div>

<h3>· 1/2</h3>
<div class='box'>
	<table id="Table10" >
	<tr>
		<th colspan="4">A팀</th>
		<th colspan="4">B팀</th>
	</tr>
	<tr>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
	</tr>
	<tr>
		<td rowspan="3">-1/2</td>
		<td>승</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
		<td rowspan="3">+1/2</td>
		<td>패</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
	</tr>
	<tr>
		<td>무</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>무</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>패</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>승</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	</table>
A팀에 10,000원을 배팅한 상태라고 가정하므로 경기 결과 A팀이 승리 했다면, 승리 시 배당률의 100% 획득이 가능하므로, 배팅금액 10,000원 + 9,000원 = 19,000원을 획득하게 됩니다. 여기서 배당률의 100%가 9,000원인 까닭은 위에 가정한 것처럼 A 팀의 배당률이 90%로 되어 있으므로 배팅금액의 90% 인 9,000원이 배당률의 100%가 되는 것입니다. 따라서 A팀이 승리하지 못하고 무승부로 게임이 종결되었거나, 패했다면 배팅금액 전부를 잃게 됩니다. 반대로 B 팀에 배팅을 한 상태이고 경기 결과 무승부 이거나 B 팀이 승리 했다면 10,000원 + 10,000원(배당률의 100%) = 20,000원을 획득 할 수 있게 됩니다.
</div>

<h3>· 1</h3>
<div class='box'>
	<table>
	<tr>
		<th colspan="4">A팀</th>
		<th colspan="4">B팀</th>
	</tr>
	<tr>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
	</tr>
	<tr>
		<td rowspan="4">-1</td>
		<td rowspan="2">승</td>
		<td>1골차</td>
		<td>금액변화없음</td>
		<td rowspan="4">+1</td>
		<td rowspan="2">패</td>
		<td>1골차</td>
		<td>금액변화없음</td>
	</tr>
	<tr>
		<td>2골차</td>
		<td>배당률의 100% 획득</td>
		<td>2골차</td>
		<td>배팅금액의 100% 손실</td>
	</tr>
	<tr>
		<td>무</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>무</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>패</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>승</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	</table>
A팀에 10,000원을 배팅한 상태라고 가정하고 경기 결과 A팀이 승리 했다면, 골득실을 따져서 배당금액에 차이가 생깁니다. 1골 차 라는 것은 A팀:B팀 경기 결과가 1:0 이거나 2:1, 3:2 처럼 한 점차로 A팀이 B팀을 꺾고 승리 했을 경우를 말합니다. 이때는 배당금액을 획득하거나 배팅금액에 손실이 발생하지 않고, 배팅했던 금액을 그대로 다시 돌려 받게 됩니다. 즉, 금액 변화가 없습니다. 2골 차 라는 것은 앞서 설명한 1골 차와 같은 경우라고 보시면 되며, A 팀이 B 팀보다 2점 앞서 승리하면 배당률의 100%를 획득하게 되어 10,000원 + 9,000원 = 19,000원을 획득하게 됩니다. 여기서 배당률의 100%가 9,000원인 까닭은 위에 가정한 것처럼 A 팀의 배당률이 90%로 되어 있으므로 배팅금액의 90% 인 9,000원이 배당률의 100%가 되기 때문입니다. 따라서 A팀이 승리하지 못하고 무승부로 게임이 종결되었거나, 패했다면 배팅금액 전부를 잃게 됩니다. 반대로 B 팀에 배팅을 한 상태이고 경기 결과 무승부 이거나 B 팀이 승리 했다면 10,000원 + 10,000원(배당률의 100%) = 20,000원을 획득하게 되고, B 팀이 패배 했다 하더라도 1골 차 패배라면 배팅했던 금액에 변화가 생기지 않고 다시 돌려 받게 됩니다. B팀이 A 팀에게 2점 차 이상의 점수로 패배했을 경우에만 배팅금액 전부를 잃게 됩니다.
</div>


<h3>· 1&frac12;</h3>
<div class='box'>
	<table id="Table20" >
	<tr>
		<th colspan="4">A팀</th>
		<th colspan="4">B팀</th>
	</tr>
	<tr>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
	</tr>
	<tr>
		<td rowspan="4">-1&frac12;</td>
		<td rowspan="2">승</td>
		<td>1골차</td>
		<td>배팅금액의 100% 손실</td>
		<td rowspan="4">+1&frac12;</td>
		<td rowspan="2">패</td>
		<td>1골차</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>2골차</td>
		<td>배당률의 100% 획득</td>
		<td>2골차</td>
		<td>배팅금액의 100% 손실</td>
	</tr>
	<tr>
		<td>무</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>무</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>패</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>승</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	</table>

A팀에 10,000원을 배팅한 상태라고 가정하고 경기 결과 A팀이 승리 했다면, 골득실을 따져서 배당금액에 차이가 생깁니다. 1골 차 라는 것은 A팀:B팀 경기 결과가 1:0 이거나 2:1, 3:2 처럼 한 점차로 A팀이 B팀을 꺾고 승리 했을 경우를 말합니다. 이때는 배팅한 금액의 100%인 10,000원 전부를 잃게 됩니다. 2골 차 라는 것은 앞서 설명한 1골 차와 같은 경우라고 보시면 되며, A 팀이 B 팀보다 2점 앞서 승리하면 배당률의 100%를 획득하게 되어 10,000원 + 9,000원 = 19,000원을 획득하게 됩니다. 여기서 배당률의 100%가 9,000원인 까닭은 위에 가정한 것처럼 A 팀의 배당률이 90%로 되어 있으므로 배팅금액의 90% 인 9,000원이 배당률의 100%가 되기 때문입니다. 따라서 A팀이 승리하지 못하고 무승부로 게임이 종결되었거나, 패했다면 배팅금액 전부를 잃게 되고, 승리 하였다 하더라도 2골 차 이상의 차이로 승리하지 못했다면 배팅금액인 10,000원 전부를 잃게 됩니다. 반대로 B 팀에 배팅을 한 상태이고 경기 결과 무승부 이거나 B 팀이 승리 했다면 10,000원 + 10,000원(배당률의 100%) = 20,000원을 획득하게 되고, B 팀이 패배 했다 하더라도 1골 차 패배라면 배당률의 100%를 획득하게 되어 10,000원 + 10,000원(배당률의 100%) = 20,000원을 획득하게 됩니다. 즉 B팀이 A 팀에게 2점 차 이상의 점수로 패배했을 경우에만 배팅금액을 잃게 되고, 그 이외의 경우에는 배당률의 100%를 획득하게 됩니다.
</div>

<h3>· 2</h3>
<div class='box'>
	<table id="Table24" >
	<tr>
		<th colspan="4">A팀</th>
		<th colspan="4">B팀</th>
	</tr>
	<tr>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
	</tr>
	<tr>
		<td rowspan="5">-2</td>
		<td rowspan="3">승</td>
		<td>1골차</td>
		<td>배팅금액의 100% 손실</td>
		<td rowspan="5">+2</td>
		<td rowspan="3">패</td>
		<td>1골차</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>2골차</td>
		<td>금액변화없음</td>
		<td>2골차</td>
		<td>금액변화없음</td>
	</tr>
	<tr>
		<td>3골차</td>
		<td>배당률의 100% 획득</td>
		<td>3골차</td>
		<td>배팅금액의 100% 손실</td>
	</tr>
	<tr>
		<td>무</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>무</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>패</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>승</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	</table>
</div>

<h3>· 2&frac12;</h3>
<div class='box'>
	<table>
	<tr>
		<th colspan="4">A팀</th>
		<th colspan="4">B팀</th>
	</tr>
	<tr>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
	</tr>
	<tr>
		<td rowspan="5">-2&frac12;</td>
		<td rowspan="3">승</td>
		<td>1골차</td>
		<td>배팅금액의 100% 손실</td>
		<td rowspan="5">+2&frac12;</td>
		<td rowspan="3">패</td>
		<td>1골차</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>2골차</td>
		<td>배팅금액의 100% 손실</td>
		<td>2골차</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>3골차</td>
		<td>배당률의 100% 획득</td>
		<td>3골차</td>
		<td>배팅금액의 100% 손실</td>
	</tr>
	<tr>
		<td>무</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>무</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>패</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>승</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	</table>
</div>


<h3>· 3</h3>
<div class='box'>
	<table>
	<tr>
		<th colspan="4">A팀</th>
		<th colspan="4">B팀</th>
	</tr>
	<tr>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
	</tr>
	<tr>
		<td rowspan="5">-3</td>
		<td rowspan="3">승</td>
		<td>2골이하</td>
		<td>배팅금액의 100% 손실</td>
		<td rowspan="5">+3</td>
		<td rowspan="3">패</td>
		<td>2골이하</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>3골차</td>
		<td>금액변화없음</td>
		<td>3골차</td>
		<td>금액변화없음</td>
	</tr>
	<tr>
		<td>4골차</td>
		<td>배당률의 100% 획득</td>
		<td>4골차</td>
		<td>배팅금액의 100% 손실</td>
	</tr>
	<tr>
		<td>무</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>무</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>패</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>승</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	</table>
</div>


<h3>· 3&frac12;</h3>
<div class='box'>
	<table>
	<tr>
		<th colspan="4">A팀</th>
		<th colspan="4">B팀</th>
	</tr>
	<tr>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
	</tr>
	<tr>
		<td rowspan="5">-3&frac12;</td>
		<td rowspan="3">승</td>
		<td>2골이하</td>
		<td>배팅금액의 100% 손실</td>
		<td rowspan="5">+3&frac12;</td>
		<td rowspan="3">패</td>
		<td>2골이하</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>3골차</td>
		<td>배팅금액의 100% 손실</td>
		<td>3골차</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>4골차</td>
		<td>배당률의 100% 획득</td>
		<td>4골차</td>
		<td>배팅금액의 100% 손실</td>
	</tr>
	<tr>
		<td>무</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>무</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>패</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>승</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	</table>
</div>


<h3>· 4</h3>
<div class='box'>
	<table>
	<tr>
		<th colspan="4">A팀</th>
		<th colspan="4">B팀</th>
	</tr>
	<tr>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
		<td>핸디</td>
		<td>결과</td>
		<td>골득실</td>
		<td>설명</td>
	</tr>
	<tr>
		<td rowspan="5">-4</td>
		<td rowspan="3">승</td>
		<td>3골이하</td>
		<td>배팅금액의 100% 손실</td>
		<td rowspan="5">+4</td>
		<td rowspan="3">패</td>
		<td>3골이하</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>4골차</td>
		<td>금액변화없음</td>
		<td>4골차</td>
		<td>금액변화없음</td>
	</tr>
	<tr>
		<td>5골차</td>
		<td>배당률의 100% 획득</td>
		<td>5골차</td>
		<td>배팅금액의 100% 손실</td>
	</tr>
	<tr>
		<td>무</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>무</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	<tr>
		<td>패</td>
		<td>N</td>
		<td>배팅금액의 100% 손실</td>
		<td>승</td>
		<td>N</td>
		<td>배당률의 100% 획득</td>
	</tr>
	</table>
4&frac12; 부터 20 까지는 4&frac12;, 5, 5&frac12;, 6 ~ 20 형태로 핸디가 적용되며, 내용은 위에 설명한 핸디를 보시면 이해가 빠릅니다.
</div>
</div>
					</p>
		        </td>
		    </tr>
		</table>


<%@include file="../footer.jsp"%>