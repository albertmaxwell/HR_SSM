package com.hrms.util;

/**
 * @author 金海洋
 * @date 2019/4/14  -23:37
 */
public class ResponseMessage<T> {


	private String respCode;
	private String respMsg;
	private T data;
	private boolean ok;

	public ResponseMessage(ResponseMessageCodeEnum codeEnum, String message, boolean ok, T data) {
		this.respCode = codeEnum.getCode();
		this.respMsg = message;
		this.ok = ok;
		this.data = data;
	}






}
