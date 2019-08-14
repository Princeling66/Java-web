package com.scm.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.scm.dao.PomainDao;
import com.scm.dao.ScmuserDao;
import com.scm.dao.SystemModelDao;
import com.scm.dao.UserModelDao;
import com.scm.model.Scmuser;
import com.scm.model.SystemModel;
import com.scm.model.UserModel;
import com.scm.page.Page;
import com.scm.util.DbUtil;
import com.scm.util.PageUtil;

public class ScmuserService {
	/**
	 * 删除用户并且删除其权限
	 * @param account
	 * @throws SQLException 
	 */
	public void deleteScmuser(String account) throws SQLException{
		Connection conn = null;
		try{
			conn = DbUtil.getConn();
			conn.setAutoCommit(false);
			//删除权限
			UserModelDao userModelDao = new UserModelDao(conn);
			int n = userModelDao.deleteUserModel(account);
			/*if(n == 0){
				conn.rollback();
				throw new SQLException();
			}*/
			//删除用户
			ScmuserDao scmuserDao = new ScmuserDao(conn);
			n = scmuserDao.delete(account);
			if(n != 1){
				conn.rollback();
				throw new SQLException();
			}
			conn.commit();
		}finally{
			DbUtil.close(conn, null, null);
		}
	}
	
	/**
	 * 新增用户 包括给用户分配权限
	 * @param user
	 * @param modelCode
	 * @throws SQLException 
	 */
	public void  insertScmuser(Scmuser user,int[] modelCode) throws SQLException{
		Connection conn = null;
		try{
			conn = DbUtil.getConn();
			conn.setAutoCommit(false);
			//新增用户
			ScmuserDao scmuserDao = new ScmuserDao(conn);
			scmuserDao.insert(user);
			//分配权限
			UserModelDao userModelDao = new UserModelDao(conn);
			userModelDao.insert(user.getAccount(), modelCode);
			conn.commit();
		}finally{
			DbUtil.close(conn, null, null);
		}
	}
	/**
	 * 显示修改页面信息
	 * 查询用户信息包括权限信息
	 * 查询所有的权限
	 * 结果封装在map中
	 * @param account
	 * @return
	 * @throws SQLException 
	 */
	public Map<String, Object> selectUpdateInfo(String account) throws SQLException{
		Map<String, Object> info = new HashMap<>();
		Connection conn = null;
		try{
			conn = DbUtil.getConn();
			ScmuserDao dao = new ScmuserDao(conn);
			Scmuser user = dao.selectByAccount(account);
			info.put("scmuser", user);
			//查询所有权限
			SystemModelDao modelDao = new SystemModelDao();
			List<SystemModel> models = modelDao.selectAll();
			info.put("models", models);
			
		}finally{
			DbUtil.close(conn, null, null);
		}
		return info;
	}
	/**
	 * 修改用户 包括修改用户权限
	 * @param user
	 * @param modelCode
	 * @throws SQLException 
	 */
	public void  updateScmuser(Scmuser user,int[] modelCode) throws SQLException{
		Connection conn = null;
		try{
			conn = DbUtil.getConn();
			conn.setAutoCommit(false);
			//新增用户
			ScmuserDao scmuserDao = new ScmuserDao(conn);
			int r = scmuserDao.updateScmuser(user);
			if(r != 1){
				conn.rollback();//修改失败 回滚
				throw new SQLException();
			}
			UserModelDao modelDao = new UserModelDao(conn);
			//先删除掉用户原有权限 再新增新的权限
			modelDao.deleteUserModel(user.getAccount());
			modelDao.insert(user.getAccount(), modelCode);
			
			conn.commit();
		}finally{
			DbUtil.close(conn, null, null);
		}
	}
	
	
	/**
	 * 分页带条件查询scmuser
	 * @param queryCondition
	 * @param currentPage当前页码
	 * @return
	 * @throws SQLException 
	 */
	public Page<Scmuser> selectScmuser(Map<String, String> queryCondition,int currentPage) throws Exception{
		Connection conn = null;
		try {
			conn = DbUtil.getConn();
			ScmuserDao dao = new ScmuserDao(conn);
			return PageUtil.selectPage(queryCondition, currentPage, dao);
		}finally {
			DbUtil.close(conn, null, null);
		}
	}
	

}
