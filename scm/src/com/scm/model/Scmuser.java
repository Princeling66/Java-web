package com.scm.model;

import java.util.List;

/**
 *	用户表 
 */
public class Scmuser {
	private String account;//用户账号
	private String passWord;//密码
	private String name;//姓名
	private String createDate;//添加日期
	private Integer status;//锁定状态
	//用户权限模型
	private List<UserModel> models;
	
	
	public Scmuser() {
		super();
	}
	public Scmuser(String account) {
		super();
		this.account = account;
	}
	public Scmuser(String account, String passWord, String name, String createDate, Integer status) {
		super();
		this.account = account;
		this.passWord = passWord;
		this.name = name;
		this.createDate = createDate;
		this.status = status;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public List<UserModel> getModels() {
		return models;
	}
	public void setModels(List<UserModel> models) {
		this.models = models;
	}
	
}
