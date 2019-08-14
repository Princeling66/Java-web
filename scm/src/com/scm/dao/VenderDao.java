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
import com.scm.model.Vender;
import com.scm.util.DbUtil;
import com.scm.util.StringUtil;

public class VenderDao extends BaseDao<Vender>{
	
	public VenderDao() {
	}
	
	public VenderDao(Connection conn) {
		this.conn = conn;
	}
	
	
	/**
	 * 查询所有供应商的编号和名称
	 * @return
	 * @throws SQLException
	 */
	public List<Vender> selectAll(Map<String, String> queryCondition) throws SQLException{
		List<Vender> venders = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			conn = DbUtil.getConn();
			StringBuilder sql = new StringBuilder("select * from vender where true");
			if(queryCondition != null){
				String venderCode = queryCondition.get("venderCode");
				if(!StringUtil.isEmpty(venderCode)){
					sql.append(" and vendercode like '%").append(venderCode).append("%'");
				}
				String name = queryCondition.get("name");
				if(!StringUtil.isEmpty(name)){
					sql.append(" and name like '%").append(name).append("%'");
				}
			}
			ps = conn.prepareStatement(sql.toString());
			rs = ps.executeQuery();
			while(rs.next()){
				Vender v = new Vender();
				v.setAddress(rs.getString("address"));
				v.setContactor(rs.getString("contactor"));
				v.setCreateDate(rs.getString("createdate"));
				v.setFax(rs.getString("fax"));
				v.setName(rs.getString("name"));
				v.setPassWord(rs.getString("password"));
				v.setPostCode(rs.getString("postcode"));
				v.setTel(rs.getString("tel"));
				v.setVenderCode(rs.getString("vendercode"));
				venders.add(v);
			}
		}finally{
			DbUtil.close(conn, ps, rs);
		}
		return venders;
	}
	
	/**
	 * 分页查询时，根据条件查询数据
	 * @param queryCondition 把查询条件存放在map对象中
	 * @return
	 * @throws SQLException 
	 */
	@Override
	public List<Vender> selectData(Map<String, String> queryCondition) throws SQLException{
		StringBuilder sql = new StringBuilder("select * ").append(generateSelectCondition(queryCondition));
		//分页查询条件
		sql.append(" limit ").append(queryCondition.get("startNo")).append(",").append(queryCondition.get("pageSize"));
		Statement st = null;
		ResultSet rs = null;
		List<Vender> venders = new ArrayList<Vender>();
		try{
			st = conn.createStatement();
			rs = st.executeQuery(sql.toString());
			while(rs.next()){
				Vender v = new Vender();
				v.setAddress(rs.getString("address"));
				v.setContactor(rs.getString("contactor"));
				v.setCreateDate(rs.getString("createdate"));
				v.setFax(rs.getString("fax"));
				v.setName(rs.getString("name"));
				v.setPassWord(rs.getString("password"));
				v.setPostCode(rs.getString("postcode"));
				v.setTel(rs.getString("tel"));
				v.setVenderCode(rs.getString("vendercode"));
				venders.add(v);
			}
		}finally{
			DbUtil.close(null, st, rs);
		}
		return venders;
	}
	
	
	/**
	 * 生成查询条件
	 * @param queryCondition
	 * @return
	 */
	@Override
	public String generateSelectCondition(Map<String, String> queryCondition){
		StringBuilder condition = new StringBuilder("from vender where 1=1");
		//名字查询
		String name = queryCondition.get("name");
		if(!StringUtil.isEmpty(name)){
			condition.append(" and name like '%").append(name).append("%'");
		}
		//编号查询
		String venderCode = queryCondition.get("venderCode");
		if(!StringUtil.isEmpty(venderCode)){
			condition.append(" and venderCode like '%").append(venderCode).append("%'");
		}
		return condition.toString();
	}
	
	

}
