package com.scm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.scm.model.UserModel;
import com.scm.util.DbUtil;

public class UserModelDao {
	private Connection conn;
	public UserModelDao() {
		super();
	}
	public UserModelDao(Connection conn) {
		super();
		this.conn = conn;
	}

	/**
	 * 根据account查询usermode
	 * @param account
	 * @return
	 * @throws SQLException 
	 */
	public List<UserModel> selectUserModel(String account) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<UserModel> models = new ArrayList<>();
		try{
			String sql = "select u.modelcode,modelname from usermodel u,systemmodel s where u.modelcode = s.modelcode and account=?";
			conn = DbUtil.getConn();
			ps = conn.prepareStatement(sql);
			ps.setString(1, account);
			rs = ps.executeQuery();
			while(rs.next()){
				UserModel model = new UserModel();
				model.setAccount(account);
				model.setModelCode(rs.getInt("modelcode"));
				model.setModelName(rs.getString("modelname"));
				models.add(model);
			}
		}finally{
			DbUtil.close(conn, ps, rs);
		}
		return models;
	}
	/**
	 * 新增用户权限
	 * @param account
	 * @param modelCode
	 * @throws SQLException 
	 */
	public void insert(String account,int[] modelCode) throws SQLException{
		PreparedStatement ps = null;
		try{
			String sql = "insert into usermodel values (?,?)";
			ps = conn.prepareStatement(sql);
			for(int i:modelCode){
				ps.setString(1, account);
				ps.setInt(2, i);
				ps.addBatch();
			}
			ps.executeBatch();
		}finally{
			DbUtil.close(null, ps, null);
		}
	}
	/**
	 * 根据账户名删除权限
	 * @param account
	 * @return
	 * @throws SQLException
	 */
	public int deleteUserModel(String account) throws SQLException{
		PreparedStatement ps = null;
		try{
			String sql = "delete from usermodel where account=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, account);
			return ps.executeUpdate();
		}finally{
			DbUtil.close(null, ps, null);
		}
	}
	
	

	
	public Connection getConn() {
		return conn;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
	}
}
