package com.hrms.Vo;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 金海洋
 * @date 2019/4/12  -18:45
 */
public class CockpitVo {

	//开始日期
	private String startDate;
	//结束日期
	private String endDate;

	//地图
	private List<MapVo> cockpitMapList = new ArrayList<>();

	//城市进货
	private List<PieChartsVo> cityGoodsIn = new ArrayList<>();
	//园区进货
	private List<PieChartsVo> yqGoodsIn = new ArrayList<>();
	//城市出货
	private List<PieChartsVo> cityGoodsOut = new ArrayList<>();
	//园区出货
	private List<PieChartsVo> yqGoodsOut = new ArrayList<>();

	//近6月总量增长
	private List<HistogramVo> sixTotalGrowth = new ArrayList<>();

	//近30天货物吞吐情况
	private List<HistogramVo> thirtyDayHuffAndPuff = new ArrayList<>();

	//产品类型分布占比图
	private List<DistributeVo> typeProportion = new ArrayList<>();

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public List<MapVo> getCockpitMapList() {
		return cockpitMapList;
	}

	public void setCockpitMapList(List<MapVo> cockpitMapList) {
		this.cockpitMapList = cockpitMapList;
	}

	public List<PieChartsVo> getCityGoodsIn() {
		return cityGoodsIn;
	}

	public void setCityGoodsIn(List<PieChartsVo> cityGoodsIn) {
		this.cityGoodsIn = cityGoodsIn;
	}

	public List<PieChartsVo> getYqGoodsIn() {
		return yqGoodsIn;
	}

	public void setYqGoodsIn(List<PieChartsVo> yqGoodsIn) {
		this.yqGoodsIn = yqGoodsIn;
	}

	public List<PieChartsVo> getCityGoodsOut() {
		return cityGoodsOut;
	}

	public void setCityGoodsOut(List<PieChartsVo> cityGoodsOut) {
		this.cityGoodsOut = cityGoodsOut;
	}

	public List<PieChartsVo> getYqGoodsOut() {
		return yqGoodsOut;
	}

	public void setYqGoodsOut(List<PieChartsVo> yqGoodsOut) {
		this.yqGoodsOut = yqGoodsOut;
	}

	public List<HistogramVo> getSixTotalGrowth() {
		return sixTotalGrowth;
	}

	public void setSixTotalGrowth(List<HistogramVo> sixTotalGrowth) {
		this.sixTotalGrowth = sixTotalGrowth;
	}

	public List<HistogramVo> getThirtyDayHuffAndPuff() {
		return thirtyDayHuffAndPuff;
	}

	public void setThirtyDayHuffAndPuff(List<HistogramVo> thirtyDayHuffAndPuff) {
		this.thirtyDayHuffAndPuff = thirtyDayHuffAndPuff;
	}

	public List<DistributeVo> getTypeProportion() {
		return typeProportion;
	}

	public void setTypeProportion(List<DistributeVo> typeProportion) {
		this.typeProportion = typeProportion;
	}


}
