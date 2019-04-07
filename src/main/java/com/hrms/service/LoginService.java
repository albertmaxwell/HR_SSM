package com.hrms.service;

import com.hrms.bean.RightsMan;
import com.hrms.mapper.DepartmentMapper;
import com.hrms.mapper.LoginMapper;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 金海洋
 * @date 2019/4/7  -13:36
 */
@Service
public class LoginService {
	@Autowired
	LoginMapper loginMapper;

	public RightsMan getUser(String rightsAccount,String rightsPassword){
		return loginMapper.checkUser(rightsAccount,rightsPassword);
	}



}
