package com.scm.page;

import java.util.List;
import java.util.Map;

public class Page<T> {
	private int currentPage = 1;//当前页
	private int totalPage = 1;//总页码
	private int pageSize = 2;//每页显示多少条数据
	private int totalSize;//总条数
	private List<T> dataList;//数据
	private Map<String, String> queryCondition;//查询条件
	
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalSize() {
		return totalSize;
	}
	public void setTotalSize(int totalSize) {
		this.totalSize = totalSize;
	}
	
	public List<T> getDataList() {
		return dataList;
	}
	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}
	public Map<String, String> getQueryCondition() {
		return queryCondition;
	}
	public void setQueryCondition(Map<String, String> queryCondition) {
		this.queryCondition = queryCondition;
	}
}
