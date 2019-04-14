package com.hrms.bean;

/**
 * @author 金海洋
 * @date 2019/4/7  -20:00
 */
public class ContractsEntity {

	private Integer contractsId;
	private String contractsCode;
	private String contractsTitle;
	private String provincePid;
	private String cityPid;
	private String areaPid;

	public Integer getContractsId() {
		return contractsId;
	}

	public void setContractsId(Integer contractsId) {
		this.contractsId = contractsId;
	}

	public String getContractsCode() {
		return contractsCode;
	}

	public void setContractsCode(String contractsCode) {
		this.contractsCode = contractsCode;
	}

	public String getContractsTitle() {
		return contractsTitle;
	}

	public void setContractsTitle(String contractsTitle) {
		this.contractsTitle = contractsTitle;
	}

	public String getProvincePid() {
		return provincePid;
	}

	public void setProvincePid(String provincePid) {
		this.provincePid = provincePid;
	}

	public String getCityPid() {
		return cityPid;
	}

	public void setCityPid(String cityPid) {
		this.cityPid = cityPid;
	}

	public String getAreaPid() {
		return areaPid;
	}

	public void setAreaPid(String areaPid) {
		this.areaPid = areaPid;
	}

	public ContractsEntity(Integer contractsId, String contractsCode, String contractsTitle, String provincePid, String cityPid, String areaPid) {
		this.contractsId = contractsId;
		this.contractsCode = contractsCode;
		this.contractsTitle = contractsTitle;
		this.provincePid = provincePid;
		this.cityPid = cityPid;
		this.areaPid = areaPid;
	}



	public ContractsEntity(){

	}

	@Override
	public String toString() {
		return "ContractsEntity{" +
				"contractsId=" + contractsId +
				", contractsCode='" + contractsCode + '\'' +
				", contractsTitle='" + contractsTitle + '\'' +
				", provincePid='" + provincePid + '\'' +
				", cityPid='" + cityPid + '\'' +
				", areaPid='" + areaPid + '\'' +
				'}';
	}
}
