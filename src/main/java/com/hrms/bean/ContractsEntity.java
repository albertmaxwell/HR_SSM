package com.hrms.bean;

/**
 * @author 金海洋
 * @date 2019/4/7  -20:00
 */
public class ContractsEntity {

	private String contractsId;
	private String contractsCode;
	private String contractsTitle;

	public String getContractsId() {
		return contractsId;
	}

	public void setContractsId(String contractsId) {
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

	public ContractsEntity(){

	}


	public ContractsEntity(String contractsId, String contractsCode, String contractsTitle) {
		this.contractsId = contractsId;
		this.contractsCode = contractsCode;
		this.contractsTitle = contractsTitle;
	}

	@Override
	public String toString() {
		return "ContractsEntity{" +
				"contractsId='" + contractsId + '\'' +
				", contractsCode='" + contractsCode + '\'' +
				", contractsTitle='" + contractsTitle + '\'' +
				'}';
	}
}
