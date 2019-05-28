package com.hrms.controller;

import com.hrms.bean.ResourceFile;
import com.hrms.service.ResourceFileServiceI;
import com.hrms.util.ResponseMessage;
import com.hrms.util.Result;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 金海洋
 * @date 2019/4/16  -12:33
 */
@RestController
@RequestMapping(value ="/hrms/resourceFileController")
public class ResourceFileController {

	private static final Logger logger = LoggerFactory.getLogger(ResourceFileController.class);

	@Autowired
	private ResourceFileServiceI resourceFileService;
	@Autowired
	private JdbcTemplate jdbcTemplate;

	/**
	 * 删除文件信息
	 *
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public ResponseMessage<?> delete(@RequestParam(value = "id", required = true) String id) {
		try {
			resourceFileService.delImgById(id);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.error();
		}
		return Result.success();
	}

	/**
	 * 保存文件信息
	 *
	 * @return
	 */
	@RequestMapping(params = "save", method = RequestMethod.POST)
	@ResponseBody
	public ResponseMessage<String> save(@RequestParam(value = "fileId", required = true) String fileId
			, @RequestParam(value = "tableId", required = true) String tableId
			, @RequestParam(value = "type", required = false) String type) {
		try {
			if (StringUtils.isEmpty(type)) {
				type = "0";
			}
			String result = resourceFileService.saveImg(fileId, tableId, type);
			return Result.success(result);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.error();
		}
	}

	/**
	 * 根据文件fileId获取图片url
	 */
	@RequestMapping(params = "getImgUrl")
	public ResponseMessage<?> getImgUrl(HttpServletRequest request) {
		String fileId = request.getParameter("fileId");
		String imgUrl = "";
		try {
			imgUrl = resourceFileService.getImgUrl(fileId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Result.success(imgUrl);
	}

	/**
	 * 根据表Id，文件Id获取照片url公有接口
	 */
	@RequestMapping(params = "getImgUrls")
	public ResponseMessage<?> getImgUrls(HttpServletRequest request) {
		String fileId = request.getParameter("fileId");
		String tableId = request.getParameter("tableId");
		if (fileId == null) {
			fileId = "";
		}
		if (tableId == null) {
			tableId = "";
		}
		Map params = new HashMap();
		params.put("fileId", fileId);
		params.put("tableId", tableId);
		String imgUrl = "";
		try {
			imgUrl = resourceFileService.getImgUrl(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Result.success(imgUrl);
	}

	/**
	 * 根据tableid查询不同类型最近的一条数据
	 */
	@RequestMapping(params = "getImgByTabIdGroupType")
	public ResponseMessage<List<ResourceFile>> getImgByTabIdGroupType(HttpServletRequest request) {
		String tableId = request.getParameter("tableId");
		if (StringUtils.isEmpty(tableId)) {
			return Result.error("参数错误");
		}
		String sql = "select * from (select * from resource_file where table_id=? order by create_date desc) t group by t.type";
		try {
			List<ResourceFile> list = jdbcTemplate.query(sql, new Object[]{tableId}, new BeanPropertyRowMapper(ResourceFile.class));
			return Result.success(list);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.error("图片查询错误");
		}
	}








}
