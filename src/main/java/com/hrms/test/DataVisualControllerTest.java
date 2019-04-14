package com.hrms.test;

import com.hrms.Vo.CockpitVo;
import com.hrms.service.CountService;
import com.hrms.util.JsonMsg;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 * @author 金海洋
 * @date 2019/4/13  -13:18
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:springmvc.xml"})
public class DataVisualControllerTest {

	@Autowired
	private CountService countService;

	@Test
	public void cockpit() {

		CockpitVo cockpitVo=new CockpitVo();
		CockpitVo cockpitV = countService.queryCockpit(cockpitVo);
		System.out.println(cockpitV.getEndDate());

	}







}
