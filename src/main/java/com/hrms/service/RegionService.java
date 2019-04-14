package com.hrms.service;

import com.hrms.bean.Department;
import com.hrms.bean.RegionEntity;
import com.hrms.mapper.PCAMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 金海洋
 * @date 2019/4/8  -16:24
 */
@Service
public class RegionService {

	@Autowired
	PCAMapper pcaMapper;


	public List<RegionEntity> getRegName(String pid){
		return pcaMapper.selectRegList(pid);
	}


}
