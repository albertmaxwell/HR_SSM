package com.hrms.common;

import com.hrms.bean.RegionEntity;
import com.hrms.controller.DepartmentController;
import com.hrms.mapper.PCAMapper;
import com.hrms.util.JsonMsg;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * @author 金海洋
 * @date 2019/4/8  -14:12
 */
@Controller
@RequestMapping(value = "/hrms/pca")

public class PCAController {

	private static Logger logger = LogManager.getLogger(PCAController.class.getName());
	@Autowired
	PCAMapper pcaMapper;









}
