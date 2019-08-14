package com.scm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.scm.model.Poitem;
import com.scm.model.Product;
import com.scm.model.Scmuser;
import com.scm.model.Vender;
import com.scm.util.DbUtil;
import com.scm.util.StringUtil;

public class ProductDao extends BaseDao<Product>{
	
	public ProductDao() {
	}
	
	public ProductDao(Connection conn) {
		this.conn = conn;
	}
	
	/**
	 * 修改产品采购在途数
	 * @param products
	 * @param type 1-增加 2-减少
	 * @return
	 * @throws SQLException 
	 */
	public int[] updatePoNum(List<Poitem> poitems,int type) throws SQLException{
		PreparedStatement ps = null;
		try{
			String sql = "";
			if(type == 1){
				sql = "update product set ponum=ponum+? where productcode=? and ponum+? >=0";
			}else if(type == 2){
				sql = "update product set ponum=ponum-? where productcode=? and ponum-? >=0";
			}
			ps = conn.prepareStatement(sql);
			for(Poitem p:poitems){
				ps.setInt(1, p.getNum());
				ps.setString(2, p.getProductCode());
				ps.setInt(3, p.getNum());
				ps.addBatch();
			}
			return ps.executeBatch();
		}finally{
			DbUtil.close(null, ps, null);
		}
	}
	/**
	 * 入库操作 采购在途数减少 ，库存数增加
	 * @param poitems
	 * @return
	 * @throws SQLException 
	 */
	public int[] instock(List<Poitem> poitems) throws SQLException{

		PreparedStatement ps = null;
		try{
			String sql = "update product set ponum=ponum-?,num=num+? where productcode=? and ponum-?>=0";
			
			ps = conn.prepareStatement(sql);
			for(Poitem p:poitems){
				ps.setInt(1, p.getNum());
				ps.setInt(2, p.getNum());
				ps.setString(3, p.getProductCode());
				ps.setInt(4, p.getNum());
				ps.addBatch();
			}
			return ps.executeBatch();
		}finally{
			DbUtil.close(null, ps, null);
		}
	
	}
	
	
	
	
	
	
	/**
	 * 查询所有产品
	 * @return
	 * @throws SQLException
	 */
	public List<Product> selectAll(Map<String, String> queryCondition) throws SQLException{
		List<Product> products = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			conn = DbUtil.getConn();
			StringBuilder sql = new StringBuilder("select * from product where true");
			if(queryCondition != null){
				String productCode = queryCondition.get("productCode");
				if(!StringUtil.isEmpty(productCode)){
					sql.append(" and productCode like '%").append(productCode).append("%'");
				}
				String name = queryCondition.get("name");
				if(!StringUtil.isEmpty(name)){
					sql.append(" and name like '%").append(name).append("%'");
				}
			}
			ps = conn.prepareStatement(sql.toString());
			rs = ps.executeQuery();
			while(rs.next()){
				Product p = new Product();
				p.setName(rs.getString("name"));
				p.setProductCode(rs.getString("productcode"));
				p.setPrice(rs.getDouble("price"));
				p.setUnitName(rs.getString("unitname"));
				products.add(p);
			}
		}finally{
			DbUtil.close(conn, ps, rs);
		}
		return products;
	}
	
	/**
	 * 分页查询时，根据条件查询数据
	 * @param queryCondition 把查询条件存放在map对象中
	 * @return
	 * @throws SQLException 
	 */
	@Override
	public List<Product> selectData(Map<String, String> queryCondition) throws SQLException{
		StringBuilder sql = new StringBuilder("select * ").append(generateSelectCondition(queryCondition));
		//分页查询条件
		sql.append(" limit ").append(queryCondition.get("startNo")).append(",").append(queryCondition.get("pageSize"));
		Statement st = null;
		ResultSet rs = null;
		List<Product> products = new ArrayList<Product>();
		try{
			st = conn.createStatement();
			rs = st.executeQuery(sql.toString());
			while(rs.next()){
				Product p = new Product();
				//TODO 产品分页查询
			}
		}finally{
			DbUtil.close(null, st, rs);
		}
		return products;
	}
	
	
	/**
	 * 生成查询条件
	 * @param queryCondition
	 * @return
	 */
	@Override
	public String generateSelectCondition(Map<String, String> queryCondition){
		//TODO 产品分页查询 条件
		StringBuilder condition = new StringBuilder("from product where 1=1");
		/*//名字查询
		String name = queryCondition.get("name");
		if(!StringUtil.isEmpty(name)){
			condition.append(" and name like '%").append(name).append("%'");
		}
		//编号查询
		String venderCode = queryCondition.get("venderCode");
		if(!StringUtil.isEmpty(venderCode)){
			condition.append(" and venderCode like '%").append(venderCode).append("%'");
		}*/
		return condition.toString();
	}
	
	

}
