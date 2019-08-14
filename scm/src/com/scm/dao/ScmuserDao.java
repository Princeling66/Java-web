package com.scm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.scm.model.Scmuser;
import com.scm.model.UserModel;
import com.scm.util.DbUtil;
import com.scm.util.StringUtil;

public class ScmuserDao extends BaseDao<Scmuser>{
	
	public ScmuserDao() {
	}
	
	public ScmuserDao(Connection conn) {
		this.conn = conn;
	}
	/**
	 * 查询用户是否拥有某个权限
	 * @param modelUri
	 * @param account
	 * @return
	 * @throws SQLException
	 */
	public boolean isAllow(String modelUri,String account) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			conn = DbUtil.getConn();
			String sql = "select * from scmuser s,usermodel u,systemmodel s2 where s.account = u.account and s2.modelcode=u.modelcode and s.account=? and s2.modeluri=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, account);
			ps.setString(2, modelUri);
			rs = ps.executeQuery();
			while(rs.next()){
				return true;
			}
			return false;
		}finally{
			DbUtil.close(conn, ps, rs);
		}
	}

	/**
	 * 分页查询时，根据条件查询数据
	 * @param queryCondition 把查询条件存放在map对象中
	 * @return
	 * @throws SQLException 
	 */
	public List<Scmuser> selectData(Map<String, String> queryCondition) throws SQLException{
		StringBuilder sql = new StringBuilder("select * ").append(generateSelectCondition(queryCondition));
		//分页查询条件
		sql.append(" limit ").append(queryCondition.get("startNo")).append(",").append(queryCondition.get("pageSize"));
		Statement st = null;
		ResultSet rs = null;
		List<Scmuser> users = new ArrayList<Scmuser>();
		
		try{
			st = conn.createStatement();
			rs = st.executeQuery(sql.toString());
			while(rs.next()){
				Scmuser user = new Scmuser(rs.getString("account"));
				user.setCreateDate(rs.getString("createdate"));
				user.setName(rs.getString("name"));
				user.setPassWord(rs.getString("password"));
				user.setStatus(rs.getInt("status"));
				users.add(user);
			}
		}finally{
			DbUtil.close(null, st, rs);
		}
		return users;
	}
	
	/**
	 * 生成查询条件
	 * @param queryCondition
	 * @return
	 */
	public String generateSelectCondition(Map<String, String> queryCondition){
		StringBuilder condition = new StringBuilder("from scmuser where 1=1");
		//账号查询
		String account = queryCondition.get("account");
		if(!StringUtil.isEmpty(account)){
			condition.append(" and s.account like '%").append(account).append("%'");
		}
		//姓名查询
		String name = queryCondition.get("name");
		if(!StringUtil.isEmpty(account)){
			condition.append(" and name like '%").append(name).append("%'");
		}
		//起始日期查询
		String startDate = queryCondition.get("startDate");
		if(!StringUtil.isEmpty(startDate)){
			condition.append(" and createdate >= '").append(startDate).append("'");
		}
		//结束日期查询
		String endDate = queryCondition.get("endDate");
		if(!StringUtil.isEmpty(endDate)){
			condition.append(" and createdate <= '").append(endDate).append(" 23:59:59'");
		}
		String status = queryCondition.get("status");
		if(!StringUtil.isEmpty(status) && !"-1".equals(status)){
			condition.append(" and status = ").append(status);
		}
		return condition.toString();
	}

	/**
	 * 新增用户
	 * @param user
	 * @throws SQLException
	 */
	public void insert(Scmuser user) throws SQLException{
		PreparedStatement ps = null;
		try{
			String sql = "insert into scmuser values (?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getAccount());
			ps.setString(2, user.getPassWord());
			ps.setString(3, user.getName());
			ps.setString(4, user.getCreateDate());
			ps.setInt(5, user.getStatus());
			ps.execute();
		}finally{
			DbUtil.close(null, ps, null);
		}
	}
	/**
	 * 删除用户
	 * @param account
	 * @return
	 * @throws SQLException
	 */
	public int delete(String account) throws SQLException{
		PreparedStatement ps = null;
		try{
			String sql = "delete from scmuser where account=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,account);
			return ps.executeUpdate();
		}finally{
			DbUtil.close(null, ps, null);
		}
	}
	/**
	 * 根据用户账号查询用户信息
	 * @param account
	 * @return
	 * @throws SQLException 
	 */
	public Scmuser selectByAccount(String account) throws SQLException{
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		Scmuser user = null;
		try{
			String sql = "select s.account,s.name,s.password,s.status,u.modelcode from scmuser s,usermodel u where s.account = u.account and s.account=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, account);
			rs = ps.executeQuery();
			List<UserModel> models = null;
			while(rs.next()){
				if(user == null){
					user = new Scmuser();
					models = new ArrayList<UserModel>();
					user.setModels(models);
					
					user.setAccount(rs.getString("account"));
					user.setName(rs.getString("name"));
					user.setPassWord(rs.getString("password"));
					user.setStatus(rs.getInt("status"));
				}
				UserModel model = new UserModel();
				model.setModelCode(rs.getInt("modelcode"));
				models.add(model);
			}
		}finally{
			DbUtil.close(null, ps, rs);
		}
		return user;
	}
	/**
	 * 修改用户信息
	 * @param user
	 * @return
	 * @throws SQLException 
	 */
	public int updateScmuser(Scmuser user) throws SQLException{
		PreparedStatement ps = null;
		try{
			String sql = "update scmuser set name=?,password=?,status=? where account=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getName());
			ps.setString(2, user.getPassWord());
			ps.setInt(3, user.getStatus());
			ps.setString(4, user.getAccount());
			return ps.executeUpdate();
		}finally{
			DbUtil.close(null, ps, null);
		}
	}
	/**
	 * 登录
	 * @param account
	 * @param password
	 * @return
	 * @throws SQLException 
	 */
	public Scmuser login(String account,String password) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Scmuser user = null;
		try{
			conn = DbUtil.getConn();
			ps = conn.prepareStatement("select * from scmuser where account=? and password=?");
			ps.setString(1, account);
			ps.setString(2, password);
			rs = ps.executeQuery();
			if(rs.next()){
				user = new Scmuser();
				user.setAccount(rs.getString("account"));
				user.setCreateDate(rs.getString("createdate"));
				user.setName(rs.getString("name"));
				user.setStatus(rs.getInt("status"));
			}
		}finally{
			DbUtil.close(conn, ps, rs);
		}
		return user;
	}
}
