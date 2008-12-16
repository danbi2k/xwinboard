package com.xwin.infra.util;

import com.xwin.domain.user.Member;

public class AccessUtil
{
	public static boolean checkDeny(Member member, Integer denyItem)
	{
		Integer denyrity = member.getDenyrity();
		
		if ((denyItem & denyrity) > 0)
			return true;
		
		return false;
	}
}
