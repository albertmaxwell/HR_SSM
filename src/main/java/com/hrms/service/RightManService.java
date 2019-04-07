package com.hrms.service;

import com.hrms.bean.Department;
import com.hrms.bean.Employee;
import com.hrms.bean.RightsMan;
import com.hrms.mapper.DepartmentMapper;
import com.hrms.mapper.RightsManMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 金海洋
 * @date 2019/4/6  -11:55
 */
@Service
public class RightManService {

	@Autowired
	RightsManMapper rightsManMapper;


	public int getRightsCount(){
		return rightsManMapper.countRights();
	}

	public List<RightsMan> getRightsList(Integer offset, Integer limit){
		return rightsManMapper.selectRightsByLimitAndOffset(offset, limit);
	}

	public int updateRightsById(Integer rightsId, RightsMan rightsMan){
		return rightsManMapper.updateRightsById(rightsId, rightsMan);
	}

	public RightsMan getRightsById(Integer rightsId){
		return rightsManMapper.selectOneById(rightsId);
	}

	public int deleteRightsById(Integer rightsId){
		return rightsManMapper.deleteRightsById(rightsId);
	}

}
