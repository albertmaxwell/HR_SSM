package com.hrms.util;

/**
 * @author 金海洋
 * @date 2019/4/14  -14:43
 */
public class JsonMessage {

	private Object obj = null;// 其他信息
	private boolean success = true;// 是否成功
	private String msg = "操作成功";// 提示信息


	public void setObj(Object obj) {
		this.obj = obj;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getObj() {
		return obj;
	}





}
