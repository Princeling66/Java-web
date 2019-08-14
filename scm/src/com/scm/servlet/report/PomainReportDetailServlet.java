package com.scm.servlet.report;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.scm.dao.PomainDao;
import com.scm.model.Pomain;
import com.scm.page.Page;
import com.scm.service.PomainService;

@WebServlet("/main/report/pomain_detail")
public class PomainReportDetailServlet extends HttpServlet{
	private static final Logger LOGGER = Logger.getLogger(PomainReportDetailServlet.class);
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//获取当前页码参数
		String currentPageStr = req.getParameter("currentPage");
		int currentPage = 1;//默认当前页码为第一页
		try{
			currentPage = Integer.parseInt(currentPageStr);
		}catch(NumberFormatException e){
			currentPage = 1;//参数不是数字或者没有该参数时，默认访问第一页
		}
		
		String month = req.getParameter("month");
		Map<String, String> queryCondition = new HashMap<String, String>();
		queryCondition.put("type", "-1");
		queryCondition.put("startDate", month+"-01");
		queryCondition.put("endDate", month+"-31");
		
		try {
			Page<Pomain> page = new PomainService().selectPomain(queryCondition, currentPage);
			req.setAttribute("page", page);
			req.getRequestDispatcher("/main/report/pomain_report_detail_layer.jsp").forward(req, resp);
		} catch (Exception e) {
			LOGGER.error("月度采购单报表异常",e);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
