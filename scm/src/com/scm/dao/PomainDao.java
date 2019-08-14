package com.scm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.scm.constants.ScmConfig;
import com.scm.model.Poitem;
import com.scm.model.Pomain;
import com.scm.util.DateUtil;
import com.scm.util.DbUtil;
import com.scm.util.StringUtil;

/**
 * 采购单信息
 * @author Administrator
 *
 */
public class PomainDao extends BaseDao<Pomain>{
	private static final Logger LOGGER = Logger.getLogger(PomainDao.class);
	public PomainDao(Connection conn) {
		super();
		this.conn = conn;
	}
	
	
	public PomainDao() {
	}
	
	/**
	 * 根据采购单id删除
	 * @param poid
	 * @return
	 * @throws SQLException
	 */
	public int deleteByPoid(long  poid) throws SQLException{
		PreparedStatement ps = null;
		try{
			String sql = "delete from pomain where poid =?";
			ps = conn.prepareStatement(sql);
			ps.setLong(1, poid);
			return ps.executeUpdate();
		}finally{
			DbUtil.close(null, ps, null);
		}
	}
	/**
	 * 采购单月度报表
	 * @param month
	 * @return
	 * @throws SQLException 
	 */
	public Map<String, Object> report(String month) throws SQLException{
		Map<String, Object> map = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			conn = DbUtil.getConn();
			String sql = 
					"select "
							+ "count(*) totalnum,"//总记录条数
							+ "count(endtime) endtotalnum,"//已了结数
							+ "sum(pototal) pototal,"//总金额
							+ "sum("
								+ "case "
									+ "when paytime is not null then pototal "
									+ "when paytime is null and PrePayTime is not null then PrePayFee "
									+ "else 0 "
								+ "end"
							+ ")totalpay"//已付款金额
					+ " from pomain "
					+ "where "
					+ "SUBSTR(CreateTime FROM 1 FOR 7) = ?";
			LOGGER.debug("【月度采购报表】-"+month+"-->"+sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1, month);
			rs = ps.executeQuery();
			if(rs.next()){
				map = new HashMap<>();
				map.put("totalNum", rs.getInt("totalnum"));//采购单总数
				map.put("endTotalNum", rs.getInt("endtotalnum"));//已了结采购单数量
				map.put("pototal", rs.getInt("pototal"));//采购单总金额
				map.put("totalpay", rs.getInt("totalpay"));//已付款总金额
			}
			return map;
		}finally{
			DbUtil.close(conn, ps, rs);
		}
	}
	
	/**
	 * 入库操作
	 * 修改采购单的 状态 及操作人和操作时间
	 * @param account
	 * @param poid
	 * @return
	 * @throws SQLException 
	 */
	public int instock(String account,long poid) throws SQLException{
		PreparedStatement ps = null;
		try{
			String sql = "update pomain set stocktime=?,stockuser=?,status=? where poid=? and status = (case paytype when "+ScmConfig.PAYTYPE_LAST_PAY+" then "+ScmConfig.ADD+" when "+ScmConfig.PAYTYPE_FIRST_PAY+" then "+ScmConfig.PAY+" when "+ScmConfig.PAYTYPE_PRE_PAY+" then "+ScmConfig.PREPAY+" end)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, DateUtil.currentTime());
			ps.setString(2, account);
			ps.setInt(3, ScmConfig.RECEIVE);
			ps.setLong(4, poid);
			return ps.executeUpdate();
		}finally{
			DbUtil.close(null, ps, null);
		}
	}
	

	
	/**
	 * 付款登记或者是尾款登记
	 * @param account
	 * @param poid
	 * @return
	 * @throws SQLException 
	 */
	public int pay(String account,long poid) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		try{
			conn = DbUtil.getConn();
			String sql = "update pomain set paytime=?,payuser=?,status=? where poid=? "
					+ "and status = (case paytype when "+ScmConfig.PAYTYPE_LAST_PAY+" then "+ScmConfig.RECEIVE+" when "+ScmConfig.PAYTYPE_FIRST_PAY+" then "+ScmConfig.ADD+" when "+ScmConfig.PAYTYPE_PRE_PAY+" then "+ScmConfig.RECEIVE+" end)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, DateUtil.currentTime());
			ps.setString(2, account);
			ps.setInt(3, ScmConfig.PAY);
			ps.setLong(4, poid);
			return ps.executeUpdate();
		}finally{
			DbUtil.close(conn, ps, null);
		}
	}
	/**
	 * 预付款登记
	 * @param account
	 * @param poid
	 * @return
	 * @throws SQLException 
	 */
	public int prepay(String account,long poid) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		try{
			conn = DbUtil.getConn();
			String sql = "update pomain set prepaytime=?,prepayuser=?,status=? where poid=? "
					+ "and status = (case paytype  when "+ScmConfig.PAYTYPE_PRE_PAY+" then "+ScmConfig.ADD+" end)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, DateUtil.currentTime());
			ps.setString(2, account);
			ps.setInt(3, ScmConfig.PREPAY);
			ps.setLong(4, poid);
			return ps.executeUpdate();
		}finally{
			DbUtil.close(conn, ps, null);
		}
	}
	/**
	 * 了结采购单
	 * @param account
	 * @param poid
	 * @return
	 * @throws SQLException
	 */
	public int end(String account,long poid) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		try{
			conn = DbUtil.getConn();
			String sql = "update pomain set endtime=?,enduser=?,status=? where poid=? "
					+ "and status = (case paytype when "+ScmConfig.PAYTYPE_LAST_PAY+" then "+ScmConfig.PAY+" when "+ScmConfig.PAYTYPE_FIRST_PAY+" then "+ScmConfig.RECEIVE+" when "+ScmConfig.PAYTYPE_PRE_PAY+" then "+ScmConfig.PAY+" end)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, DateUtil.currentTime());
			ps.setString(2, account);
			ps.setInt(3, ScmConfig.END);
			ps.setLong(4, poid);
			return ps.executeUpdate();
		}finally{
			DbUtil.close(conn, ps, null);
		}
	}
	
	/**
	 * 根据id查看采购单详情
	 * @param poid
	 * @return
	 * @throws SQLException 
	 */
	public Pomain selectByPoid(long poid) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Pomain pomain = null;
		try{
			String sql = "select m.*,i.*,p.name productName,v.name venderName from pomain m,poitem i,product p,vender v where m.poid = i.poid and p.productCode=i.productCode "
					+ "and v.vendercode = m.vendercode and m.poid=?";
			conn = DbUtil.getConn();
			ps = conn.prepareStatement(sql);
			ps.setLong(1, poid);
			rs = ps.executeQuery();
			List<Poitem> poitems = null;
			
			while(rs.next()){
				if(pomain == null){
					pomain = new Pomain();
					poitems = new ArrayList<>();
					pomain.setPoitems(poitems);
					
					pomain.setPoId(rs.getLong("poid"));//订单id
					pomain.setCreateTime(rs.getString("createtime"));//创建时间
					pomain.setVenderName(rs.getString("venderName"));//供应商名字
					pomain.setVenderCode(rs.getString("venderCode"));
					pomain.setAccount(rs.getString("account"));//创建用户
					pomain.setTipFee(rs.getDouble("tipfee"));//附加费用
					pomain.setPoTotal(rs.getDouble("pototal"));//采购单总价格
					pomain.setProductTotal(rs.getDouble("producttotal"));//采购单产品总价格
					pomain.setPayType(rs.getInt("paytype"));//付款方式
					pomain.setPrePayFee(rs.getDouble("prepayfee"));//最低预付款金额
					pomain.setRemark(rs.getString("remark"));
					pomain.setEndTime(rs.getString("endTime"));
					pomain.setEndUser(rs.getString("endUser"));
					pomain.setPayTime(rs.getString("payTime"));
					pomain.setPayUser(rs.getString("payUser"));
					pomain.setPrePayTime(rs.getString("prePayTime"));
					pomain.setPrePayUser(rs.getString("prePayUser"));
					pomain.setStockTime(rs.getString("stockTime"));//入库时间
					pomain.setStockUser(rs.getString("stockUser"));//入库记录人
					pomain.setStatus(rs.getInt("status"));
				}
				Poitem item = new Poitem();
				item.setProductCode(rs.getString("productCode"));
				item.setItemPrice(rs.getDouble("itemPrice"));
				item.setNum(rs.getInt("num"));
				item.setProductName(rs.getString("productName"));//产品名称
				item.setUnitName(rs.getString("unitName"));
				item.setUnitPrice(rs.getDouble("unitPrice"));
				poitems.add(item);
			}
			return pomain;
		}finally{
			DbUtil.close(conn, ps, rs);
		}
	}
	
	/**
	 * 新增 采购单主单
	 * @param pomain
	 * @throws SQLException 
	 */
	public void insert(Pomain pomain) throws SQLException{
		PreparedStatement ps = null;
		try{
			String sql = "insert into pomain (POID,VenderCode,Account,CreateTime,TipFee,ProductTotal,POTotal,PayType,PrePayFee,Status,Remark) values(?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setLong(1, pomain.getPoId());
			ps.setString(2, pomain.getVenderCode());
			ps.setString(3, pomain.getAccount());
			ps.setString(4, pomain.getCreateTime());
			ps.setDouble(5, pomain.getTipFee());//附加费用
			ps.setDouble(6, pomain.getProductTotal());//产品总价格
			ps.setDouble(7, pomain.getProductTotal()+pomain.getTipFee());//采购单总价格
			ps.setInt(8, pomain.getPayType());
			ps.setDouble(9, pomain.getPrePayFee());//预付款金额
			ps.setInt(10, ScmConfig.ADD);
			ps.setString(11, pomain.getRemark());
			ps.execute();
		}finally{
			DbUtil.close(null, ps, null);
		}
	}
	/**
	 * 修改采购单
	 * @param pomain
	 * @throws SQLException
	 */
	public int update(Pomain pomain) throws SQLException{
		PreparedStatement ps = null;
		try{
			String sql = "update pomain set VenderCode=?,TipFee=?,ProductTotal=?,POTotal=?,PayType=?,PrePayFee=?,Remark=? where poid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, pomain.getVenderCode());
			ps.setDouble(2, pomain.getTipFee());//附加费用
			ps.setDouble(3, pomain.getProductTotal());//产品总价格
			ps.setDouble(4, pomain.getProductTotal()+pomain.getTipFee());//采购单总价格
			ps.setInt(5, pomain.getPayType());
			ps.setDouble(6, pomain.getPrePayFee());//预付款金额
			ps.setString(7, pomain.getRemark());
			ps.setLong(8, pomain.getPoId());
			return ps.executeUpdate();
		}finally{
			DbUtil.close(null, ps, null);
		}
	}
	
	
	
	
	
	
	/**
	 * 采购单分页显示
	 * @param queryCondition
	 * 
	 * queryCondition中必须包含参数 type
	 *  type = 1 新添采购单主界面
	 *  type = 2 了结采购单主界面
	 *  type = -1 查询采购单主界面
	 *  type = 3 入库登记主界面
	 *  type = 4 付款登记主界面
	 *  
	 * 
	 * @return
	 * @throws SQLException
	 */
	@Override
	public List<Pomain> selectData(Map<String, String> queryCondition) throws SQLException{

		StringBuilder sql = new StringBuilder("select * ").append(generateSelectCondition(queryCondition));
		//分页查询条件
		sql.append(" limit ").append(queryCondition.get("startNo")).append(",").append(queryCondition.get("pageSize"));
		LOGGER.debug("【采购单分页查询】-->"+sql);
		
		Statement st = null;
		ResultSet rs = null;
		List<Pomain> pomains = new ArrayList<Pomain>();
		
		try{
			st = conn.createStatement();
			rs = st.executeQuery(sql.toString());
			while(rs.next()){
				Pomain pomain = new Pomain();
				pomain.setPoId(rs.getLong("poid"));//订单id
				pomain.setCreateTime(rs.getString("createtime"));//创建时间
				pomain.setVenderName(rs.getString("name"));//供应商名字
				pomain.setAccount(rs.getString("account"));//创建用户
				pomain.setTipFee(rs.getDouble("tipfee"));//附加费用
				pomain.setPoTotal(rs.getDouble("pototal"));//采购单总价格
				pomain.setProductTotal(rs.getDouble("producttotal"));//采购单产品总价格
				pomain.setPayType(rs.getInt("paytype"));//付款方式
				pomain.setPrePayFee(rs.getDouble("prepayfee"));//最低预付款金额
				pomain.setStatus(rs.getInt("status"));
				pomains.add(pomain);
			}
		}finally{
			DbUtil.close(null, st, rs);
		}
		return pomains;
	
	}

	
	/**
	 * 拼接查询条件
	 * @param queryCondition
	 * @return
	 */
	@Override
	public String generateSelectCondition(Map<String, String> queryCondition) {
		StringBuilder sb = new StringBuilder();
		sb.append("from pomain p,vender v where p.vendercode = v.vendercode ");
		//类型
		String type = queryCondition.get("type");
		if("-1".equals(type)){//查询采购单主界面
			
		}else if("1".equals(type)){//新增采购单主界面
			sb.append(" and status = "+ScmConfig.ADD);
		}else if("2".equals(type)){//采购单了结主菜单
			sb.append(" and (");
			sb.append("(paytype="+ScmConfig.PAYTYPE_LAST_PAY+" and status ="+ScmConfig.PAY+")");
			sb.append(" or ");
			sb.append("(paytype="+ScmConfig.PAYTYPE_FIRST_PAY+" and status ="+ScmConfig.RECEIVE+")");
			sb.append(" or ");
			sb.append("(paytype="+ScmConfig.PAYTYPE_PRE_PAY+" and status ="+ScmConfig.PAY+")");
			sb.append(")");
		}else if("3".equals(type)){//入库登记主界面
			sb.append(" and (");
			sb.append("(paytype="+ScmConfig.PAYTYPE_LAST_PAY+" and status ="+ScmConfig.ADD+")");
			sb.append(" or ");
			sb.append("(paytype="+ScmConfig.PAYTYPE_FIRST_PAY+" and status ="+ScmConfig.PAY+")");
			sb.append(" or ");
			sb.append("(paytype="+ScmConfig.PAYTYPE_PRE_PAY+" and status ="+ScmConfig.PREPAY+")");
			sb.append(")");
		}else if("4".equals(type)){//付款登记主界面
			sb.append(" and (");
			sb.append("(paytype="+ScmConfig.PAYTYPE_LAST_PAY+" and status ="+ScmConfig.RECEIVE+")");
			sb.append(" or ");
			sb.append("(paytype="+ScmConfig.PAYTYPE_FIRST_PAY+" and status ="+ScmConfig.ADD+")");
			sb.append(" or ");
			sb.append("(paytype="+ScmConfig.PAYTYPE_PRE_PAY+" and (status ="+ScmConfig.ADD+" or status ="+ScmConfig.RECEIVE+"))");
			sb.append(")");
		}else{
			sb.append(" and false");//如果type类型不对 则什么都查不出来
			return sb.toString();
		}
		//编号
		String poid = queryCondition.get("poid");
		if(!StringUtil.isEmpty(poid)){
			sb.append(" and poid like '%").append(poid).append("%'");
		}
		//供应商编号
		String venderCode = queryCondition.get("venderCode");
		if(!StringUtil.isEmpty(venderCode)){
			sb.append(" and v.vendercode ='").append(venderCode).append("'");
		}
		//付款方式
		String payType = queryCondition.get("payType");
		if(!StringUtil.isEmpty(payType)){
			sb.append(" and payType ='").append(payType).append("'");
		}
		//起始日期查询
		String startDate = queryCondition.get("startDate");
		if(!StringUtil.isEmpty(startDate)){
			sb.append(" and createtime >= '").append(startDate).append("'");
		}
		//结束日期查询
		String endDate = queryCondition.get("endDate");
		if(!StringUtil.isEmpty(endDate)){
			sb.append(" and createtime <= '").append(endDate).append(" 23:59:59'");
		}
		return sb.toString();
	}
}
