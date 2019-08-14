package com.scm.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scm.constants.AccountStatus;
import com.scm.dao.ScmuserDao;
import com.scm.model.Scmuser;
@WebServlet("/login")
public class LoginServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//1. 获取参数
		String account = req.getParameter("account");
		String password = req.getParameter("password");
		//2.数据校验
		if(account == null || password == null ||
				account.matches("\\s*") || account.matches("\\s*")) {
			resp.sendRedirect(req.getContextPath()+"/login.jsp");
			return;
		}
		
		try {
			//3.登录验证
			Scmuser user = new ScmuserDao().login(account, password);
			if(user != null){
				if(user.getStatus() == AccountStatus.UNLOCK){
					req.getSession().setAttribute("scmuser",user);
					resp.sendRedirect(req.getContextPath()+"/main/welcome.jsp");//跳转至首页
					return;
				}else{
					req.setAttribute("info", "账户被锁定，请联系管理员！");
				}
			}else{
				req.setAttribute("info", "用户名不存在或者密码错误！");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			req.setAttribute("info", "服务端异常，请联系管理员！");
		}
		req.getRequestDispatcher("/login.jsp").forward(req, resp);
	}

}
