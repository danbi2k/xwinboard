function goMemberDetail(id)
{
	var encoded = encodeURIComponent(id);
	location.href = "adminMember.aspx?mode=viewMemberDetail&userId=" + encoded;
}

function goDealerDetail(id)
{
	var encoded = encodeURIComponent(id);
	location.href = "adminDealer.aspx?mode=viewDealerDetail&dealerId=" + encoded;
}