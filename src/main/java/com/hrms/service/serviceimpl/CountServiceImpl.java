package com.hrms.service.serviceimpl;

/**
 * @author 金海洋
 * @date 2019/4/13  -10:08
 */

import com.hrms.Vo.*;
import com.hrms.service.ChartsDataService;
import com.hrms.service.CountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 类表述：报表统计业务数据逻辑层
 */
@Service
@Transactional
public class CountServiceImpl implements CountService {

	@Resource
	private ChartsDataService chartsDataService;

	@Resource
	private JdbcTemplate jdbcTemplate;

	@Override
	public CockpitVo queryCockpit(CockpitVo vo) {
		/*城市园区吞吐量*/
		List<MapVo> cockpitMapList = chartsDataService.queryYqHuffAndPuff(vo.getStartDate(), vo.getEndDate());
		vo.setCockpitMapList(cockpitMapList);

		/*城市园区进货量*/
		List<PieChartsVo> cityGoodsIn = chartsDataService.getCityGoodsWeightByStatus(true, vo.getStartDate(), vo.getEndDate());
		List<PieChartsVo> yqGoodsIn = chartsDataService.getYqGoodsWeightByStatus(true, vo.getStartDate(), vo.getEndDate());
		vo.setCityGoodsIn(cityGoodsIn);
		vo.setYqGoodsIn(yqGoodsIn);

		/*城市园区出货量*/
		List<PieChartsVo> cityGoodsOut = chartsDataService.getCityGoodsWeightByStatus(false, vo.getStartDate(), vo.getEndDate());
		List<PieChartsVo> yqGoodsOut = chartsDataService.getYqGoodsWeightByStatus(false, vo.getStartDate(), vo.getEndDate());
		vo.setCityGoodsOut(cityGoodsOut);
		vo.setYqGoodsOut(yqGoodsOut);

		/*查询近六月总量增长*/
		List<HistogramVo> sixTotalGrowth = chartsDataService.getCurrNMonthYqHuffAndPuff(6, null, null);
		vo.setSixTotalGrowth(sixTotalGrowth);

		/*查询近30天吞吐*/
		List<HistogramVo> thirtyDayHuffAndPuff = chartsDataService.getCurrNDayYqHuffAndPuff(30, null, null);
		vo.setThirtyDayHuffAndPuff(thirtyDayHuffAndPuff);

		/*查询料件分布*/
		List<DistributeVo> typeProportion = chartsDataService.getDistribute(vo.getStartDate(), vo.getEndDate());
		vo.setTypeProportion(typeProportion);
		return vo;
	}




}
