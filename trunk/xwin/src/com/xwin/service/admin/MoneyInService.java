package com.xwin.service.admin;

import java.util.Date;
import java.util.List;

import com.xwin.domain.admin.Account;
import com.xwin.domain.comm.KtfSmsMessage;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.MoneyIn;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XwinUtil;

public class MoneyInService extends XwinService
{
	public Integer processMoneyIn(String moneyInId)
	{
		MoneyIn moneyIn = moneyInDao.selectMoneyIn(moneyInId);		
		Member member = memberDao.selectMember(moneyIn.getUserId(), null);		
		return processMoneyIn(moneyIn, Code.MONEY_IN_SUCCESS, member);
	}
	
	public void processMoneyInAuto() throws Exception
	{
		List<MoneyIn> moneyInList = moneyInDao.selectMoneyInList(null, Code.MONEY_IN_REQUEST);
		if (moneyInList != null) {
			for (MoneyIn moneyIn : moneyInList) {
				String name = moneyIn.getName();
				String money = XwinUtil.comma3(moneyIn.getMoney());	
				
				List<KtfSmsMessage> ktfSmsMessageList = ktfSmsDao.searchAssociateWitnMoneyIn(name, money);
				
				if (ktfSmsMessageList != null && ktfSmsMessageList.size() == 1) {
					KtfSmsMessage ktfSmsMessage = ktfSmsMessageList.get(0);		

					Member member = memberDao.selectMember(moneyIn.getUserId(), null);
					int result = processMoneyIn(moneyIn, Code.MONEY_IN_SUCCESS, member);
					if (result == 0) {
						ktfSmsDao.updateStatus(ktfSmsMessage.getId(), Code.MONEY_IN_SUCCESS);
						String nickName = member.getNickName();
						String mobile = member.getMobile().replaceAll("-", "");
						String message = nickName + " 님께 " + money + "원이 충전 되었습니다. -bwin-";
						sendSmsConnector.sendSms(message, mobile, "0000000000");
					}
				}
			}
		}
	}
	
	private Integer processMoneyIn(MoneyIn moneyIn, String moneyInStatus, Member member)
	{
		if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)) {
			
			Account account = new Account();
			account.setUserId(member.getUserId());
			account.setType(Code.ACCOUNT_TYPE_MONEYIN);
			account.setDate(new Date());
			account.setOldBalance(member.getBalance());
			account.setMoney(moneyIn.getMoney());
			account.setBalance(member.getBalance() + moneyIn.getMoney());
			account.setMoneyInId(moneyIn.getId());			
			
			moneyIn.setStatus(moneyInStatus);
			moneyIn.setProcDate(new Date());
			
			//포인트 지급
			Double point = moneyIn.getMoney() * 0.05;			
			memberDao.plusMinusPoint(member.getUserId(), point.longValue());
			
			accountDao.insertAccount(account);
			moneyInDao.updateMoneyIn(moneyIn);			
			memberDao.plusMinusBalance(member.getUserId(), moneyIn.getMoney());
			
			return 0;
		}
		
		return -1;
	}
}
