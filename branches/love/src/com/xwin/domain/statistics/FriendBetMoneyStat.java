package com.xwin.domain.statistics;

import com.xwin.domain.XwinObject;

public class FriendBetMoneyStat extends XwinObject
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8980561732832704248L;
	
	private String userId;
	private Long betMoneySum;
	private Long betCount;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Long getBetMoneySum() {
		return betMoneySum;
	}
	public void setBetMoneySum(Long betMoneySum) {
		this.betMoneySum = betMoneySum;
	}
	public Long getBetCount() {
		return betCount;
	}
	public void setBetCount(Long betCount) {
		this.betCount = betCount;
	}
}
