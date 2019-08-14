package com.scm.servlet.pomain;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.scm.model.Pomain;
import com.scm.page.Page;
import com.scm.service.PomainService;
/**
 * 采购单了结首页
 * @author Administrator
 *
 */
@WebServlet("/main/pomain/endIndex")
public class PomainEndIndexServlet extends HttpServlet{
	private static final Logger LOGGER = Logger.getLogger(PomainEndIndexServlet.class);
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) {

		//获取当前页码参数
		String currentPageStr = req.getParameter("currentPage");
		int currentPage = 1;//默认当前页码为第一页
		try{
			currentPage = Integer.parseInt(currentPageStr);
		}catch(NumberFormatException e){
			currentPage = 1;//参数不是数字或者没有该参数时，默认访问第一页
		}
		
		Map<String, String> queryCondition = new HashMap<String, String>();
		queryCondition.put("type", "2");//类型为采购单了结主界面
		queryCondition.put("payType", req.getParameter("payType"));
		
		try {
			Page<Pomain> page = new PomainService().selectPomain(queryCondition, currentPage);
			req.setAttribute("page", page);
			req.getRequestDispatcher("/main/pomain/pomain_end_layer.jsp").forward(req, resp);
		} catch (Exception e) {
			LOGGER.error("入库登记首页异常",e);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
		doGet(req, resp);
	}
}
