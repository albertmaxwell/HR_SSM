package com.hrms.Vo;

import java.math.BigDecimal;

/**
 * @author 金海洋
 * @date 2019/4/13  -10:01
 */
public class MapVo {

	private BigDecimal enterNumber; //入数量
	private BigDecimal outNumber; //出数量
	private String city; //城市

	public BigDecimal getEnterNumber() {
		return enterNumber;
	}
	public void setEnterNumber(BigDecimal enterNumber) {
		this.enterNumber = enterNumber;
	}
	public BigDecimal getOutNumber() {
		return outNumber;
	}
	public void setOutNumber(BigDecimal outNumber) {
		this.outNumber = outNumber;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}


}
