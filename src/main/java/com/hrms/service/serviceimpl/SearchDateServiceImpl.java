package com.hrms.service.serviceimpl;

import com.hrms.Vo.CitySwallListVo;
import com.hrms.service.SearchDateService;
import com.hrms.util.DateUtil;
import com.hrms.util.SortListUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.*;

/**
 * @author 金海洋
 * @date 2019/4/14  -23:30
 */
@Service("searchDateService")
@Transactional
public class SearchDateServiceImpl implements SearchDateService {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public List<CitySwallListVo> queryNumber(Map<String, Object> params) throws Exception {
		params.get("years").toString();//年
		String months = params.get("months").toString();//月
		String companyCode = params.get("companyCode").toString();//公司编码
		String productType = params.get("productType").toString();//产品类型
		StringBuffer sql = new StringBuffer();
		sql.append(" select t.*,t.enter+t.outs as hap from ( ");
		sql.append(" select t.time, t.mater,sum(if (t.type = 's', t.number,0))as enter,sum(if(t.type='f',t.number,0)) as outs from ( ");
		sql.append(" select t.code,date_format(t.time,'%y-%m')as time,t.type,t.number,t.mater from ( ");
		sql.append(" select rvaud02 as `code`,rva06 as time,'s' as type,rvb07 as number,rvb05 as mater  ");
		sql.append(" from rva_file left join rvb_file on rva01=rvb01 union all ");
		sql.append(" select ogaud03 as `code`,oga02 as time,'f' as type,ogb12 as number,ogb04 as mater ");
		sql.append(" from oga_file left join ogb_file on oga01=ogb01)t ");
		sql.append(" where t.time >=date_add( now( ), interval - ? month) )t ");
		List<Map<String, Object>> list = new ArrayList<>();
		//初始无条件查询
		if ("".equals(productType) && "".equals(companyCode)) {
			sql.append(" group by t.time)t ");
			list = jdbcTemplate.queryForList(sql.toString(), months);
		}
		//满条件查询(类型和公司类型都不可为空)
		if (!"".equals(productType) && !"".equals(companyCode)) {
			if ("all".equals(productType) && !"".equals(companyCode)) {
				sql.append(" left join v_company v on v.code=t.code where v.type= ?  ");
				sql.append(" group by t.time)t ");
				list = jdbcTemplate.queryForList(sql.toString(), months, companyCode);
			}
			if (!"all".equals(productType) && !"".equals(companyCode)) {
				sql.append(" left join v_company v on v.code=t.code where v.type= ? and t.mater= ? ");
				sql.append(" group by t.time)t ");
				list = jdbcTemplate.queryForList(sql.toString(), months, companyCode, productType);
			}
		}
		//无园区（空），类型查询（非空）
		if ("".equals(companyCode) && !"".equals(productType)) {
			if ("all".equals(productType) && "".equals(companyCode)) {
				sql.append(" group by t.time)t ");
				list = jdbcTemplate.queryForList(sql.toString(), months);
			}
			if (!"all".equals(productType) && "".equals(companyCode)) {
				sql.append(" left join v_company v on v.code=t.code where t.mater= ? ");
				sql.append(" group by t.time)t ");
				list = jdbcTemplate.queryForList(sql.toString(), months, productType);
			}
		}
		if (list.size() > 0 && list != null) {
			List<CitySwallListVo> dateVos = new ArrayList<>();
			List<String> existsTime = new ArrayList<>();
			List inoutList = new ArrayList();
			for (Map<String, Object> obj : list) {
				CitySwallListVo citySwallListVo = new CitySwallListVo();
				citySwallListVo.setTimes(obj.get("time").toString());
				citySwallListVo.setIntoNumber(new BigDecimal(obj.get("enter").toString()));//进货量
				citySwallListVo.setOutToNumber(new BigDecimal(obj.get("outs").toString()));//出货量
				citySwallListVo.setIntoOrOutNumber(new BigDecimal(obj.get("hap").toString()));//吞吐
				dateVos.add(citySwallListVo);
				existsTime.add(citySwallListVo.getTimes());
				inoutList.add(citySwallListVo.getIntoOrOutNumber());
			}
			//减去当前月份
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(new Date());
			calendar.add(Calendar.MONTH, -1);
			List<String> month = DateUtil.getDateForwardMonth(calendar.getTime(), Integer.parseInt(months));
			//补空挡月份
			for (int i = 0; i < month.size() - 1; i++) {
				String m = month.get(i);
				if (!existsTime.contains(m)) {
					CitySwallListVo cityVo = new CitySwallListVo();
					cityVo.setTimes(m);
					cityVo.setOutToNumber(new BigDecimal(0));
					cityVo.setIntoOrOutNumber(new BigDecimal(0));
					cityVo.setIntoNumber(new BigDecimal(0));
					dateVos.add(i, cityVo);
				}
			}
			List yAxisList = SortListUtil.listSorting(inoutList); //排序补间距
			int yAxis = SortListUtil.getSpacing(yAxisList);
			for (int i = 0; i < dateVos.size(); i++) {
				dateVos.get(i).setyAxis(yAxis);
			}
			return dateVos;
		}
		//空赋值
		List<CitySwallListVo> dateVoNull = new ArrayList<>();
		List<String> existsTime = new ArrayList<>();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.MONTH, -1);
		List<String> monthStr = DateUtil.getDateForwardMonth(calendar.getTime(), Integer.parseInt(months));
		for (int i = 0; i < monthStr.size(); i++) {
			String mon = monthStr.get(i);
			if (!existsTime.contains(mon)) {
				CitySwallListVo listVos = new CitySwallListVo();
				listVos.setTimes(mon);
				listVos.setOutToNumber(new BigDecimal(0));
				listVos.setIntoNumber(new BigDecimal(0));
				listVos.setIntoOrOutNumber(new BigDecimal(0));
				dateVoNull.add(i, listVos);
			}
		}
		return dateVoNull;
	}



}
