package com.hrms.Vo;

import java.math.BigDecimal;

/**
 * @author 金海洋
 * @date 2019/4/14  -23:25
 */
public class CitySwallListVo {

	//进货量
	private BigDecimal intoNumber;
	//出货量
	private BigDecimal outToNumber;
	//吞吐量
	private BigDecimal intoOrOutNumber;
	//时间
	private String times;
	//最大吞吐量间距
	private int yAxis;


	public BigDecimal getIntoNumber() {
		return intoNumber;
	}

	public void setIntoNumber(BigDecimal intoNumber) {
		this.intoNumber = intoNumber;
	}

	public BigDecimal getOutToNumber() {
		return outToNumber;
	}

	public void setOutToNumber(BigDecimal outToNumber) {
		this.outToNumber = outToNumber;
	}

	public BigDecimal getIntoOrOutNumber() {
		return intoOrOutNumber;
	}

	public void setIntoOrOutNumber(BigDecimal intoOrOutNumber) {
		this.intoOrOutNumber = intoOrOutNumber;
	}

	public String getTimes() {
		return times;
	}

	public void setTimes(String times) {
		this.times = times;
	}

	public int getyAxis() {
		return yAxis;
	}

	public void setyAxis(int yAxis) {
		this.yAxis = yAxis;
	}


}
