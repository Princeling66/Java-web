package com.scm.servlet.finance;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.scm.model.Pomain;
import com.scm.page.Page;
import com.scm.service.PomainService;
/**
 * 付款登记首页
 * @author Administrator
 *
 */
@WebServlet("/main/finance/paymentIndex")
public class PaymentIndexServlet extends HttpServlet{
	private static final Logger LOGGER = Logger.getLogger(PaymentIndexServlet.class);
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) {

		//获取当前页码参数
		String currentPageStr = req.getParameter("currentPage");
		int currentPage = 1;//默认当前页码为第一页
		try{
			currentPage = Integer.parseInt(currentPageStr);
		}catch(NumberFormatException e){
			currentPage = 1;//参数不是数字或者没有该参数时，默认访问第一页
		}
		
		Map<String, String> queryCondition = new HashMap<String, String>();
		queryCondition.put("type", "4");//类型为付款登记 主界面
		queryCondition.put("payType", req.getParameter("payType"));
		
		try {
			Page<Pomain> page = new PomainService().selectPomain(queryCondition, currentPage);
			req.setAttribute("page", page);
			req.getRequestDispatcher("/main/finance/payment_layer.jsp").forward(req, resp);
		} catch (Exception e) {
			LOGGER.error("付款登记首页异常",e);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
		doGet(req, resp);
	}
}
