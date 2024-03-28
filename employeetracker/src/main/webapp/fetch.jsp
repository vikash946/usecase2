<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;
try {
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_time_tracker", "root", "Vikash246@");
	String sql = "SELECT * FROM add_task";
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Fetch Tasks</title>
<!-- Include Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h2 class="text-center">Task Table</h2>
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
				<tr id="row_<%=rs.getInt("task_id")%>">
					<td><%=rs.getInt("task_id")%></td>
					<td><%=rs.getString("employee_name")%></td>
					<td><%=rs.getString("project")%></td>
					<td><%=rs.getString("date_1")%></td>
					<td><%=rs.getString("start_time")%></td>
					<td><%=rs.getString("end_time")%></td>
					<td><%=rs.getString("task_category")%></td>
					<td><%=rs.getString("description")%></td>
					<td><button class='delete-btn'
							onclick='deleteRow(<%=rs.getInt("task_id")%>);'>Delete</button></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	<script>
        function deleteRow(taskId) {
            if (confirm("Are you sure you want to delete this task?")) {
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        // Remove the row from the table
                        var row = document.getElementById("row_" + taskId);
                        row.parentNode.removeChild(row);
                    }
                };
                xhttp.open("POST", "delete.jsp", true);
                xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhttp.send("task_id=" + taskId);
            }
        }
    </script>
</body>
</html>
<%
} catch (SQLException | ClassNotFoundException e) {
e.printStackTrace();
} finally {
try {
	if (rs != null)
		rs.close();
	if (stmt != null)
		stmt.close();
	if (conn != null)
		conn.close();
} catch (SQLException e) {
	e.printStackTrace();
}
}
%>
