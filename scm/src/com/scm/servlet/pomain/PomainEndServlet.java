package com.scm.servlet.pomain;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.log4j.Logger;

import com.scm.dao.PomainDao;
import com.scm.model.Scmuser;
import com.scm.service.PaymentService;
/**
 * 采购单了结
 * @author Administrator
 *
 */
@WebServlet("/main/pomain/end")
public class PomainEndServlet extends HttpServlet{
	private static final Logger LOGGER = Logger.getLogger(PomainEndServlet.class);
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String poidStr = req.getParameter("poid");
		PrintWriter out = resp.getWriter();
		try{
			long poid = Long.parseLong(poidStr);
			Scmuser user = (Scmuser) req.getSession().getAttribute("scmuser");
			int n = new PomainDao().end(user.getAccount(), poid);
			if(n == 1) {
				out.print("ok");
			}else {
				out.print("fail");
			}
		}catch(Exception e){
			out.print("fail");
			LOGGER.error("采购单了结操作异常：poid->"+poidStr,e);
		}
		out.flush();
		out.close();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		doGet(req, resp);
	}
}
