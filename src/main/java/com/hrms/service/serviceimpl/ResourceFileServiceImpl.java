package com.hrms.service.serviceimpl;

import com.google.common.base.Joiner;
import com.hrms.bean.ResourceFile;
import com.hrms.service.ICommonService;
import com.hrms.service.ResourceFileServiceI;
import com.hrms.util.FileSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * @author 金海洋
 * @date 2019/4/16  -12:36
 */
@Service("resourceFileService")
@Transactional
public class ResourceFileServiceImpl implements ResourceFileServiceI{

	@Autowired
	private FileSupport fileSupport;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private ICommonService commonDao;

	@Override
	public boolean delImgById(String id) {
		ResourceFile resourceFile = new ResourceFile();
		resourceFile.setId(id);
		try {
			// TODO: 2019/4/16  delete(resourceFile);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public String saveImg(String fileId, String tableId, String type) {
		Date date = new Date();
		ResourceFile resourceFile = new ResourceFile();
		resourceFile.setId(UUID.randomUUID().toString());
		resourceFile.setCreateDate(date);
		resourceFile.setUpdateDate(date);
		resourceFile.setFile_id(fileId);
		resourceFile.setTable_id(tableId);
		resourceFile.setType(type);
		try {
			// TODO: 2019/4/16  return save(resourceFile).toString();
			return "yuyuyu";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 根据fileId获取文件Url
	 */
	@Override
	public String getImgUrl(String fileId) throws Exception {
		String imgUrl = fileSupport.getUrlByFileId(fileId);
		return imgUrl;
	}

	@Override
	public String getImgUrl(Map<String, Object> params) throws Exception {
		String fileId = params.get("fileId").toString();
		String tableId = params.get("tableId").toString();
		List<String> list = new ArrayList<>();
		String imgStr = "";
		String mapStr[] = {};
		if ("".equals(tableId) && !"".equals(fileId)) {
			String imageUrl = this.getImgUrl(params.get("fileId").toString());
			return imageUrl;
		}
		if (!"".equals(tableId) && "".equals(fileId)) {
			StringBuffer sql = new StringBuffer();
			sql.append(" select file_id ");
			sql.append(" from resource_file ");
			sql.append(" where table_id=? ");
			sql.append(" and type='0'  ");

			List listFileId = jdbcTemplate.queryForList(sql.toString(), tableId);
			for (Object key : listFileId) {
				String imgUrl = this.getImgUrl(key.toString());
				list.add(imgUrl);
			}
			imgStr = Joiner.on(",").join(list);
			return imgStr;

		}
		return "";
	}

	@Override
	public String getFileIdByTableId(String tableId) throws Exception {
		String result = commonDao.findOneForJdbc("select ifnull(group_concat(file_id),'') fileIds from resource_file where table_id = ?",tableId).get("fileIds").toString();
		return result;
	}


}
