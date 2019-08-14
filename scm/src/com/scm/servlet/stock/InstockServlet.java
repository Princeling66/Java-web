package com.scm.servlet.stock;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.scm.model.Scmuser;
import com.scm.service.InstockService;


@WebServlet("/main/stock/instock")
public class InstockServlet extends HttpServlet{
	private static final Logger LOGGER = Logger.getLogger(InstockServlet.class);
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String poidStr = req.getParameter("poid");
		PrintWriter out = resp.getWriter();
		try{
			long poid = Long.parseLong(poidStr);
			
			Scmuser user = (Scmuser) req.getSession().getAttribute("scmuser");
			new InstockService().instock(poid, user.getAccount());
			out.print("ok");
		}catch(Exception e){
			out.print("fail");
			LOGGER.error("入库操作异常：poid->"+poidStr,e);
		}
		out.flush();
		out.close();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
