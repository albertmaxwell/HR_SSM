package com.hrms.controller;

import com.hrms.Vo.CitySwallListVo;
import com.hrms.Vo.CitySwallVo;
import com.hrms.Vo.CockpitVo;
import com.hrms.service.CountService;
import com.hrms.service.SearchDateService;
import com.hrms.util.JsonMessage;
import com.hrms.util.JsonMsg;
import com.hrms.util.ResponseMessage;
import com.hrms.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 金海洋
 * @date 2019/4/12  -18:35
 */
@Controller
@RequestMapping(value = "/hrms/visualData")
public class visualDataController {

	@Autowired
	private CountService countService;

	@Autowired
	private SearchDateService searchDateService;



	/**
	 * 查询平台运营驾驶舱数据
	 *
	 * @return
	 */
	@RequestMapping(value = "/cockpit", method = RequestMethod.GET)
	@ResponseBody
	public JsonMessage cockpit(@RequestParam(value = "startDate", required = true) String startDate,
							   @RequestParam(value = "endDate", required = true) String endDate) {
		JsonMessage j = new JsonMessage();

		try {
			if (StringUtils.isEmpty(startDate) || StringUtils.isEmpty(endDate)) {
				throw new Exception("参数异常");
			}
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				sdf.parse(startDate);
				sdf.parse(endDate);
			} catch (ParseException e) {
				e.printStackTrace();
				throw new Exception("日期格式错误");
			}
			CockpitVo cockpitVo = new CockpitVo();
			cockpitVo.setStartDate(startDate);
			cockpitVo.setEndDate(endDate);
			cockpitVo = countService.queryCockpit(cockpitVo);

			j.setObj(cockpitVo);


			System.out.println(j.getObj());

			return j;

		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg(e.getMessage());
		}
		return j;
	}



	@RequestMapping(value = "/riseSearch", method = RequestMethod.POST)
	@ResponseBody
	public ResponseMessage<?> riseSearch(@RequestBody CitySwallVo citySwallVo) {
		Map<String, Object> params = new HashMap<>();
		params.put("years", citySwallVo.getFullYears());
		params.put("months", citySwallVo.getMonths());
		params.put("companyCode", citySwallVo.getYardNumber());
		params.put("productType", citySwallVo.getProductType());
		try {
			List<CitySwallListVo> list = searchDateService.queryNumber(params);
			return Result.success(list);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.error("请求失败！");
		}

	}



}
