package com.hrms.service;

import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author 金海洋
 * @date 2019/4/16  -12:39
 */
public interface ICommonService {

	/**
	 * 通过JDBC查找对象集合 使用指定的检索标准检索数据返回数据
	 */
	public Map<String, Object> findOneForJdbc(String sql, Object... objs);

}
