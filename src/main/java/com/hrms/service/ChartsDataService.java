package com.hrms.service;

import com.hrms.Vo.DistributeVo;
import com.hrms.Vo.HistogramVo;
import com.hrms.Vo.MapVo;
import com.hrms.Vo.PieChartsVo;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 金海洋
 * @date 2019/4/13  -10:10
 */

public interface ChartsDataService {

	/**
	 * 查询区园吞吐量
	 * @param startDate
	 * @param endaDte
	 * @return
	 */
	public List<MapVo> queryYqHuffAndPuff(String startDate, String endaDte);

	/**
	 * 按照城市区分，根据状态查询货物重量
	 * @param isIn 是否为收货，为否则查询出货
	 * @param startDate 开始日期
	 * @param endDate 结束日期
	 * @return
	 */
	public List<PieChartsVo> getCityGoodsWeightByStatus(boolean isIn, String startDate, String endDate);

	/**
	 * 按照园区区分，根据状态查询货物重量
	 * @param isIn 是否为收货，为否则查询出货
	 * @param startDate 开始日期
	 * @param endDate 结束日期
	 * @return
	 */
	public List<PieChartsVo> getYqGoodsWeightByStatus(boolean isIn, String startDate, String endDate);

	/**
	 * 查询当前时间往前，N月园区吞吐量（不按照园区分组）
	 * 注：当月并不会查询，从上个月往前推
	 *
	 * @param month 必填 往前推的月数
	 * @param stuffs 选填 料件编码
	 * @param yqCodes 选填 园区编码
	 * @return
	 */
	public List<HistogramVo> getCurrNMonthYqHuffAndPuff(int month, List<String> stuffs, List<String> yqCodes);

	/**
	 * 查询当前时间往前，N天园区吞吐量（不按照园区分组）
	 * 注：当天并不会查询，从前一天往前推
	 *
	 * @param day 必填 往前推的天数
	 * @param stuffs 选填 料件编码
	 * @param yqCodes 选填 园区编码
	 * @return
	 */
	public List<HistogramVo> getCurrNDayYqHuffAndPuff(int day, List<String> stuffs, List<String> yqCodes);

	/**
	 * 查询料件分布
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public List<DistributeVo> getDistribute(String startDate, String endDate);




}
