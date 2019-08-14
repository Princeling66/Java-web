package com.scm.servlet.pomain;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scm.model.Pomain;
import com.scm.model.Scmuser;
import com.scm.page.Page;
import com.scm.service.PomainService;
import com.scm.service.ScmuserService;

/**
 * 采购单查询 主页
 * @author Administrator
 *
 */
@WebServlet("/main/pomain/pomainQuery")
public class PomainQueryServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)  {
		//获取当前页码参数
		String currentPageStr = req.getParameter("currentPage");
		int currentPage = 1;//默认当前页码为第一页
		try{
			currentPage = Integer.parseInt(currentPageStr);
		}catch(NumberFormatException e){
			currentPage = 1;//参数不是数字或者没有该参数时，默认访问第一页
		}
		
		Map<String, String> queryCondition = new HashMap<String, String>();
		queryCondition.put("type", "-1");//类型为查询新增状态的采购单
		queryCondition.put("poId", req.getParameter("poId"));
		queryCondition.put("venderCode", req.getParameter("venderCode"));
		queryCondition.put("payType", req.getParameter("payType"));
		queryCondition.put("startDate", req.getParameter("startDate"));
		queryCondition.put("endDate", req.getParameter("endDate"));
		
		try {
			Page<Pomain> page = new PomainService().selectPomain(queryCondition, currentPage);
			req.setAttribute("page", page);
			req.getRequestDispatcher("/main/pomain/pomain_query_layer.jsp").forward(req, resp);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
				
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
}
