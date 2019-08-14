package com.scm.servlet.system;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
import com.scm.model.Scmuser;
import com.scm.service.ScmuserService;
import com.scm.util.DateUtil;
/**
 * 删除用户功能
 * @author Administrator
 *
 */
@WebServlet("/main/system/scmuserDelete")
public class ScmuserDeleteServlet extends HttpServlet{
	private static final Logger LOGGER = Logger.getLogger(ScmuserDeleteServlet.class);
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String account = req.getParameter("account");
		PrintWriter out = resp.getWriter();
		try{
			if(account != null){
				//删除用户及权限
				new ScmuserService().deleteScmuser(account);
				out.print("ok");
			}else{
				out.print("fail");
				LOGGER.warn("account为null");
			}
		}catch(Exception e){
			out.print("fail");
			LOGGER.error("服务端异常",e);
		}
		
		
		out.flush();
		out.close();
	}

}
