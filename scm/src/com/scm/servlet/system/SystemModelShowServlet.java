package com.scm.servlet.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.scm.dao.SystemModelDao;
import com.scm.model.SystemModel;
import com.scm.util.StringUtil;
@WebServlet("/main/system/systemmodels")
public class SystemModelShowServlet extends HttpServlet{

	private static final Logger LOGGER = Logger.getLogger(SystemModelShowServlet.class);
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain;charset=utf-8");
		PrintWriter out = resp.getWriter();
		//查询所有权限
		try {
			 List<SystemModel> models = new SystemModelDao().selectAll();
			String str = JSON.toJSONString(models);//将对象转为json字符串
			out.print(str);
		} catch (SQLException e) {
			out.println("error");
			LOGGER.error("数据库异常",e);
		}catch (Exception e) {
			out.println("error");
			LOGGER.error("服务器异常",e);
		}
		out.flush();
		out.close();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

}
