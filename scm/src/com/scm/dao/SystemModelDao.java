package com.scm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.scm.model.SystemModel;
import com.scm.util.DbUtil;

public class SystemModelDao {
	private Connection conn;
	
	public SystemModelDao() {
		super();
	}
	public SystemModelDao(Connection conn) {
		super();
		this.conn = conn;
	}
	public Connection getConn() {
		return conn;
	}
	public void setConn(Connection conn) {
		this.conn = conn;
	}



	/**
	 * 查询所有的权限
	 * @param account
	 * @return
	 * @throws SQLException 
	 */
	public List<SystemModel> selectAll() throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<SystemModel> models = new ArrayList<>();
		try{
			String sql = "select modelcode,modelname from systemmodel ";
			conn = DbUtil.getConn();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				SystemModel model = new SystemModel();
				model.setModelCode(rs.getInt("modelcode"));
				model.setModelName(rs.getString("modelname"));
				models.add(model);
			}
		}finally{
			DbUtil.close(conn, ps, rs);
		}
		return models;
	}
}
