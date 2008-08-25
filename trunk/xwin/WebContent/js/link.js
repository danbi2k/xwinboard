var link_url=new Array();
link_url[0]="/usr/game_list.asp?s_game_type=1";
link_url[1]="/usr/game_result.asp";
link_url[2]="/usr/bet_rule.asp";
link_url[3]="/usr/bet_handi.asp";
link_url[4]="/usr/board.asp";
link_url[5]="/usr/cust_qna.asp";
link_url[6]="/usr/game_list.asp?s_game_type=2";

function go_link(num)
{
	location.href=link_url[num];
}