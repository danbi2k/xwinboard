package com.xwin.web.command;

public class MemberCommand
{
	private String id;
	private String nick;
	private String phone;
	private String email;
	private String pw;
	private String out_pw;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getOut_pw() {
		return out_pw;
	}
	public void setOut_pw(String out_pw) {
		this.out_pw = out_pw;
	}
}
