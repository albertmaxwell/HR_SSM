package com.hrms.test;

import com.hrms.bean.ContractsEntity;
import com.hrms.bean.Department;
import com.hrms.service.ContractsService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * @author 金海洋
 * @date 2019/4/7  -20:27
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:springmvc.xml"})
public class ContractsMapperTest {
	@Autowired
	ContractsService contractsService;

	@Test
	public void selectConByLimitAndOffsetTest(){
		List<ContractsEntity> conList = contractsService.getConList(1,3);
		System.out.println(conList.size());
		for (int i = 0; i < conList.size(); i++) {
			System.out.println(conList.get(i));
		}
	}





}
