package com.hrms.bean;

/**
 * @author 金海洋
 * @date 2019/4/6  -12:07
 */
public class RightsMan {

	private Integer rightsId;
	private String  rightsName;
	private String  rightsAccount;
	private String  rightsPassword;

	public Integer getRightsId() {
		return rightsId;
	}

	public void setRightsId(Integer rightsId) {
		this.rightsId = rightsId;
	}

	public String getRightsName() {
		return rightsName;
	}

	public void setRightsName(String rightsName) {
		this.rightsName = rightsName;
	}

	public String getRightsAccount() {
		return rightsAccount;
	}

	public void setRightsAccount(String rightsAccount) {
		this.rightsAccount = rightsAccount;
	}

	public String getRightsPassword() {
		return rightsPassword;
	}

	public void setRightsPassword(String rightsPassword) {
		this.rightsPassword = rightsPassword;
	}


	  public RightsMan() {
	}



	public RightsMan(Integer rightsId, String rightsName, String rightsAccount, String rightsPassword) {
		this.rightsId = rightsId;
		this.rightsName = rightsName;
		this.rightsAccount = rightsAccount;
		this.rightsPassword = rightsPassword;
	}

	@Override
	public String toString() {
		return "RightsMan{" +
				"rightsId=" + rightsId +
				", rightsName='" + rightsName + '\'' +
				", rightsAccount='" + rightsAccount + '\'' +
				", rightsPassword='" + rightsPassword + '\'' +
				'}';
	}
}



