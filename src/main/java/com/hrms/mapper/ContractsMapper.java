package com.hrms.mapper;

import com.hrms.bean.ContractsEntity;
import com.hrms.bean.Department;
import com.hrms.bean.RightsMan;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author 金海洋
 * @date 2019/4/7  -20:06
 */
public interface ContractsMapper {

	String TABLE_NAME = "tbl_contracts";
	String INSERT_FIELDS = "contracts_code, contracts_title";
	String SELECT_FIELDS = "dept_id as 'deptId', " +
			"dept_name as 'deptName', " +
			"dept_leader as 'deptLeader'";

	List<ContractsEntity> selectConByLimitAndOffset(@Param("offset") Integer offset,
													@Param("limit") Integer limit);


	@Select({"SELECT COUNT(*) FROM", TABLE_NAME})
	int countCon();


	/**
	 * =================================更改============================================
	 */
	int updateConById(@Param("conId") Integer conId,
						 @Param("contractsEntity") ContractsEntity contractsEntity);

	/**
	 * =================================查询============================================
	 */
	ContractsEntity selectOneById(@Param("conId") int conId);

	/**
	 * =================================新增============================================
	 */
	@Insert({"INSERT INTO",TABLE_NAME, "(", INSERT_FIELDS ,") " +
			"VALUES(#{contractsEntity.contractsCode}, #{contractsEntity.contractsTitle})"})
	int insertCon(@Param("contractsEntity") ContractsEntity contractsEntity);

}
