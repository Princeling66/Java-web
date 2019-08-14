package com.scm.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.scm.constants.ScmConfig;
import com.scm.dao.PayRecordDao;
import com.scm.dao.PoitemDao;
import com.scm.dao.PomainDao;
import com.scm.dao.ProductDao;
import com.scm.dao.StockRecordDao;
import com.scm.exception.TransactionException;
import com.scm.model.PayRecord;
import com.scm.model.Poitem;
import com.scm.model.Pomain;
import com.scm.util.DateUtil;
import com.scm.util.DbUtil;

public class PaymentService {
	/**
	 * 付款登记操作
	 * @param poid
	 * @param account 操作人
	 * @param type 付款登记类型	 1-付款登记|尾款登记  	2-预付款登记 
	 * @throws SQLException 
	 */
	public void pay(long poid,String account,String type) throws SQLException{
		Connection conn = DbUtil.getConn();
		try {
			conn.setAutoCommit(false);
			PomainDao pomainDao = new PomainDao(conn);
			PayRecordDao payRecordDao = new PayRecordDao(conn);
			//根据id查询采购单
			Pomain pomain = pomainDao.selectByPoid(poid);
			
			PayRecord payRecord = new PayRecord();
			payRecord.setAccount(account);
			payRecord.setOrdercode(String.valueOf(poid));
			payRecord.setPayTime(DateUtil.currentTime());
			
			int r = 0;
			if("1".equals(type)){//付款
				r = pomainDao.pay(account, poid);
				payRecord.setPayType(ScmConfig.PAY_MONEY);
				if(ScmConfig.PAYTYPE_PRE_PAY == pomain.getPayType()) {//预付款到发货
					//收款金额为尾款
					payRecord.setPayPrice(pomain.getPoTotal()-pomain.getPrePayFee());
				}else {
					payRecord.setPayPrice(pomain.getPoTotal());
				}
			}else if("2".equals(type)){//付预付款
				r = pomainDao.prepay(account, poid);
				payRecord.setPayType(ScmConfig.PAY_PRE_MONEY);
				payRecord.setPayPrice(pomain.getPrePayFee());
				
			}else{
				throw new SQLException("付款登记类型不匹配：type="+type);
			}
			
			if(r != 1){
				throw new SQLException("付款登记操作失败：type="+type);
			}
			
			payRecordDao.insert(payRecord);
			conn.commit();
		}finally {
			DbUtil.close(conn, null, null);
		}
		
		
	
		
	}
	

}
