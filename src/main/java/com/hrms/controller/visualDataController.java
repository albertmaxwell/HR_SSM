package com.hrms.controller;

import com.hrms.Vo.CockpitVo;
import com.hrms.service.CountService;
import com.hrms.util.JsonMessage;
import com.hrms.util.JsonMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 * @author 金海洋
 * @date 2019/4/12  -18:35
 */
@Controller
@RequestMapping(value = "/hrms/visualData")
public class visualDataController {

	@Autowired
	private CountService countService;

	/**
	 * 查询平台运营驾驶舱数据
	 * @return
	 *
	 */
	@RequestMapping(value = "/cockpit", method = RequestMethod.GET)
	@ResponseBody
	public JsonMsg cockpit(@RequestParam(value="startDate", required=true) String startDate,
						   @RequestParam(value="endDate", required=true) String endDate) {
		JsonMsg j = new JsonMsg();
		try{
			if(StringUtils.isEmpty(startDate) || StringUtils.isEmpty(endDate)) {
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

			return JsonMsg.success().addInfo("cockpitVo",cockpitVo );

		}catch(Exception e){
			e.printStackTrace();
			return JsonMsg.fail();
		}

	}


}
