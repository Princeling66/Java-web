package com.scm.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scm.model.Scmuser;

public class LoginFilter implements Filter{


	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) arg0;
		HttpServletResponse resp = (HttpServletResponse) arg1;
		Scmuser user = (Scmuser) req.getSession().getAttribute("scmuser");
		if(user == null){
			PrintWriter out = resp.getWriter();
			out.print("<script>window.location.href='"+req.getContextPath()+"/login.jsp'</script>");
			out.flush();
			out.close();
		}else{
			arg2.doFilter(arg0, arg1);
		}
	}

}
