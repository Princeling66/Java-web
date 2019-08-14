package com.scm.servlet.finance;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.log4j.Logger;

import com.scm.model.Scmuser;
import com.scm.service.PaymentService;
/**
 * 付款登记
 * @author Administrator
 *
 */
@WebServlet("/main/finance/payment")
public class PaymentServlet extends HttpServlet{
	private static final Logger LOGGER = Logger.getLogger(PaymentServlet.class);
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String poidStr = req.getParameter("poid");
		String type = req.getParameter("type");//付款登记类型 1-付款登记|尾款登记 2-预付款登记 
		PrintWriter out = resp.getWriter();
		try{
			long poid = Long.parseLong(poidStr);
			Scmuser user = (Scmuser) req.getSession().getAttribute("scmuser");
			new PaymentService().pay(poid, user.getAccount(), type);
			out.print("ok");
		}catch(Exception e){
			out.print("fail");
			LOGGER.error("入库操作异常：poid->"+poidStr,e);
		}
		out.flush();
		out.close();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		doGet(req, resp);
	}
}
