package com.scm.servlet.pomain;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scm.dao.VenderDao;
import com.scm.model.Pomain;
import com.scm.model.Scmuser;
import com.scm.model.Vender;
import com.scm.page.Page;
import com.scm.service.PomainService;
import com.scm.service.ScmuserService;
import com.scm.service.VenderService;

/**
 * 供应商选择框
 * @author Administrator
 *
 */
@WebServlet("/main/pomain/venderSelect")
public class VenderSelectServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, String> queryCondition = new HashMap<String, String>();
		queryCondition.put("venderCode", req.getParameter("venderCode"));
		queryCondition.put("name", req.getParameter("name"));
		try {
			List<Vender> venders = new VenderDao().selectAll(queryCondition);
			req.setAttribute("venders", venders);
			req.getRequestDispatcher("/main/pomain/vender_select_layer.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
		}
				
				
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
}
