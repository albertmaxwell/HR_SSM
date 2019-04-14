package com.hrms.mapper;

import com.hrms.bean.RegionEntity;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;
import java.util.Map;

/**
 * @author 金海洋
 * @date 2019/4/8  -14:17
 */
public interface PCAMapper {

	String TABLE_NAME = "t_s_region";


	@Select({"select id,name,pid,NAME_EN nameEn from", TABLE_NAME ,"where pid=#{pid}", "order by name_en"})
	List<RegionEntity> selectRegList(@Param("pid") String pid);

}
