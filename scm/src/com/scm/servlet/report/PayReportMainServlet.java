package com.scm.servlet.report;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.scm.dao.PayRecordDao;
import com.scm.dao.PomainDao;

@WebServlet("/main/report/pay_main")
public class PayReportMainServlet extends HttpServlet{
	private static final Logger LOGGER = Logger.getLogger(PayReportMainServlet.class);
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String month = req.getParameter("month");
		if(month != null && month.matches("[12]\\d{3}-(0[1-9])|(1[012])")){
			 try {
				Map<String, Object> map = new PayRecordDao().report(month);
				req.setAttribute("mainInfo", map);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		req.getRequestDispatcher("/main/report/pay_report_main_layer.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
