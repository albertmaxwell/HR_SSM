package com.hrms.test;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.hrms.bean.RegionEntity;
import com.hrms.mapper.PCAMapper;
import com.hrms.service.RegionService;
import org.apache.ibatis.jdbc.Null;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * @author 金海洋
 * @date 2019/4/8  -15:02
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:springmvc.xml"})
public class CommonMapperTest {

	@Autowired
	RegionService regionService;

	@Test
	public void citySelect() {

		List<RegionEntity> mapList = regionService.getRegName("1");
		System.out.println(mapList.toString());

	}
}
