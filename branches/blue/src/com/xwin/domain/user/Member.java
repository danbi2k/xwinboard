package com.xwin.domain.user;

import java.util.Date;

import com.xwin.domain.XwinObject;
import com.xwin.infra.util.XwinUtil;

public class Member extends XwinObject
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -114855944700551224L;
	
	private String id;
	private String userId;
	private String nickName;
	private String password;
	private String mobile;
	private String email;
	private String pin;
	private Long balance;
	private Long point;
	private String status;
	private String grade;
	private Date joinDate;
	private Date secedeDate;
	private String joinDateStr;
	private String bankName;
	private String bankNumber;
	private String bankOwner;
	private Date bankDate;
	private String getSms;
	private Integer denyrity;
	private Date loginDate;
	private Date bettingDate;
	private String introducerId;
	private Integer introLetter;
	private String note;
	
	private Integer introduceCount;
	private Integer introduceBettingCount;
	private Long introduceBettingMoney;
	private Long introduceBettingPoint;
	
	private Long moneyInSum;
	private Long moneyOutSum;
	private Long bettingSum;
	private Long profit;
	
	private Date boardDenyDate;
	private Date qnaDenyDate;
	
	private String passwordExpire;
	
	private Integer memberId;
	private Integer joinBonus;
	
	private String loginIpAddress;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPin() {
		return pin;
	}
	public void setPin(String pin) {
		this.pin = pin;
	}
	public Long getBalance() {
		return balance;
	}
	public void setBalance(Long balance) {
		this.balance = balance;
	}
	public Long getPoint() {
		return point;
	}
	public void setPoint(Long point) {
		this.point = point;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
		this.joinDateStr = XwinUtil.toDateStr(joinDate, 1);
	}
	public String getJoinDateStr() {
		return joinDateStr;
	}
	public void setJoinDateStr(String joinDateStr) {
		this.joinDateStr = joinDateStr;
	}
	public Date getSecedeDate() {
		return secedeDate;
	}
	public void setSecedeDate(Date secedeDate) {
		this.secedeDate = secedeDate;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankNumber() {
		return bankNumber;
	}
	public void setBankNumber(String bankNumber) {
		this.bankNumber = bankNumber;
	}
	public String getBankOwner() {
		return bankOwner;
	}
	public void setBankOwner(String bankOwner) {
		this.bankOwner = bankOwner;
	}
	public Date getBankDate() {
		return bankDate;
	}
	public void setBankDate(Date bankDate) {
		this.bankDate = bankDate;
	}
	public String getIntroducerId() {
		return introducerId;
	}
	public void setIntroducerId(String introducerId) {
		this.introducerId = introducerId;
	}
	public Integer getIntroLetter() {
		return introLetter;
	}
	public void setIntroLetter(Integer introLetter) {
		this.introLetter = introLetter;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public Integer getIntroduceCount() {
		return introduceCount;
	}
	public void setIntroduceCount(Integer introduceCount) {
		this.introduceCount = introduceCount;
	}
	public Integer getIntroduceBettingCount() {
		return introduceBettingCount;
	}
	public void setIntroduceBettingCount(Integer introduceBettingCount) {
		this.introduceBettingCount = introduceBettingCount;
	}
	public Long getIntroduceBettingMoney() {
		return introduceBettingMoney;
	}
	public void setIntroduceBettingMoney(Long introduceBettingMoney) {
		this.introduceBettingMoney = introduceBettingMoney;
	}
	public Long getIntroduceBettingPoint() {
		return introduceBettingPoint;
	}
	public void setIntroduceBettingPoint(Long introduceBettingPoint) {
		this.introduceBettingPoint = introduceBettingPoint;
	}
	public String getGetSms() {
		return getSms;
	}
	public void setGetSms(String getSms) {
		this.getSms = getSms;
	}
	public Integer getDenyrity() {
		return denyrity;
	}
	public void setDenyrity(Integer denyrity) {
		this.denyrity = denyrity;
	}
	public Date getLoginDate() {
		return loginDate;
	}
	public void setLoginDate(Date loginDate) {
		this.loginDate = loginDate;
	}
	public Date getBettingDate() {
		return bettingDate;
	}
	public void setBettingDate(Date bettingDate) {
		this.bettingDate = bettingDate;
	}
	public Long getMoneyInSum() {
		return moneyInSum;
	}
	public void setMoneyInSum(Long moneyInSum) {
		this.moneyInSum = moneyInSum;
	}
	public Long getMoneyOutSum() {
		return moneyOutSum;
	}
	public void setMoneyOutSum(Long moneyOutSum) {
		this.moneyOutSum = moneyOutSum;
	}
	public Long getBettingSum() {
		return bettingSum;
	}
	public void setBettingSum(Long bettingSum) {
		this.bettingSum = bettingSum;
	}
	public Long getProfit() {
		return profit;
	}
	public void setProfit(Long profit) {
		this.profit = profit;
	}
	public Date getBoardDenyDate() {
		return boardDenyDate;
	}
	public void setBoardDenyDate(Date boardDenyDate) {
		this.boardDenyDate = boardDenyDate;
	}
	public Date getQnaDenyDate() {
		return qnaDenyDate;
	}
	public void setQnaDenyDate(Date qnaDenyDate) {
		this.qnaDenyDate = qnaDenyDate;
	}
	public String getPasswordExpire() {
		return passwordExpire;
	}
	public void setPasswordExpire(String passwordExpire) {
		this.passwordExpire = passwordExpire;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public Integer getJoinBonus() {
		return joinBonus;
	}
	public void setJoinBonus(Integer joinBonus) {
		this.joinBonus = joinBonus;
	}
	public String getLoginIpAddress() {
		return loginIpAddress;
	}
	public void setLoginIpAddress(String loginIpAddress) {
		this.loginIpAddress = loginIpAddress;
	}
}
