package com.hrms.Vo;

import java.math.BigDecimal;

/**
 * @author 金海洋
 * @date 2019/4/13  -10:01
 */
public class DistributeVo {

	private String name; //名称
	private BigDecimal value; //值

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public BigDecimal getValue() {
		return value;
	}
	public void setValue(BigDecimal value) {
		this.value = value;
	}

}
