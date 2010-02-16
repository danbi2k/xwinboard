package com.xwin.web.command;

import com.xwin.domain.XwinObject;

public class Indicator extends XwinObject
{
	private static final long serialVersionUID = 342941896703700802L;
	
	private String chargingIndi;
	private String exchangeIndi;
	private String centerIndi;
	private String vipIndi;
	private String hackingIndi;
	private String wdlIndi;
	private String handyIndi;
	private String overUnderWarn;
	
	public String getChargingIndi() {
		return chargingIndi;
	}
	public void setChargingIndi(String chargingIndi) {
		this.chargingIndi = chargingIndi;
	}
	public String getExchangeIndi() {
		return exchangeIndi;
	}
	public void setExchangeIndi(String exchangeIndi) {
		this.exchangeIndi = exchangeIndi;
	}
	public String getCenterIndi() {
		return centerIndi;
	}
	public void setCenterIndi(String centerIndi) {
		this.centerIndi = centerIndi;
	}
	public String getVipIndi() {
		return vipIndi;
	}
	public void setVipIndi(String vipIndi) {
		this.vipIndi = vipIndi;
	}
	public String getHackingIndi() {
		return hackingIndi;
	}
	public void setHackingIndi(String hackingIndi) {
		this.hackingIndi = hackingIndi;
	}
	public String getWdlIndi() {
		return wdlIndi;
	}
	public void setWdlIndi(String wdlIndi) {
		this.wdlIndi = wdlIndi;
	}
	public String getHandyIndi() {
		return handyIndi;
	}
	public void setHandyIndi(String handyIndi) {
		this.handyIndi = handyIndi;
	}
	public String getOverUnderWarn() {
		return overUnderWarn;
	}
	public void setOverUnderWarn(String overUnderWarn) {
		this.overUnderWarn = overUnderWarn;
	}
}
