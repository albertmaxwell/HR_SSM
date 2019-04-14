package com.hrms.service;

import com.hrms.Vo.CockpitVo;
import org.springframework.stereotype.Service;

/**
 * @author 金海洋
 * @date 2019/4/13  -10:03
 */

public interface CountService {

	/**
	 * 平台运营驾驶舱报表数据查询
	 * @param vo
	 * @return
	 */
	public CockpitVo queryCockpit(CockpitVo vo);




}
