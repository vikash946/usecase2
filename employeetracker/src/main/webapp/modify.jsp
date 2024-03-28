<%@ page
	import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.io.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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

		<%
		// Retrieve parameters from the request
		String taskId = request.getParameter("task_id");
		String employeeName = request.getParameter("employee_name");
		String project = request.getParameter("project");
		String date = request.getParameter("date_1");
		String startTime = request.getParameter("start_time");
		String endTime = request.getParameter("end_time");
		String taskCategory = request.getParameter("task_category");
		String description = request.getParameter("description");

		// Database connection parameters
		String url = "jdbc:mysql://localhost:3306/employee_time_tracker";
		String username = "root";
		String password = "Vikash246@";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			// Load the MySQL JDBC driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Establish the database connection
			conn = DriverManager.getConnection(url, username, password);

			// Define the SQL query to update the task data
			String sql = "UPDATE add_task SET employee_name=?, project=?, date_1=?, start_time=?, end_time=?, task_category=?, description=? WHERE task_id=?";

			// Create a prepared statement
			pstmt = conn.prepareStatement(sql);

			// Set parameters for the prepared statement
			pstmt.setString(1, employeeName);
			pstmt.setString(2, project);
			pstmt.setString(3, date);
			pstmt.setString(4, startTime);
			pstmt.setString(5, endTime);
			pstmt.setString(6, taskCategory);
			pstmt.setString(7, description);
			pstmt.setString(8, taskId);

			// Execute the SQL update statement
			int rowsAffected = pstmt.executeUpdate();

			// Display a success message if the update was successful
			if (rowsAffected > 0) {
		%>
		<div class="alert alert-success" role="alert">Task updated
			successfully!</div>
		<%
		} else {
		%>
		<div class="alert alert-danger" role="alert">Failed to update
			task.</div>
		<%
		}
		} catch (Exception e) {
		// Display error message if an exception occurs
		out.println("<p>Error occurred: " + e.getMessage() + "</p>");
		} finally {
		// Close the database connection and prepared statement
		try {
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
		} catch (Exception ex) {
		// Display error message if an exception occurs while closing resources
		out.println("<p>Error occurred while closing database resources: " + ex.getMessage() + "</p>");
		}
		}
		%>
	</div>
</body>
</html>
