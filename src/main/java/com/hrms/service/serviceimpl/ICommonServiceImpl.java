package com.hrms.service.serviceimpl;

import com.hrms.service.ICommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * @author 金海洋
 * @date 2019/4/16  -12:46
 */
@Service
@Transactional
public class ICommonServiceImpl implements ICommonService {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Map<String, Object> findOneForJdbc(String sql, Object... objs) {
		try {
			return this.jdbcTemplate.queryForMap(sql, objs);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
}
