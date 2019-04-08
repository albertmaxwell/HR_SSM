package com.hrms.controller;

import com.hrms.bean.ContractsEntity;
import com.hrms.bean.Department;
import com.hrms.mapper.ContractsMapper;
import com.hrms.service.ContractsService;
import com.hrms.service.DepartmentService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @author 金海洋
 * @date 2019/4/7  -20:17
 */
@Controller
@RequestMapping(value = "/hrms/contracts")
public class ContractsController {

	private static Logger logger = LogManager.getLogger(DepartmentController.class.getName());

	@Autowired
	ContractsService contractsService;

	/**
	 * 分页查询：返回指定页数对应的数据
	 * @param pageNo
	 * @return
	 */
	@RequestMapping(value = "/getConList", method = RequestMethod.GET)
	public ModelAndView getConList(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo){
		ModelAndView mv = new ModelAndView("contractsPage");
		//每页显示的记录行数
		int limit = 5;
		//总记录数
		int totalItems = contractsService.getConCount();
		int temp = totalItems / limit;
		int totalPages = (totalItems % limit== 0) ? temp : temp+1;
		//每页的起始行(offset+1)数据，如第一页(offset=0，从第1(offset+1)行数据开始)
		int offset = (pageNo - 1)*limit;
		List<ContractsEntity> conList = contractsService.getConList(offset, limit);

		mv.addObject("conList", conList)
				.addObject("totalItems", totalItems)
				.addObject("totalPages", totalPages)
				.addObject("curPageNo", pageNo);
		return mv;
	}



}
