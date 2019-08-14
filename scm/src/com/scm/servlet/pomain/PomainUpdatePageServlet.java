package com.scm.servlet.pomain;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.scm.dao.PomainDao;
import com.scm.model.Pomain;
import com.scm.model.Scmuser;
import com.scm.service.PomainService;
@WebServlet("/main/pomain/pomainUptPage")
public class PomainUpdatePageServlet extends HttpServlet{
	private static final Logger LOGGER = Logger.getLogger(PomainUpdatePageServlet.class);
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String poidStr = req.getParameter("poid");
		PrintWriter out = resp.getWriter();
		try{
			long poid = Long.parseLong(poidStr);
			Pomain pomain = new PomainDao().selectByPoid(poid);
			req.setAttribute("pomain", pomain);
			req.getRequestDispatcher("/main/pomain/pomain_opt.jsp").forward(req, resp);
		}catch(Exception e){
			LOGGER.error("【修改采购单页面】-异常",e);
		}
		out.flush();
		out.close();
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	

}
