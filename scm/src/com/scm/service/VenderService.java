package com.scm.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

import com.scm.dao.ScmuserDao;
import com.scm.dao.VenderDao;
import com.scm.model.Vender;
import com.scm.page.Page;
import com.scm.util.DbUtil;
import com.scm.util.PageUtil;

public class VenderService {
	
	/**
	 * 分页带条件查询vender
	 * @param queryCondition
	 * @param currentPage当前页码
	 * @return
	 * @throws SQLException 
	 */
	public Page<Vender> selectVender(Map<String, String> queryCondition,int currentPage) throws Exception{
		Connection conn = null;
		try {
			conn = DbUtil.getConn();
			VenderDao dao = new VenderDao(conn);
			return PageUtil.selectPage(queryCondition, currentPage, dao);
		}finally {
			DbUtil.close(conn, null, null);
		}
	}
	

}
