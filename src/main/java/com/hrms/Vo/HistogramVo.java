package com.hrms.Vo;

import java.math.BigDecimal;

/**
 * @author 金海洋
 * @date 2019/4/12  -18:48
 */
public class HistogramVo {

	private String time; //时间
	private BigDecimal enter; //入
	private BigDecimal out; //出
	private BigDecimal hap; //吞吐

	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public BigDecimal getEnter() {
		return enter;
	}
	public void setEnter(BigDecimal enter) {
		this.enter = enter;
	}
	public BigDecimal getOut() {
		return out;
	}
	public void setOut(BigDecimal out) {
		this.out = out;
	}
	public BigDecimal getHap() {
		return hap;
	}
	public void setHap(BigDecimal hap) {
		this.hap = hap;
	}


}
