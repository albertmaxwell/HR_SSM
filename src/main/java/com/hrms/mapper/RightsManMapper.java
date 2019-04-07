package com.hrms.mapper;

import com.hrms.bean.Employee;
import com.hrms.bean.RightsMan;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * @author 金海洋
 * @date 2019/4/6  -11:56
 */

public interface RightsManMapper {

	String TABLE_NAME = "tbl_rights";
	String INSERT_FIELDS = "rights_person_name, rights_account, rights_password";
	String SELECT_FIELDS = "rights_id as 'rightsId', " +
			"rights_name as 'rightsName', " +
			"rights_account as 'rightsAccount'"+
			"rights_password as 'rightsPassword'";


	/**
	 * =================================新增============================================
	 */
	@Insert({"INSERT INTO",TABLE_NAME, "(", INSERT_FIELDS ,") " +
			"VALUES(#{rightsMan.rightsName}, #{rightsMan.rightsAccount},#{rightsMan.rightsPassword})" })
	int insertRights(@Param("rightsMan") RightsMan rightsMan);

	@Select({"SELECT COUNT(*) FROM", TABLE_NAME})
	int countRights();

	List<RightsMan> selectRightsByLimitAndOffset(@Param("offset") Integer offset,
												 @Param("limit") Integer limit);

	/**
	 * =================================更改============================================
	 */
	int updateRightsById(@Param("rightsId") Integer rightsId,
					   @Param("rightsMan") RightsMan rightsMan);

	/**
	 * =================================查询============================================
	 */
	RightsMan selectOneById(@Param("rightsId") int rightsId);

	/**
	 * =================================删除============================================
	 */
	@Delete({"DELETE FROM", TABLE_NAME, "WHERE rights_id=#{rightsId}"})
	int deleteRightsById(@Param("rightsId") Integer rightsId);
}
