package com.hrms.test;

import com.hrms.bean.RightsMan;
import com.hrms.mapper.LoginMapper;
import com.hrms.mapper.RightsManMapper;
import com.hrms.service.LoginService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @author 金海洋
 * @date 2019/4/7  -14:12
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:springmvc.xml"})
public class LoginMapperTest {

	@Autowired
	private LoginService loginService;

	@Test
	public void selectOneByAPTest(){

		RightsMan rightsMan =null;
			rightsMan=loginService.getUser("test","123456");
		if(rightsMan!=null){

			System.out.println("有效用户");
		}


		}


}
