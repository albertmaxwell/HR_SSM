package com.hrms.util;

import com.resource.common.support.FileServerSupport;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * @author 金海洋
 * @date 2019/4/16  -12:38
 */
@Component
public class FileSupport {

	@Value("${files.server.url}")
	private String filesServerUrl;

	/**
	 * 根据文件id，从文件服务器获取文件路径
	 * @param id
	 * @return
	 */
	public String getUrlByFileId(String id) {
		return FileServerSupport.getUrlByFileId(filesServerUrl, id);
	}


}
