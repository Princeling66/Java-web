package com.scm.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbUtil {
	
	//1.加载驱动
	static{
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println("找不到驱动程序");
		}
	}
	/**
	 * 获取数据库的连接对象
	 * @return
	 * @throws SQLException 
	 */
	public static Connection getConn() throws SQLException{
		String url = "jdbc:mysql://localhost:3306/scm_new?useSSL=false";
		String user = "root";
		String password = "123456";
		Connection conn = DriverManager.getConnection(url, user, password);
		return conn;
	}
	
	/**
	 * 关闭连接
	 * @param conn
	 * @param stmt
	 * @param rs
	 */
	public static void close(Connection conn,Statement stmt,ResultSet rs){
		try{
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		}catch(SQLException e){
			System.out.println("关闭数据库连接异常");
		}
	}
	

}
