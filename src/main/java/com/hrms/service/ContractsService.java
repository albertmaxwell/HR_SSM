package com.hrms.service;

import com.hrms.bean.ContractsEntity;
import com.hrms.bean.Department;
import com.hrms.mapper.ContractsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 金海洋
 * @date 2019/4/7  -20:04
 */
@Service
public class ContractsService {

	@Autowired
	ContractsMapper contractsMapper;

	public List<ContractsEntity> getConList(Integer offset, Integer limit){
		return contractsMapper.selectConByLimitAndOffset(offset, limit);
	};

	public int getConCount(){
		return contractsMapper.countCon();
	}






}
