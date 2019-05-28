package com.hrms.service;

import com.hrms.Vo.CitySwallListVo;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author 金海洋
 * @date 2019/4/14  -23:27
 */
public interface SearchDateService {

	/**
	 * 近N月分数据报表查询
	 *
	 * @param params 参数条件
	 * @return
	 * @throws Exception
	 */
	public List<CitySwallListVo> queryNumber(Map<String, Object> params) throws Exception;


}
