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
@WebServlet("/main/pomain/pomainDel")
public class PomainDeleteServlet extends HttpServlet{
	private static final Logger LOGGER = Logger.getLogger(PomainDeleteServlet.class);
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String poidStr = req.getParameter("poid");
		PrintWriter out = resp.getWriter();
		try{
			long poid = Long.parseLong(poidStr);
			new PomainService().delete(poid);
			out.write("ok");
		}catch(Exception e){
			out.write("fail");
			LOGGER.error("【删除采购单】poi:"+poidStr+"异常",e);
		}
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	

}
