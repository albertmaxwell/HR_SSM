package com.hrms.service.serviceimpl;

import com.hrms.Vo.DistributeVo;
import com.hrms.Vo.HistogramVo;
import com.hrms.Vo.MapVo;
import com.hrms.Vo.PieChartsVo;
import com.hrms.service.ChartsDataService;
import com.hrms.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.*;

/**
 * @author 金海洋
 * @date 2019/4/13  -10:36
 */
@Service
@Transactional
public class ChartsDataServiceImpl implements ChartsDataService  {

	@Resource
	private JdbcTemplate jdbcTemplate;

	@Override
	public List<MapVo> queryYqHuffAndPuff(String startDate, String endDate) {
		String sql = "SELECT SUM(IF(t.type = 's', t.number, 0)) AS enter "
				+ ", SUM(IF(t.type = 'f', t.number, 0)) AS `out` , v.city"
				+ " FROM ( SELECT * FROM ( SELECT a.rvaud02 AS `code`, b.rvb07 AS number, 's' AS type, a.rva06 AS time"
				+ " FROM rva_file a LEFT JOIN rvb_file b ON a.rva01 = b.rvb01 UNION ALL"
				+ " SELECT a.ogaud03 AS `code`, b.ogb12 AS number, 'f' AS type, a.oga02 AS time"
				+ " FROM oga_file a LEFT JOIN ogb_file b ON a.oga01 = b.ogb01 ) t"
				+ " WHERE date_format(t.time, '%Y-%m-%d') >= ? AND date_format(t.time, '%Y-%m-%d') <= ?"
				+ " GROUP BY t.CODE, t.type ) t LEFT JOIN v_company v ON v.CODE = t.CODE"
				+ " WHERE v.type = 'YQ' GROUP BY v.city";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, startDate, endDate);
		if(list != null && list.size() > 0) {
			List<MapVo> mapVos = new ArrayList<>();
			for(Map<String, Object> map : list) {
				MapVo mapVo = new MapVo();
				mapVo.setEnterNumber(new BigDecimal(map.get("enter").toString()));
				mapVo.setOutNumber(new BigDecimal(map.get("out").toString()));
				mapVo.setCity(map.get("city").toString());
				mapVos.add(mapVo);
			}
			return mapVos;
		}
		return null;
	}

	@Override
	public List<PieChartsVo> getCityGoodsWeightByStatus(boolean isIn, String startDate, String endDate) {
		String sql = "SELECT SUM(IF(t.type = ?, t.number, 0)) AS number, v.city"
				+ " FROM ( SELECT * FROM ( SELECT a.rvaud02 AS `code`, b.rvb07 AS number, 's' AS type, a.rva06 AS time"
				+ " FROM rva_file a LEFT JOIN rvb_file b ON a.rva01 = b.rvb01 UNION ALL"
				+ " SELECT a.ogaud03 AS `code`, b.ogb12 AS number, 'f' AS type, a.oga02 AS time"
				+ " FROM oga_file a LEFT JOIN ogb_file b ON a.oga01 = b.ogb01 ) t"
				+ " WHERE date_format(t.time, '%Y-%m-%d') >= ? AND date_format(t.time, '%Y-%m-%d') <= ?"
				+ " GROUP BY t.CODE, t.type ) t LEFT JOIN v_company v ON v.CODE = t.CODE"
				+ " WHERE v.type = 'YQ' GROUP BY v.city";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, isIn?"s":"f", startDate, endDate);
		if(list != null && list.size() > 0) {
			List<PieChartsVo> pieVos = new ArrayList<>();
			for(Map<String, Object> map : list) {
				PieChartsVo pieVo = new PieChartsVo();
				pieVo.setName(map.get("city").toString());
				pieVo.setNumber(new BigDecimal(map.get("number").toString()));
				pieVos.add(pieVo);
			}
			return pieVos;
		}
		return null;
	}

	@Override
	public List<PieChartsVo> getYqGoodsWeightByStatus(boolean isIn, String startDate, String endDate) {
		String sql = "SELECT SUM(IF(t.type = ?, t.number, 0)) AS number "
				+ ", v.NAME yq_name FROM ( SELECT * FROM ( SELECT a.rvaud02 AS `code`"
				+ ", b.rvb07 AS number, 's' AS type, a.rva06 AS time FROM rva_file a"
				+ " LEFT JOIN rvb_file b ON a.rva01 = b.rvb01 UNION ALL"
				+ " SELECT a.ogaud03 AS `code`, b.ogb12 AS number, 'f' AS type, a.oga02 AS time"
				+ " FROM oga_file a LEFT JOIN ogb_file b ON a.oga01 = b.ogb01 ) t"
				+ " WHERE date_format(t.time, '%Y-%m-%d') >= ? AND date_format(t.time, '%Y-%m-%d') <= ?"
				+ " GROUP BY t.CODE, t.type ) t LEFT JOIN v_company v ON v.CODE = t.CODE"
				+ " WHERE v.type = 'YQ' GROUP BY t.CODE";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, isIn?"s":"f", startDate, endDate);
		if(list != null && list.size() > 0) {
			List<PieChartsVo> pieVos = new ArrayList<>();
			for(Map<String, Object> map : list) {
				PieChartsVo pieVo = new PieChartsVo();
				pieVo.setName(map.get("yq_name").toString());
				pieVo.setNumber(new BigDecimal(map.get("number").toString()));
				pieVos.add(pieVo);
			}
			return pieVos;
		}
		return null;
	}

	@Override
	public List<HistogramVo> getCurrNMonthYqHuffAndPuff(int month, List<String> stuffs, List<String> yqCodes) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT t.*, t.enter + t.`OUT` AS hap FROM ( SELECT t.time "
				+ ", SUM(IF(t.type = 's', t.number, 0)) AS enter , SUM(IF(t.type = 'f', t.number, 0))"
				+ " AS `out` FROM ( SELECT t.CODE, t.number, t.type , date_format(t.time, '%y-%m')"
				+ " AS time FROM ( SELECT * FROM ( SELECT a.rvaud02 AS `code`, b.rvb07 AS number"
				+ ", 's' AS type, a.rva06 AS time, b.rvb05 AS stuff FROM rva_file a "
				+ "LEFT JOIN rvb_file b ON a.rva01 = b.rvb01 "
				+ "UNION ALL "
				+ "SELECT a.ogaud03 AS `code`, b.ogb12 AS number, 'f' AS type, a.oga02 AS time"
				+ ", b.ogb04 AS stuff FROM oga_file a LEFT JOIN ogb_file b ON a.oga01 = b.ogb01 ) t "
				+ "WHERE 1 = 1 ");
		if(stuffs != null && stuffs.size() > 0) {
			sql.append(" AND t.stuff in (");
			for(String stuff : stuffs) {
				sql.append("?,");
			}
			sql.delete(sql.length()-1, sql.length());
			sql.append(")");
		}
		if(yqCodes != null && yqCodes.size() > 0) {
			sql.append(" AND t.code in (");
			for(String yqCode : yqCodes) {
				sql.append("?,");
			}
			sql.delete(sql.length()-1, sql.length());
			sql.append(")");
		}
		sql.append(") t WHERE t.time >= STR_TO_DATE(date_format(DATE_ADD(now(), INTERVAL -? MONTH), '%y-%m'), '%y-%m')"
				+ " AND t.time < STR_TO_DATE(date_format(DATE_ADD(now(), INTERVAL 0 MONTH), '%y-%m'), '%y-%m') ) t "
				+ "LEFT JOIN v_company v ON v.CODE = t.CODE WHERE v.type = 'YQ' GROUP BY time ) t");

		List<Object> params = new ArrayList<>();
		if(stuffs != null && stuffs.size() > 0) {
			for(String stuff : stuffs) {
				params.add(stuff);
			}
		}
		if(yqCodes != null && yqCodes.size() > 0) {
			for(String yqCode : yqCodes) {
				params.add(yqCode);
			}
		}
		params.add(month);

		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql.toString(), params.toArray());
		if(list != null && list.size() > 0) {
			List<HistogramVo> hVos = new ArrayList<>();
			List<String> existsTime = new ArrayList<>();
			for(Map<String, Object> map : list) {
				HistogramVo hVo = new HistogramVo();
				hVo.setTime(map.get("time").toString());
				hVo.setEnter(new BigDecimal(map.get("enter").toString()));
				hVo.setOut(new BigDecimal(map.get("out").toString()));
				hVo.setHap(new BigDecimal(map.get("hap").toString()));
				hVos.add(hVo);
				existsTime.add(hVo.getTime());
			}
			//不取当月
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(new Date());
			calendar.add(Calendar.MONTH, -1);
			//若月份不足，空挡补零
			List<String> months = DateUtil.getDateForwardMonth(calendar.getTime(), month);
			for(int i=0; i<months.size(); i++) {
				String m = months.get(i);
				if(!existsTime.contains(m)) {
					HistogramVo hVo = new HistogramVo();
					hVo.setTime(m);
					hVo.setEnter(new BigDecimal(0));
					hVo.setOut(new BigDecimal(0));
					hVo.setHap(new BigDecimal(0));
					hVos.add(i, hVo);
				}
			}
			return hVos;
		}
		return null;
	}

	@Override
	public List<HistogramVo> getCurrNDayYqHuffAndPuff(int day, List<String> stuffs, List<String> yqCodes) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT t.*, t.enter + t.`OUT` AS hap FROM ("
				+ " SELECT date_format(t.time, '%m-%d') time , SUM(IF(t.type = 's', t.number, 0)) AS enter"
				+ " , SUM(IF(t.type = 'f', t.number, 0)) AS `out` FROM ( "
				+ "SELECT t.CODE, t.number, t.type , date_format(t.time, '%y-%m-%d') AS time "
				+ "FROM ( SELECT * FROM ( SELECT a.rvaud02 AS `code`, b.rvb07 AS number"
				+ ", 's' AS type, a.rva06 AS time, b.rvb05 AS stuff FROM rva_file a"
				+ " LEFT JOIN rvb_file b ON a.rva01 = b.rvb01"
				+ " UNION ALL SELECT a.ogaud03 AS `code`, b.ogb12 AS number, 'f' AS type"
				+ ", a.oga02 AS time, b.ogb04 AS stuff FROM oga_file a"
				+ " LEFT JOIN ogb_file b ON a.oga01 = b.ogb01 ) t WHERE 1 = 1 ");
		if(stuffs != null && stuffs.size() > 0) {
			sql.append(" AND t.stuff in (");
			for(String stuff : stuffs) {
				sql.append("?,");
			}
			sql.delete(sql.length()-1, sql.length());
			sql.append(")");
		}
		if(yqCodes != null && yqCodes.size() > 0) {
			sql.append(" AND t.code in (");
			for(String yqCode : yqCodes) {
				sql.append("?,");
			}
			sql.delete(sql.length()-1, sql.length());
			sql.append(")");
		}
		sql.append(") t WHERE t.time >= STR_TO_DATE(date_format(DATE_ADD(now(), INTERVAL -? DAY)"
				+ ", '%y-%m-%d'), '%y-%m-%d') AND t.time < STR_TO_DATE(date_format(DATE_ADD(now()"
				+ ", INTERVAL 0 DAY), '%y-%m-%d'), '%y-%m-%d') ) t"
				+ " LEFT JOIN v_company v ON v.CODE = t.CODE WHERE v.type = 'YQ' GROUP BY time ) t");

		List<Object> params = new ArrayList<>();
		if(stuffs != null && stuffs.size() > 0) {
			for(String stuff : stuffs) {
				params.add(stuff);
			}
		}
		if(yqCodes != null && yqCodes.size() > 0) {
			for(String yqCode : yqCodes) {
				params.add(yqCode);
			}
		}
		params.add(day);

		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql.toString(), params.toArray());
		if(list != null && list.size() > 0) {
			List<HistogramVo> hVos = new ArrayList<>();
			List<String> existsTime = new ArrayList<>();
			for(Map<String, Object> map : list) {
				HistogramVo hVo = new HistogramVo();
				hVo.setTime(map.get("time").toString());
				hVo.setEnter(new BigDecimal(map.get("enter").toString()));
				hVo.setOut(new BigDecimal(map.get("out").toString()));
				hVo.setHap(new BigDecimal(map.get("hap").toString()));
				hVos.add(hVo);
				existsTime.add(hVo.getTime());
			}
			//不取当天
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(new Date());
			calendar.add(Calendar.DAY_OF_MONTH, -1);
			//若天数不足，空挡补零
			List<String> days = DateUtil.getDateForwardDay(calendar.getTime(), day);
			for(int i=0; i<days.size(); i++) {
				String d = days.get(i);
				if(!existsTime.contains(d)) {
					HistogramVo hVo = new HistogramVo();
					hVo.setTime(d);
					hVo.setEnter(new BigDecimal(0));
					hVo.setOut(new BigDecimal(0));
					hVo.setHap(new BigDecimal(0));
					hVos.add(i, hVo);
				}
			}
			return hVos;
		}
		return null;
	}

	@Override
	public List<DistributeVo> getDistribute(String startDate, String endDate) {
		String sql = "select b.rvb051 `name`, sum(b.rvb07) `value` from rva_file a"
				+ " left join rvb_file b on a.rva01=b.rvb01"
				+ " where date_format(a.rva06, '%Y-%m-%d') >= ? AND date_format(a.rva06, '%Y-%m-%d') <= ?"
				+ " group by b.rvb05";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, startDate, endDate);
		if(list != null && list.size() > 0) {
			List<DistributeVo> dVos = new ArrayList<>();
			for(Map<String, Object> map : list) {
				DistributeVo dVo = new DistributeVo();
				dVo.setName(map.get("name").toString());
				dVo.setValue(new BigDecimal(map.get("value").toString()));
				dVos.add(dVo);
			}
			return dVos;
		}
		return null;
	}







}
