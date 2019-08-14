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
import com.scm.dao.UserModelDao;
import com.scm.model.UserModel;
import com.scm.util.StringUtil;

/**
 * 查看指定账号的权限
 * @author Administrator
 *
 */
@WebServlet("/main/system/usermodelShows")
public class UserModelShowServlet extends HttpServlet{
	private static final Logger LOGGER = Logger.getLogger(UserModelShowServlet.class);
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain;charset=utf-8");
		PrintWriter out = resp.getWriter();
		String account = req.getParameter("account");
		if(StringUtil.isEmpty(account)){
			out.println("error");
		}else{
			//查询用户的权限列表
			try {
				List<UserModel> models = new UserModelDao().selectUserModel(account);
				String str = JSON.toJSONString(models);//将对象转为json字符串
				out.print(str);
				LOGGER.debug("用户"+account+"的权限为："+str);
			} catch (SQLException e) {
				out.println("error");
				LOGGER.error("数据库异常",e);
			}catch (Exception e) {
				out.println("error");
				LOGGER.error("服务器异常",e);
			}
		}
		out.flush();
		out.close();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
}
