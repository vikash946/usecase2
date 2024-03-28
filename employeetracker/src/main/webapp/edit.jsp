<%@ page
	import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet"%>
<%@ page import="java.io.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

try {
	// Database connection parameters
	String url = "jdbc:mysql://localhost:3306/employee_time_tracker";
	String username = "root";
	String password = "Vikash246@";

	// Establishing database connection
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, username, password);

	// SQL query to fetch data from the add_task table
	String sql = "SELECT * FROM add_task";
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();

	// Displaying fetched data in a table
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update Task</title>
<!-- Include Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h2 class="text-center">Update Task</h2>
		<div class="btn-container">
			<a href="home.html" class="btn btn-primary home-btn">Home</a>
		</div>
		<table class="table table-striped">
			<thead class="thead-dark">
				<tr>
					<th>Task ID</th>
					<th>Employee Name</th>
					<th>Project</th>
					<th>Date</th>
					<th>Start Time</th>
					<th>End Time</th>
					<th>Task Category</th>
					<th>Description</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
				while (rs.next()) {
				%>
				<tr>
					<form action="modify.jsp" method="post">
						<input type="hidden" name="task_id"
							value="<%=rs.getInt("task_id")%>">
						<td><%=rs.getInt("task_id")%></td>
						<td><input type="text" name="employee_name"
							value="<%=rs.getString("employee_name")%>"></td>
						<td><input type="text" name="project"
							value="<%=rs.getString("project")%>"></td>
						<td><input type="date" name="date_1"
							value="<%=rs.getString("date_1")%>"></td>
						<td><input type="time" name="start_time"
							value="<%=rs.getString("start_time")%>"></td>
						<td><input type="time" name="end_time"
							value="<%=rs.getString("end_time")%>"></td>
						<td><input type="text" name="task_category"
							value="<%=rs.getString("task_category")%>"></td>
						<td><input type="text" name="description"
							value="<%=rs.getString("description")%>"></td>
						<td><input type="submit" value="Update"
							class="btn btn-primary"></td>
					</form>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>
<%
} catch (Exception e) {
e.printStackTrace();
} finally {
// Closing resources
try {
	if (rs != null)
		rs.close();
	if (stmt != null)
		stmt.close();
	if (conn != null)
		conn.close();
} catch (Exception ex) {
	ex.printStackTrace();
}
}
%>
