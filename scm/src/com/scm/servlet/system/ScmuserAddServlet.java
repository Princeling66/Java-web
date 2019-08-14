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
 * 新增用户功能
 * @author Administrator
 *
 */
@WebServlet("/main/system/scmuserAdd")
public class ScmuserAddServlet extends HttpServlet{
	private static final Logger LOGGER = Logger.getLogger(ScmuserAddServlet.class);
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String account = req.getParameter("account");
		String password = req.getParameter("password");
		String status = req.getParameter("status");
		String name = req.getParameter("name");
		String[] modelCode = req.getParameterValues("modelCode");
		
		//TODO 数据校验 
		
		PrintWriter out = resp.getWriter();
		try{
			Scmuser user = new Scmuser(account, password, name, DateUtil.currentTime(), Integer.parseInt(status));
			int[] mc = new int[modelCode.length]; 
			for(int i=0;i<modelCode.length;i++){
				mc[i] = Integer.parseInt(modelCode[i]);
			}
			//新增用户并且分配权限
			new ScmuserService().insertScmuser(user, mc);
			
			out.print("ok");
		}catch(MySQLIntegrityConstraintViolationException e){
			out.print("duplicate");
		}catch(Exception e){
			out.print("fail");
			LOGGER.error("服务端异常",e);
		}
		
		
		out.flush();
		out.close();
	}

}
