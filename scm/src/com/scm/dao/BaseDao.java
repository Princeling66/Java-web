package com.scm.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

import com.scm.util.DbUtil;

public abstract class BaseDao<T> {
	
	protected Connection conn;
	
	/**
	 * 分页查询需要实现的查询数据的方法
	 * @param queryCondition
	 * @return
	 * @throws SQLException
	 */
	public abstract List<T> selectData(Map<String, String> queryCondition) throws SQLException;
	
	/**
	 * 分页查询时，查询总条数
	 * @param queryCondition
	 * @return
	 * @throws SQLException
	 */
	public int selectCount(Map<String, String> queryCondition) throws SQLException{
		StringBuilder sql = new StringBuilder("select count(*) ").append(generateSelectCondition(queryCondition));
		Statement st = null;
		ResultSet rs = null;
		
		try{
			st = conn.createStatement();
			rs = st.executeQuery(sql.toString());
			if(rs.next()){
				return rs.getInt(1);
			}
		}finally{
			DbUtil.close(null, st, rs);
		}
		return 0;
	
	}
	/**
	 * 生成查询条件的方法
	 * @param queryCondition
	 * @return
	 */
	public abstract String generateSelectCondition(Map<String, String> queryCondition);

}
