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
		return processMoneyIn(moneyInId, Code.MONEY_IN_SUCCESS);
	}
	
	public void processMoneyInAuto()
	{
		List<MoneyIn> moneyInList = moneyInDao.selectMoneyInList(null, Code.MONEY_IN_REQUEST);
		if (moneyInList != null) {
			for (MoneyIn moneyIn : moneyInList) {
				String name = moneyIn.getName();
				String money = XwinUtil.comma3(moneyIn.getMoney());
				
				List<KtfSmsMessage> ktfSmsMessageList = ktfSmsDao.searchAssociateWitnMoneyIn(name, money);
				
				if (ktfSmsMessageList != null && ktfSmsMessageList.size() == 1) {
					KtfSmsMessage ktfSmsMessage = ktfSmsMessageList.get(0);
					processMoneyIn(moneyIn.getId(), Code.MONEY_IN_SUCCESS);
					ktfSmsDao.updateStatus(ktfSmsMessage.getId(), Code.MONEY_IN_SUCCESS);
				}
			}
		}
	}
	
	private Integer processMoneyIn(String moneyInId, String moneyInStatus)
	{
		MoneyIn moneyIn = moneyInDao.selectMoneyIn(moneyInId);
		
		if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)) {
			Member member = memberDao.selectMember(moneyIn.getUserId(), null);
			
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
			
			accountDao.insertAccount(account);
			moneyInDao.updateMoneyIn(moneyIn);			
			memberDao.plusMinusBalance(member.getUserId(), moneyIn.getMoney());
			
			return 0;
		}
		
		return -1;
	}
}
