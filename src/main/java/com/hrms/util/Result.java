package com.hrms.util;

/**
 * @author 金海洋
 * @date 2019/4/14  -23:38
 */
public class Result {

	private static final ResponseMessage RESPONSE_MESSAGE_SUCCESS = new ResponseMessage(ResponseMessageCodeEnum.SUCCESS, "成功", true, null);

	public static ResponseMessage success() {
		return RESPONSE_MESSAGE_SUCCESS;
	}


	public static <T> ResponseMessage<T> success(T t) {
		return new ResponseMessage(ResponseMessageCodeEnum.SUCCESS, "成功", true, t);
	}


	public static ResponseMessage error() {
		return error("失败");
	}

	public static ResponseMessage error(String message) {
		return error(ResponseMessageCodeEnum.ERROR, message);
	}

	public static ResponseMessage error(ResponseMessageCodeEnum codeEnum, String message) {
		return error(codeEnum, message, null);
	}

	public static <T> ResponseMessage<T> error(ResponseMessageCodeEnum codeEnum, String message, T t) {
		return new ResponseMessage(codeEnum, message, false, t);
	}






}
