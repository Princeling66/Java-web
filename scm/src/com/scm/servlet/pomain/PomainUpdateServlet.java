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
import com.scm.model.Pomain;
import com.scm.model.Scmuser;
import com.scm.service.PomainService;
@WebServlet("/main/pomain/pomainUpdate")
public class PomainUpdateServlet extends HttpServlet{
	private static final Logger LOGGER = Logger.getLogger(PomainUpdateServlet.class);
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pomainStr = req.getParameter("pomain");
		StringBuilder sb = new StringBuilder("【修改采购单】-->客户端参数："+pomainStr);
		PrintWriter out = resp.getWriter();
		try{
			Pomain pomain = JSON.parseObject(pomainStr, Pomain.class);
			Scmuser user = (Scmuser) req.getSession().getAttribute("scmuser");
			sb.append("用户"+user.getAccount()+"修改");//记录修改的人
			new PomainService().update(pomain);
			out.write("ok");
			LOGGER.info(sb.append("修改成功！"));
		}catch(Exception e){
			LOGGER.error(sb.append("异常"),e);
			out.write("fail");
		}
		out.flush();
		out.close();
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	

}
