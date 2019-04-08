package com.hrms.test;

import com.hrms.bean.Department;
import com.hrms.bean.Employee;
import com.hrms.bean.RightsMan;
import com.hrms.mapper.RightsManMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**c
 * @author 金海洋
 * @date 2019/4/6  -22:36
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:springmvc.xml"})
public class RightsManMapperTest {

	@Autowired
	private RightsManMapper rightsManMapper;

	@Test
	public void selectRightsByLimitAndOffsetTest(){
		List<RightsMan> rightsManList = rightsManMapper.selectRightsByLimitAndOffset(1,3);
		System.out.println(rightsManList.size());
		for (int i = 0; i < rightsManList.size(); i++) {
			System.out.println(rightsManList.get(i));
		}
	}

	@Test
	public void updateRightsTest(){
		RightsMan rightsMan = new RightsMan(3, "马云", "test","123456");
		int res = rightsManMapper.updateRightsById(3, rightsMan);
		System.out.println(res);
	}

	@Test
	public void selectOneByIdTest(){
		RightsMan rightsMan = rightsManMapper.selectOneById(1);
		System.out.println(rightsMan);
	}

	@Test
	public void deleteRightsTest(){
		int res = rightsManMapper.deleteRightsById(1);
		System.out.println(res);
	}

	@Test
	public void insertRightsTest(){
		RightsMan rightsMan = new RightsMan(1, "2", "2","2");
		int res = rightsManMapper.insertRights(rightsMan);
		System.out.println(res);
	}



}
