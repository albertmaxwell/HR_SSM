package com.hrms.service;

import java.util.Map;

/**
 * @author 金海洋
 * @date 2019/4/16  -12:35
 */
public interface ResourceFileServiceI {

	/**
	 * 根据id删除对应记录
	 *
	 * @param id
	 * @return
	 */
	public boolean delImgById(String id);

	/**
	 * 保存图片信息
	 *
	 * @param fileId
	 * @param tableId
	 * @param type
	 * @return id
	 */
	public String saveImg(String fileId, String tableId, String type);

	/**
	 * 依据fileId获取照片url地址
	 *
	 * @param fileId
	 * @return
	 * @throws Exception
	 */
	public String getImgUrl(String fileId) throws Exception;

	/**
	 * 根据表Id获取照片url调用getImgUrl方法(方法重载)
	 *
	 * @param params 表Id，文件Id
	 * @return
	 * @throws Exception
	 */
	public String getImgUrl(Map<String, Object> params) throws Exception;


	/**
	 * 根据业务数据的实例ID查询出所关联的文件ID(id都是多数据集，使用,分隔)
	 *
	 * @param tableId
	 * @return
	 * @throws Exception
	 */
	public String getFileIdByTableId(String tableId) throws Exception;


}
