package com.scm.servlet.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.scm.dao.ScmuserDao;
import com.scm.model.Scmuser;
import com.scm.service.ScmuserService;
import com.scm.util.StringUtil;
/**
 * 显示修改的用户信息
 * @author Administrator
 *
 */
@WebServlet("/main/system/scmuserupdateinfo")
public class ScmuserUpdateInfoServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String account = req.getParameter("account");
		if(!StringUtil.isEmpty(account)){
			try {
				Map<String, Object> info = new ScmuserService().selectUpdateInfo(account);
				String r = JSON.toJSONString(info);
				resp.setContentType("text/plain;charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.print(r);
				out.flush();
				out.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
