package com.hrms.mapper;

import com.hrms.bean.Department;
import com.hrms.bean.RightsMan;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * @author 金海洋
 * @date 2019/4/7  -13:38
 */
public interface LoginMapper {

	String TABLE_NAME = "tbl_rights";
	String INSERT_FIELDS = "rights_person_name, rights_account, rights_password";
	String SELECT_FIELDS = "rights_id as 'rightsId', " +
			"rights_name as 'rightsName', " +
			"rights_account as 'rightsAccount',"+
			"rights_password as 'rightsPassword'";



	/**
	 * =================================查询============================================
	 */
	@Select({"SELECT", SELECT_FIELDS, "FROM", TABLE_NAME, "WHERE rights_account=#{rightsAccount} and rights_password=#{rightsPassword}" })
	RightsMan checkUser( @Param("rightsAccount") String rightsAccount ,@Param("rightsPassword") String rightsPassword);




}
