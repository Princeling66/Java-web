package com.scm.servlet.system;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scm.model.Scmuser;
import com.scm.page.Page;
import com.scm.service.ScmuserService;
/**
 * 用户管理首页
 * @author Administrator
 *
 */
@WebServlet("/main/system/scmuserShow")
public class ScmuserShowServlet extends HttpServlet{
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
		
		Map<String, String> queryCondition = new HashMap<String, String>();
		queryCondition.put("account", req.getParameter("account"));
		queryCondition.put("name", req.getParameter("name"));
		queryCondition.put("status", req.getParameter("status"));
		queryCondition.put("startDate", req.getParameter("startDate"));
		queryCondition.put("endDate", req.getParameter("endDate"));
		
		try {
			Page<Scmuser> page = new ScmuserService().selectScmuser(queryCondition, currentPage);
	
			req.setAttribute("page", page);
			req.getRequestDispatcher("/main/system/scmuser.jsp").forward(req, resp);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		
	}
	
}
