
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
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
java.sql.Connection connection = null;
java.sql.Statement statement = null;
ResultSet resultSet = null;
%>
<!DOCTYPE html>
<html>
<body>
<%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
String sql =null;
String theCommand = request.getParameter("select_monitor");
String month=null;
String date = null;
String region=null;
// route to the appropriate method
switch (theCommand) {

case "daily_user_tracking":
	//Scanner sc = new Scanner(System.in);
	//System.out.println("Enter a month in mm format: "); 
	//s = sc.nextLine();   
	month = request.getParameter("month_user_tracking");
	sql ="with Q1 as"+
			"(select app_id  as app_id,SUBSTR(log_date, 1, 2) as day,SUBSTR(log_date,4,7) as month from user_info)" +
			"select month as month,day as day,count(*) as user_count from Q1 group by day order by day;"; 
	resultSet = statement.executeQuery(sql);
	if(resultSet == null){
		%>
		<h2>Daily User Tracking for month <%= month  %></h2>
		<table border="1">
		<tr>
		<td>count</td>
		</tr>
		<tr>
		<td><%= 0  %></td>
		</tr>
		</table>
		<%
		}
	else{
		%>
		<h2>Daily User Tracking for month <%= month  %></h2>
		<table border="1">
		<tr>
		<td>Day</td>
		<td>user count</td>
		</tr>
		<% 
	while(resultSet.next()){
		if(resultSet.getString("month").equals(month))
		{
		%>
		<tr>
		<td><%=resultSet.getString("day") %></td>
		<td><%=resultSet.getInt("user_count") %></td>
		</tr>
		
		<%
		} 
		}
		%>
		</table>
	<% 
	}
	break;
	
case "hourly_user_tracking":
	//Scanner sc = new Scanner(System.in);
	//System.out.println("Enter a month in mm format: "); 
	//s = sc.nextLine();   
	date = request.getParameter("date_user_tracking"); 
	sql ="with Q1 as"+
			"(select log_date as log_date,app_id  as app_id,SUBSTR(log_time, 1, 2) as hour from user_info)" +
			"select log_date as date,hour as hour,count(*) as user_count from Q1 group by hour order by hour;"; 
	resultSet = statement.executeQuery(sql);
	if(resultSet == null){
		%>
		<h2>Hourly User Tracking for date <%= date  %></h2>
		<table border="1">
		<tr>
		<td>count</td>
		</tr>
		<tr>
		<td><%= 0  %></td>
		</tr>
		</table>
		<%
		}
	else{
		%>
		<h2>Hourly User Tracking for date <%= date  %></h2>
		<table border="1">
		<tr>
		<td>Hour</td>
		<td>user count</td>
		</tr>
		<% 
	while(resultSet.next()){
		if(resultSet.getString("date").equals(date))
		{
	%>
	<tr>
	<td><%=resultSet.getString("hour") %></td>
	<td><%=resultSet.getInt("user_count") %></td>
	</tr>
	<% 
		}
	}%>
		</table>
	<% 
	}
	break;
	
case "regional_user_tracking":
	//Scanner sc = new Scanner(System.in);
	//System.out.println("Enter a month in mm format: "); 
	//s = sc.nextLine();   
	sql ="select region as region,count(*) as user_count from user_info group by region;"; 
	resultSet = statement.executeQuery(sql);
	if(resultSet == null){
		%>
		<h2>Regional User Tracking</h2>
		<table border="1">
		<tr>
		<td>count</td>
		</tr>
		<tr>
		<td><%= 0  %></td>
		</tr>
		</table>
		<%
		}
	else{
		%>
		<h2>Regional User Tracking</h2>
		<table border="1">
		<tr>
		<td>Region</td>
		<td>user count</td>
		</tr>
		<% 
	while(resultSet.next()){
	%>
	<tr>
	<td><%=resultSet.getString("region") %></td>
	<td><%=resultSet.getInt("user_count") %></td>
	</tr>
	<%
	}
	%>
	</table>
	<% 
	}
	break;

case "daily_regional_user_tracking":
	//Scanner sc = new Scanner(System.in);
	//System.out.println("Enter a month in mm format: "); 
	//s = sc.nextLine();   
	month = request.getParameter("month_region_user_tracking");
	region = request.getParameter("region_day_activity");
	sql ="with Q1 as"+
			"(select SUBSTR(log_date,4,7)  as month,SUBSTR(log_date, 1, 2) as day,region as region from user_info)" +
			"select month as month,region as region,day as day,count(*) as user_count from Q1 group by day order by day;"; 
	resultSet = statement.executeQuery(sql);
	if(resultSet == null){
		
		%>
		<h2>Daily Regional User Tracking for month <%= month  %> and region <%= region %></h2>
		<table border="1">
		<tr>
		<td>count</td>
		</tr>
		<tr>
		<td><%= 0  %></td>
		</tr>
		</table>
		<%
		}
	else{
		%>
		<h2>Daily Regional User Tracking for month <%= month  %> and region <%= region %></h2>
		<table border="1">
		<tr>
		<td>Day</td>
		<td>user count</td>
		</tr>
		<% 
	while(resultSet.next()){
		if(resultSet.getString("region").equals(region) && resultSet.getString("month").equals(month))
		{
		%>
		<tr>
		<td><%=resultSet.getString("day") %></td>
		<td><%=resultSet.getInt("user_count") %></td>
		</tr>
		<%
		}
		}	
		%>
		</table>
		<% 
	} 
	break;
	
	
case "hourly_regional_user_tracking":
	//Scanner sc = new Scanner(System.in);
	//System.out.println("Enter a month in mm format: "); 
	//s = sc.nextLine();   
	date = request.getParameter("date_region_user_tracking");
	region = request.getParameter("region_hour_activity");
	sql ="with Q1 as"+
		"(select SUBSTR(log_date,1,10) as log_date,region as region,app_id  as app_id,SUBSTR(log_time, 1, 2) as hour from user_info )" +
		"select log_date as date,region as region,hour as hour,count(*) as user_count from Q1 group by hour order by hour;"; 
	resultSet = statement.executeQuery(sql);
	if(resultSet == null){
		%>
		<h2>Hourly Regional User Tracking for date <%= date  %> and region <%= region %></h2>
		<table border="1">
		<tr>
		<td>count</td>
		</tr>
		<tr>
		<td><%= 0  %></td>
		</tr>
		</table>
		<%
		}
	else{
		%>
		<h2>Hourly Regional User Tracking for date <%= date  %> and region <%= region %></h2>
		<table border="1">
		<tr>
		<td>Hour</td>
		<td>user count</td>
		</tr>
		<% 
	while(resultSet.next()){
		if(resultSet.getString("region").equals(region) && resultSet.getString("date").equals(date))
		{
		%>
		<tr>
		<td><%=resultSet.getString("hour") %></td>
		<td><%=resultSet.getInt("user_count") %></td>
		</tr>
		<%
		}
	}
		%>
		</table>
	<% 
	}
	
	break;
	
case "daily_activity_tracking":
	//Scanner sc = new Scanner(System.in);
	//System.out.println("Enter a month in mm format: "); 
	//s = sc.nextLine();   
	month = request.getParameter("month_activity_tracking");
	String day_activity = request.getParameter("day_activity");
	sql ="with Q1 as"+
			"(select SUBSTR(log_date,4,7) as month,activity  as activity,SUBSTR(log_date, 1, 2) as day from user_activity)" +
			"select month as month,activity as activity,day as day,count(*) as user_count from Q1 group by day;"; 
	resultSet = statement.executeQuery(sql);
	if(resultSet == null){
		%>
		<h2>Daily Activity Tracking for month <%= month  %> for activity <%= day_activity %></h2>
		<table border="1">
		<tr>
		<td>count</td>
		</tr>
		<tr>
		<td><%= 0  %></td>
		</tr>
		</table>
		<%
		}
	else{
		%>
		<h2>Daily Activity Tracking for month <%= month  %> for activity <%= day_activity %></h2>
		<table border="1">
		<tr>
		<td>Day</td>
		<td>user count</td>
		</tr>
		<% 
	while(resultSet.next()){
	if(resultSet.getString("activity").equals(day_activity) && resultSet.getString("month").equals(month))
	{
	%>
	<tr>
	<td><%=resultSet.getString("day") %></td>
	<td><%=resultSet.getInt("user_count") %></td>
	</tr>
	<%
	}
	}
	%>
	</table>
	<% 
	}
	
	break;
	
case "hourly_activity_tracking":
	//Scanner sc = new Scanner(System.in);
	//System.out.println("Enter a month in mm format: "); 
	//s = sc.nextLine();   
	date = request.getParameter("date_activity_tracking");
	String hour_activity = request.getParameter("hour_activity");
	sql ="with Q1 as"+
			"(select log_date as log_date,activity as activity,SUBSTR(log_time, 1, 2) as hour from user_activity)" +
			"select log_date as date,activity as activity,hour as hour,count(*) as user_count from Q1 group by hour;"; 
	resultSet = statement.executeQuery(sql);
	if(resultSet == null){
		%>
		<h2>Hourly Activity Tracking for date <%= date  %> and activity <%= hour_activity %></h2>
		<table border="1">
		<tr>
		<td>count</td>
		</tr>
		<tr>
		<td><%= 0  %></td>
		</tr>
		</table>
		<%
		}
	else{
		%>
		<h2>Hourly Activity Tracking for date <%= date  %> and activity <%= hour_activity %></h2>
		<table border="1">
		<tr>
		<td>Hour</td>
		<td>user count</td>
		</tr>
		<% 
	while(resultSet.next()){
		if(resultSet.getString("activity").equals(hour_activity) && resultSet.getString("date").equals(date))
		{
	%>
	<tr>
	<td><%=resultSet.getString("hour") %></td>
	<td><%=resultSet.getInt("user_count") %></td>
	</tr>
	<%
	}
	}
	%>
	</table>
	<% 
	}
	break;
	
	
default :
	System.out.println("Select");
	}
connection.close();
}
catch (Exception e) {
e.printStackTrace();
}
%>
</body>
</html>