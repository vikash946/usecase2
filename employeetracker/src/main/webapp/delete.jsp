<%@ page
	import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// Get the task ID of the task to be deleted from the request parameter
String taskId = request.getParameter("task_id");

// Database connection parameters
String url = "jdbc:mysql://localhost:3306/employee_time_tracker";
String username = "root";
String password = "Vikash246@";

Connection connection = null;
Statement statement = null;

try {
	// Load the MySQL JDBC driver
	Class.forName("com.mysql.cj.jdbc.Driver");

	// Establish the database connection
	connection = DriverManager.getConnection(url, username, password);

	// Create a SQL statement
	statement = connection.createStatement();

	// Check if taskId is not null or empty before proceeding with the SQL query
	if (taskId != null && !taskId.isEmpty()) {
		// Define the SQL query to delete the task data
		String sql = "DELETE FROM add_task WHERE task_id='" + taskId + "'";

		// Execute the SQL query
		int rowsAffected = statement.executeUpdate(sql);

		// Check if the deletion was successful
		if (rowsAffected > 0) {
	out.println("<p>Task data deleted successfully!</p>");
		} else {
	out.println("<p>Failed to delete task data.</p>");
		}
	} else {
		out.println("<p>Task ID is null or empty.</p>");
	}
} catch (Exception e) {
	out.println("<p>Error occurred: " + e.getMessage() + "</p>");
} finally {
	// Close the database resources
	try {
		if (statement != null) {
	statement.close();
		}
		if (connection != null) {
	connection.close();
		}
	} catch (Exception ex) {
		out.println("<p>Error occurred while closing database resources: " + ex.getMessage() + "</p>");
	}
}
%>
