function goMemberDetail(id)
{
	var encoded = encodeURIComponent(id);
	location.href = "adminMember.aspx?mode=viewMemberDetail&userId=" + encoded;
}