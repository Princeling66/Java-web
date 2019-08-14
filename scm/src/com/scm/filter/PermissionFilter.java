package com.scm.filter;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.scm.dao.ScmuserDao;
import com.scm.model.Scmuser;

public class PermissionFilter implements Filter{


	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) arg0;
		String uri = req.getRequestURI();
		uri = uri.replace(req.getContextPath()+"/", "");//替换掉工程名
		//取剩下 路径的前两级目录
		String[] str = uri.split("/");
		StringBuilder modelUri = new StringBuilder("/");
		if(str.length >= 2){
			modelUri.append(str[0]).append("/").append(str[1]);
			if("/main/welcome.jsp".equals(modelUri.toString())){
				arg2.doFilter(arg0, arg1);
				return;
			}
			Scmuser user = (Scmuser) req.getSession().getAttribute("scmuser");
			try {
				boolean allow = new ScmuserDao().isAllow(modelUri.toString(), user.getAccount());
				if(allow){
					arg2.doFilter(arg0, arg1);
					return;
				}
				PrintWriter out = arg1.getWriter();
				out.print("<script>window.location.href='"+req.getContextPath()+"/nopermission.jsp'</script>");
				out.flush();
				out.close();
			} catch (SQLException e) {
				e.printStackTrace();
				PrintWriter out = arg1.getWriter();
				out.print("<script>window.location.href='"+req.getContextPath()+"/error.html'</script>");
				out.flush();
				out.close();
			}
			
		}
		
		
	}


}
