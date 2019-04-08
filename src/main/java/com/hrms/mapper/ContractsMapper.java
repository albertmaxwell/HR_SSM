package com.hrms.mapper;

import com.hrms.bean.ContractsEntity;
import com.hrms.bean.Department;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author 金海洋
 * @date 2019/4/7  -20:06
 */
public interface ContractsMapper {

	String TABLE_NAME = "tbl_contracts";
	String INSERT_FIELDS = "dept_name, dept_leader";
	String SELECT_FIELDS = "dept_id as 'deptId', " +
			"dept_name as 'deptName', " +
			"dept_leader as 'deptLeader'";

	List<ContractsEntity> selectConByLimitAndOffset(@Param("offset") Integer offset,
													@Param("limit") Integer limit);


	@Select({"SELECT COUNT(*) FROM", TABLE_NAME})
	int countCon();



}
