package com.scm.model;

/**
 *	供应商表模型 
 */
public class Vender {
	private String venderCode;//供应商编号
	private String name;//名称
	private String passWord;//密码
	private String contactor;//联系人
	private String address;//地址
	private String postCode;//邮政编码
	private String tel;//电话
	private String fax;//传真
	private String createDate;//创建日期
	
	public String getVenderCode() {
		return venderCode;
	}
	public void setVenderCode(String venderCode) {
		this.venderCode = venderCode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public String getContactor() {
		return contactor;
	}
	public void setContactor(String contactor) {
		this.contactor = contactor;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public Vender(String venderCode, String name, String passWord,
			String contactor, String address, String postCode, String tel,
			String fax, String createDate) {
		super();
		this.venderCode = venderCode;
		this.name = name;
		this.passWord = passWord;
		this.contactor = contactor;
		this.address = address;
		this.postCode = postCode;
		this.tel = tel;
		this.fax = fax;
		this.createDate = createDate;
	}
	public Vender() {
		super();
	}

	
}
