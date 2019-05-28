package com.hrms.util;

/**
 * @author 金海洋
 * @date 2019/4/14  -23:39
 */
public enum ResponseMessageCodeEnum {
	SUCCESS("0"),
	ERROR("-1"),
	VALID_ERROR("1000"),//校验失败
	SAVE_SUCCESS("r0001"),
	UPDATE_SUCCESS("r0002"),
	REMOVE_SUCCESS("r0003");

	private String code;

	ResponseMessageCodeEnum(String code) {
		this.code = code;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}
