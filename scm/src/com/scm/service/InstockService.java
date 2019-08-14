package com.scm.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.scm.dao.PoitemDao;
import com.scm.dao.PomainDao;
import com.scm.dao.ProductDao;
import com.scm.dao.StockRecordDao;
import com.scm.exception.TransactionException;
import com.scm.model.Poitem;
import com.scm.util.DbUtil;

public class InstockService {
	/**
	 * 入库操作
	 * @param poid
	 * @param account 操作人
	 * @throws SQLException 
	 */
	public void instock(long poid,String account) throws SQLException{
		
		Connection conn = null;
		try{
			conn = DbUtil.getConn();
			conn.setAutoCommit(false);
			PomainDao pomainDao = new PomainDao(conn);
			PoitemDao poitemDao = new PoitemDao(conn);
			ProductDao productDao = new ProductDao(conn);
			StockRecordDao stockRecordDao = new StockRecordDao(conn);
			
			//1.修改采购单记录
			int n = pomainDao.instock(account, poid);
			if(n != 1){
				throw new TransactionException("修改采购单主单入库信息失败");
			}
			
			//2.根据poid查询采购单详情
			List<Poitem> poitems = poitemDao.selectByPoid(poid);
			//3.修改采购在途数及增加库存数
			int[] r = productDao.instock(poitems);
			for(int i:r){
				if(i != 1){
					throw new TransactionException("修改采购在途数及增加库存数失败");
				}
			}
			//4.增加库存变化记录
			stockRecordDao.insert(poitems, account);
			
			conn.commit();
		}finally{
			DbUtil.close(conn, null, null);
		}
		
		
	}
	

}
