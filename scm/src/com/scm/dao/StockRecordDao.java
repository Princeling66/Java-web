package com.scm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import com.scm.constants.ScmConfig;
import com.scm.model.Poitem;
import com.scm.model.StockRecord;
import com.scm.util.DateUtil;
import com.scm.util.DbUtil;

public class StockRecordDao {
	
	private Connection conn;

	public StockRecordDao(Connection conn) {
		super();
		this.conn = conn;
	}




	/**
	 * 入库时增加库存记录
	 * @param poitems 入库的产品明细
	 * @throws SQLException
	 */
	public void insert(List<Poitem> poitems,String account) throws SQLException{
		PreparedStatement ps = null;
		String instockTime = DateUtil.currentTime();
		try{
			String sql = "insert into stockrecord (productcode,ordercode,stocknum,stocktype,stocktime,createuser) values (?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			for(Poitem p:poitems){
				ps.setString(1, p.getProductCode());
				ps.setString(2, p.getPoId()+"");
				ps.setInt(3, p.getNum());
				ps.setInt(4, ScmConfig.PO_INSTOCK);
				ps.setString(5, instockTime);
				ps.setString(6, account);
				ps.addBatch();
			}
			ps.executeBatch();
		}finally{
			DbUtil.close(null, ps, null);
		}
	}

}
