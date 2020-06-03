package com.check.web.jdbc;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.mysql.cj.xdevapi.Statement;
import com.sun.jdi.connect.spi.Connection;



/**
 * Servlet implementation class test_servlet
 */
@WebServlet("/test_servlet")
public class test_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Resource(name="jdbc/user_database")
	private DataSource dataSource;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		java.sql.Connection myConn = null;
		java.sql.Statement myStmt = null;
		ResultSet myRs = null;
		try
		{
			myConn = dataSource.getConnection();
			String sql = "select * from user_info";
			myStmt =  myConn.createStatement();
			myRs = myStmt.executeQuery(sql);
			while(myRs.next()) {
				String region = "Region : " + myRs.getString("region");
				out.println(region);
				Integer app_id = myRs.getInt("app_id");
				out.println(app_id);
			}
			
		}
		catch(Exception exc) {
			exc.printStackTrace();
		}
	}

}
