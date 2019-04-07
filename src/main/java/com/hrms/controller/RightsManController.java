package com.hrms.controller;


import com.hrms.bean.Employee;
import com.hrms.bean.RightsMan;
import com.hrms.service.RightManService;
import com.hrms.util.JsonMsg;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @author 金海洋
 * @date 2019/4/6  -11:52
 */
@Controller
@RequestMapping(value = "/hrms/rights")

public class RightsManController {

	private static Logger logger = LogManager.getLogger(RestController.class.getName());

		@Autowired
		RightManService rightManService;


	/**
	 * 分页查询：返回指定页数对应的数据
	 * @param pageNo
	 * @return
	 */
	@RequestMapping(value = "/getRightsList", method = RequestMethod.GET)
	public ModelAndView getRightsList(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo){
		ModelAndView mv = new ModelAndView("rightsManagePage");
		//每页显示的记录行数
		int limit = 5;
		//总记录数
		int totalItems = rightManService.getRightsCount();
		int temp = totalItems / limit;
		int totalPages = (totalItems % limit== 0) ? temp : temp+1;
		//每页的起始行(offset+1)数据，如第一页(offset=0，从第1(offset+1)行数据开始)
		int offset = (pageNo - 1)*limit;
		List<RightsMan> rightsList = rightManService.getRightsList(offset, limit);

		mv.addObject("rightsList", rightsList)
				.addObject("totalItems", totalItems)
				.addObject("totalPages", totalPages)
				.addObject("curPageNo", pageNo);
		return mv;
	}

	/**
	 * 部门更改
	 * @param deptId
	 * @param department
	 * @return
	 */
	@RequestMapping(value = "/updateRights/{rightsId}", method = RequestMethod.PUT)
	@ResponseBody
	public JsonMsg updateRightsById(@PathVariable("rightsId") Integer rightsId, RightsMan rightsMan){

		int res = 0;
		if (rightsId > 0){
			res = rightManService.updateRightsById(rightsId, rightsMan);
		}
		if (res != 1){
			return JsonMsg.fail().addInfo("update_dept_error", "部门更新失败");
		}
		return JsonMsg.success();
	}

	/**
	 * 根据id查询员工信息
	 * @param empId
	 * @return
	 */
	@RequestMapping(value = "/getRightsById/{rightsId}", method = RequestMethod.GET)
	@ResponseBody
	public JsonMsg getRightsById(@PathVariable("rightsId") Integer rightsId){
		RightsMan rightsMan = rightManService.getRightsById(rightsId);
		if (rightsMan != null){
			return JsonMsg.success().addInfo("rightsMan", rightsMan);
		}else {
			return JsonMsg.fail();
		}

	}

	/**
	 * 删除
	 * @param deptId
	 * @return
	 */
	@RequestMapping(value = "/delRights/{rightsId}", method = RequestMethod.DELETE)
	@ResponseBody
	public JsonMsg deleteRights(@PathVariable("rightsId") Integer rightsId){
		int res = 0;
		if (rightsId > 0){
			res = rightManService.deleteRightsById(rightsId);
		}
		if (res != 1){
			return JsonMsg.fail().addInfo("del_dept_error", "删除异常");
		}
		return JsonMsg.success();
	}



}
