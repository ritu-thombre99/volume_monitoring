<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Scanner"%> 
<%@page import="java.io.*"%>
<%@page import="javax.swing.*"%>
<% 
String id = request.getParameter("userid");
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3307/";
String database = "user_database";
String userid = "root";
String password = "ritu";
java.sql.Connection connection = null;
java.sql.Statement statement = null;
ResultSet resultSet = null;
String sql = null;
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
%>
<html>
<head>
	<title>ACTIVITY</title>
		<link rel="stylesheet" type="text/css" href="Css.css">
		<style>
		ul {
		    list-style-type: none;
		    margin: 0;
		    padding: 0;
		    overflow: hidden;
		    background-color: #333;
		    position: sticky;
		    top: 0;
		}	
		li {
		    float: left;
		}
	
		li a {
		    display: block;
		    color: white;
		    text-align: center;
    		    padding: 14px 16px;
    		    text-decoration: none;
		}

		li a:hover {
		    background-color: #111;
		}

		.active {
		    background-color: #4CAF50;
		}
		</style>
</head>
<body>
	<h1 align='center'>WELCOME</h1>
	<form action="monitor_backend.jsp">
	<table>
		<tr>
			<td>
				ACTIVITY
			</td>
			<td>
				<b>CLICK</b> 
			</td>
		</tr>
		<% // Daily USERS tracking for a month %>
		<tr>
			<td>
				<b>Daily User Tracking for a month</b>
			</td>
			<td>
				<input type="radio" value="daily_user_tracking" name="select_monitor">
			</td>
			<td>
				Enter month in mm/yyyy format :
			</td>
			<td>
				<input type = "text" name="month_user_tracking"> 
			</td>
		</tr>
		<% // Hourly USERS tracking for a day %>
		<tr>
			<td>
				<b>Hourly User Tracking for a day</b>
			</td>
			<td>
				<input type="radio" value="hourly_user_tracking" name="select_monitor"> 
			</td>
			<td>
				Enter date in dd/mm/yyyy format :
			</td>
			<td>
				<input type = "text" name="date_user_tracking"> 
			</td>
		</tr>
		<% // Regional USERS tracking %>
		<tr>
			<td>
				<b>Regional User Tracking</b>
			</td>
			<td>
				<input type="radio" value="regional_user_tracking" name="select_monitor"> 
			</td> 
		</tr>
		<% // Daily REGIONAL USERS tracking for a month %>
		<tr>
			<td>
				<b>Daily Regional User Tracking for a month</b>
			</td>
			<td>
				<input type="radio" value="daily_regional_user_tracking" name="select_monitor">
			</td>
			<td>
				Enter month in mm/yyyy format :
			</td>
			<td>
				<input type = "text" name="month_region_user_tracking"> 
			</td>
			<td>
				Select region : 
				<select name="region_day_activity">
		        <%  
			        connection = DriverManager.getConnection(connectionUrl+database, userid, password);
			        statement=connection.createStatement();
			        sql = "select distinct region from user_info";
			        resultSet = statement.executeQuery(sql) ;
		        	while(resultSet.next()){ %>
		            <option><%= resultSet.getString("region")%></option>
		        <% } %>
        </select>
			</td>
		</tr>
		<% // Hourly REGIONAL USERS tracking for a day %>
		<tr>
			<td>
				<b>Hourly Regional User Tracking for a day</b>
			</td>
			<td>
				<input type="radio" value="hourly_regional_user_tracking" name="select_monitor"> 
			</td>
			<td>
				Enter date in dd/mm/yyyy format :
			</td>
			<td>
				<input type = "text" name="date_region_user_tracking"> 
			</td>
			<td>
				Select region : 
				<select name="region_hour_activity">
		        <%  
			        connection = DriverManager.getConnection(connectionUrl+database, userid, password);
			        statement=connection.createStatement();
			        sql = "select distinct region from user_info";
			        resultSet = statement.executeQuery(sql) ;
		        	while(resultSet.next()){ %>
		            <option><%= resultSet.getString("region")%></option>
		        <% } %>
        </select>
			</td>
		</tr>
		<% // Daily ACTIVITIES tracking for a month %>
		<tr>
			<td>
				<b>Daily Activity Tracking for a month</b>
			</td>
			<td>
				<input type="radio" value="daily_activity_tracking" name="select_monitor"> 
			</td>
			<td>
				Enter month in mm/yyyy format :
			</td>
			<td>
				<input type = "text" name="month_activity_tracking"> 
			</td>
			<td>
				Select activity : 
				<select name="day_activity">
		        <%  
			        connection = DriverManager.getConnection(connectionUrl+database, userid, password);
			        statement=connection.createStatement();
			        sql = "select distinct activity from user_activity";
			        resultSet = statement.executeQuery(sql) ;
		        	while(resultSet.next()){ %>
		            <option><%= resultSet.getString("activity")%></option>
		        <% } %>
        </select>
			</td>
		</tr>
		<% // Hourly ACTIVITIES tracking for a day %>
		<tr>
			<td>
				<b>Hourly Activity Tracking for a day</b>
			</td>
			<td>
				<input type="radio" value="hourly_activity_tracking" name="select_monitor"> 
			</td>
			<td>
				Enter date in dd/mm/yyyy format :
			</td>
			<td>
				<input type = "text" name="date_activity_tracking"> 
			</td>
			<td>
				Select activity : 
				<select name="hour_activity">
		        <%  
			        connection = DriverManager.getConnection(connectionUrl+database, userid, password);
			        statement=connection.createStatement();
			        sql = "select distinct activity from user_activity";
			        resultSet = statement.executeQuery(sql) ;
		        	while(resultSet.next()){ %>
		            <option><%= resultSet.getString("activity")%></option>
		        <% } %>
        </select>
			</td>
		</tr>
		<% // REGIONAL ACTIVITIES tracking for a day %>
	</table>
	<input type="submit" value="Submit">
	<input type="reset" value="Reset">
	</form>
</body>
</html>