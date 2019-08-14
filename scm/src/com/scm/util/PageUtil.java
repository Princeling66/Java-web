package com.scm.util;

import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.scm.dao.BaseDao;
import com.scm.dao.ScmuserDao;
import com.scm.model.Scmuser;
import com.scm.page.Page;

public class PageUtil {
	/**
	 * 分页查询功能
	 * @param queryCondition 查询条件
	 * @param currentPage 当前页码
	 * @param daoClass dao的大Class对象
	 * 该类必须包含int selectCount(Map<String, String> queryCondition) 方法，返回总条数
	 * 该类必须包含List<T> selectData(Map<String, String> queryCondition) 方法，返回数据
	 * @return
	 * @throws Exception
	 */
	public static <T> Page<T> selectPage(Map<String, String> queryCondition,int currentPage,BaseDao<T> dao) throws Exception{
		Page<T> page = new Page<T>();
		
		int totalSize = dao.selectCount(queryCondition);
		//设置总条数
		page.setTotalSize(totalSize);
		//设置总页码
		int totalPage = 1;
		if(page.getTotalSize()%page.getPageSize() == 0){
			totalPage = page.getTotalSize()/page.getPageSize();
		}else{
			totalPage = page.getTotalSize()/page.getPageSize()+1;
		}
		if(totalPage == 0){
			totalPage = 1;
		}
		page.setTotalPage(totalPage);
		//当前页验证
		currentPage = currentPage>totalPage?totalPage:currentPage;//当前页大于总页数
		currentPage = currentPage<=0?1:currentPage;//当前页<0
		page.setCurrentPage(currentPage);//设置当前页
		queryCondition.put("startNo", (currentPage-1)*page.getPageSize()+"");
		queryCondition.put("pageSize",page.getPageSize()+"");
		
		
		List<T> dataList = dao.selectData(queryCondition);
		page.setDataList(dataList);
		return page;
	
	}

}
