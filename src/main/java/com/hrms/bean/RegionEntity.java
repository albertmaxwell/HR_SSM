package com.hrms.bean;

/**
 * @author 金海洋
 * @date 2019/4/8  -16:11
 */
public class RegionEntity {

	private String id;
	private String name;
	private String pid;
	private String nameEn;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public RegionEntity(){

	}

	public String getNameEn() {
		return nameEn;
	}

	public void setNameEn(String nameEn) {
		this.nameEn = nameEn;
	}

	public RegionEntity(String id, String name, String pid, String nameEn) {
		this.id = id;
		this.name = name;
		this.pid = pid;
		this.nameEn = nameEn;
	}

	@Override
	public String toString() {
		return "RegionEntity{" +
				"id='" + id + '\'' +
				", name='" + name + '\'' +
				", pid='" + pid + '\'' +
				", nameEn='" + nameEn + '\'' +
				'}';
	}
}
