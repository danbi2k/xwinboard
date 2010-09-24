package com.xwin.domain.user;

import com.xwin.domain.admin.BankBook;

public class MoneyIn extends MoneyInOut
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3190890850152657381L;
	
	private String bankBookId;
	private BankBook bankBook;
	
	public String getBankBookId() {
		return bankBookId;
	}
	public void setBankBookId(String bankBookId) {
		this.bankBookId = bankBookId;
	}
	public BankBook getBankBook() {
		return bankBook;
	}
	public void setBankBook(BankBook bankBook) {
		this.bankBook = bankBook;
	}
}
