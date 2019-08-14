package com.scm.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.scm.dao.PoitemDao;
import com.scm.dao.PomainDao;
import com.scm.dao.ProductDao;
import com.scm.exception.TransactionException;
import com.scm.model.Poitem;
import com.scm.model.Pomain;
import com.scm.model.Product;
import com.scm.page.Page;
import com.scm.util.DbUtil;
import com.scm.util.PageUtil;

/**
 * 采购单业务
 * @author Administrator
 *
 */
public class PomainService {
	/**
	 * 新增采购单
	 * @param pomain
	 * @throws SQLException
	 */
	public void insert(Pomain pomain) throws SQLException{
		Connection conn = null;
		try{
			conn = DbUtil.getConn();
			conn.setAutoCommit(false);
			PomainDao pomainDao = new PomainDao(conn);
			PoitemDao poitemDao = new PoitemDao(conn);
			ProductDao productDao = new ProductDao(conn);
			
			//新增主单信息
			pomainDao.insert(pomain);
			//新增明细单信息
			poitemDao.insert(pomain.getPoitems(), pomain.getPoId());
			//增加采购在途数
			int[] n = productDao.updatePoNum(pomain.getPoitems(), 1);
			for(int i:n){
				if(i != 1){
					throw new TransactionException("修改采购在途数失败！");
				}
			}
			conn.commit();
		}finally{
			DbUtil.close(conn, null, null);
		}
	}
	/**
	 * 修改采购单
	 * @param pomain
	 * @throws SQLException
	 */
	public void update(Pomain pomain) throws SQLException {
		Connection conn = null;
		try{
			conn = DbUtil.getConn();
			conn.setAutoCommit(false);
			PomainDao pomainDao = new PomainDao(conn);
			PoitemDao poitemDao = new PoitemDao(conn);
			ProductDao productDao = new ProductDao(conn);
			//修改主单
			int n = pomainDao.update(pomain);
			if(n != 1){
				throw new TransactionException("修改采购单主单失败！");
			}
			//修改原来明细的在途数
			List<Poitem> items = poitemDao.selectByPoid(pomain.getPoId());
			if(items == null){
				throw new TransactionException("没有查到采购单"+pomain.getPoId()+"详情");
			}
			int[] j = productDao.updatePoNum(items, 2);
			for(int i:j){
				if(i != 1){
					throw new TransactionException("修改产品在途数时失败");
				}
			}
			//删除原来的明细单
			n = poitemDao.deleteByPoid(pomain.getPoId());
			if(n == 0){
				throw new TransactionException("删除采购明细单失败！");
			}
			
			//新增新的明细单
			poitemDao.insert(pomain.getPoitems(), pomain.getPoId());
			//增加采购在途数
			j = productDao.updatePoNum(pomain.getPoitems(), 1);
			for(int i:j){
				if(i != 1){
					throw new TransactionException("增加产品在途数时失败");
				}
			}
			conn.commit();
		}finally{
			DbUtil.close(conn, null, null);
		}
	}
	/**
	 * 删除采购单
	 * @param poid
	 * @throws SQLException
	 */
	public void delete(long poid) throws SQLException {
		Connection conn = null;
		try{
			conn = DbUtil.getConn();
			conn.setAutoCommit(false);
			PomainDao pomainDao = new PomainDao(conn);
			PoitemDao poitemDao = new PoitemDao(conn);
			ProductDao productDao = new ProductDao(conn);
			//修改产品的在途数
			List<Poitem> items = poitemDao.selectByPoid(poid);
			if(items == null){
				throw new TransactionException("没有查到采购单"+poid+"详情");
			}
			int[] j = productDao.updatePoNum(items, 2);
			for(int i:j){
				if(i != 1){
					throw new TransactionException("修改产品在途数时失败");
				}
			}
			
			//删除详情
			int n = poitemDao.deleteByPoid(poid);
			if(n == 0){
				throw new SQLException();
			}
			
			n = pomainDao.deleteByPoid(poid);
			if(n != 1){
				throw new SQLException();
			}
			conn.commit();
		}finally{
			DbUtil.close(conn, null, null);
		}
	}
	
	/**
	 * 分页查询采购单
	 * @param queryCondition
	 * @param currentPage
	 * queryCondition中必须包含参数 type
	 *  type = 1 新添采购单主界面
	 *  type = 2 了结采购单主界面
	 *  type = -1 查询采购单主界面
	 *  type = 3 入库登记主界面
	 *  type = 4 付款登记主界面
	 * @return
	 * @throws Exception
	 */
	public Page<Pomain> selectPomain(Map<String, String> queryCondition,int currentPage) throws Exception{
		Connection conn = null;
		try {
			conn = DbUtil.getConn();
			PomainDao dao = new PomainDao(conn);
			return PageUtil.selectPage(queryCondition, currentPage, dao);
		}finally {
			DbUtil.close(conn, null, null);
		}
	}


}
