package com.scm.servlet.pomain;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.scm.dao.VenderDao;
import com.scm.model.Vender;
@WebServlet("/main/pomain/venderlist")
public class VenderListServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			List<Vender> venders = new VenderDao().selectAll(null);
			resp.setContentType("text/plain;charset=utf8");
			PrintWriter out = resp.getWriter();
			out.print(JSON.toJSONString(venders));
			out.flush();
			out.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
