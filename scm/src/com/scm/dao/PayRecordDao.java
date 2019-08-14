package com.scm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.scm.constants.ScmConfig;
import com.scm.model.PayRecord;
import com.scm.util.DbUtil;

public class PayRecordDao {
	
	private Connection conn;
	
	public PayRecordDao(Connection conn) {
		super();
		this.conn = conn;
	}
	public PayRecordDao() {
	}


	/**
	 * 新增收付款记录
	 * @param payRecord
	 * @throws SQLException
	 */
	public void insert(PayRecord payRecord) throws SQLException {
		PreparedStatement ps = null;
		try{
			String sql = "insert into payrecord (pay_time,pay_price,account,ordercode,pay_type) values (?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, payRecord.getPayTime());
			ps.setDouble(2, payRecord.getPayPrice());
			ps.setString(3, payRecord.getAccount());
			ps.setString(4, payRecord.getOrdercode());
			ps.setInt(5, payRecord.getPayType());
			ps.execute();
		}finally{
			DbUtil.close(null, ps, null);
		}
	}

	
	//select sum(pay_price), count(*) ,(case pay_type when 2 then 'pay' when 4 then 'pay' when 1 then 'receive' when 3 then 'receive' end) type from payrecord group by type;
	public Map<String, Object> report(String month) throws SQLException{
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			conn = DbUtil.getConn();
			HashMap<String,Object> map = new HashMap<>();
			map.put("payPrice", 0);
			map.put("payCount", 0);
			map.put("receivePrice", 0);
			map.put("receiveCount", 0);
			String sql = 
					"select sum(pay_price) totalprice, count(*) totalcount ,(case pay_type when "+ScmConfig.PAY_MONEY+" then 'pay' when "+ScmConfig.PAY_PRE_MONEY+" then 'pay' when "+ScmConfig.RECEIVE_MONEY+" then 'receive' when "+ScmConfig.PAYTYPE_PRE_PAY+" then 'receive' end) type from payrecord "
					+ "where SUBSTR(pay_time FROM 1 FOR 7) = ?  group by type";
			ps = conn.prepareStatement(sql);
			ps.setString(1, month);
			rs = ps.executeQuery();
			List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
			
			if(rs.next()){
				String type = rs.getString("type");
				int count = rs.getInt("totalcount");
				double price = rs.getDouble("totalprice");
				if("pay".equals(type)) {
					map.put("payPrice", price);
					map.put("payCount", count);
				}else {
					map.put("receivePrice", price);
					map.put("receiveCount", count);
				}
			}
			return map;
		}finally{
			DbUtil.close(conn, ps, rs);
		}
	}
}
