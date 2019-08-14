package com.scm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import com.scm.model.Poitem;
import com.scm.util.DbUtil;

public class PoitemDao {
	
	private Connection conn;

	public PoitemDao(Connection conn) {
		super();
		this.conn = conn;
	}
	
	/**
	 * 新增采购单明细
	 * @param poitems
	 * @throws SQLException
	 */
	public void insert(List<Poitem> poitems,Long poid) throws SQLException{

		PreparedStatement ps = null;
		try{
			String sql = "insert into poitem (POID,ProductCode,UnitPrice,Num,UnitName,ItemPrice) values(?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			for(Poitem p:poitems){
				ps.setLong(1, poid);
				ps.setString(2, p.getProductCode());
				ps.setDouble(3, p.getUnitPrice());
				ps.setInt(4, p.getNum());
				ps.setString(5, p.getUnitName());
				ps.setDouble(6, p.getItemPrice());
				ps.addBatch();
			}
			ps.executeBatch();
		}finally{
			DbUtil.close(null, ps, null);
		}
	}
	/**
	 * 根据采购单id删除详情表
	 * @param poid
	 * @return
	 * @throws SQLException
	 */
	public int deleteByPoid(long  poid) throws SQLException{
		PreparedStatement ps = null;
		try{
			String sql = "delete from poitem where poid =?";
			ps = conn.prepareStatement(sql);
			ps.setLong(1, poid);
			return ps.executeUpdate();
		}finally{
			DbUtil.close(null, ps, null);
		}
	}
	/**
	 * 根据主单id查询详细信息
	 * @param poid
	 * @return
	 * @throws SQLException
	 */
	public List<Poitem> selectByPoid(long poid) throws SQLException{
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<Poitem> poitems = null;
		try{
			String sql = "select * from poitem where poid ="+poid;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				if(poitems == null){
					poitems = new LinkedList<>();
				}
				Poitem item = new Poitem();
				item.setPoId(poid);
				item.setProductCode(rs.getString("productcode"));
				item.setNum(rs.getInt("num"));
				poitems.add(item);
			}
		}finally{
			DbUtil.close(null, ps, rs);
		}
		return poitems;	
	}
	 

}
