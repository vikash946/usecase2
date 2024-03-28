<%@ page import="java.sql.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
<title>Task Hours Report</title>

<style>
/* Style for the table */
canvas {
	width: 400px;
	height: 400px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

/* Style for table header */
th {
	background-color: #f2f2f2;
	text-align: left;
	padding: 8px;
}

/* Alternate row background color */
tr:nth-child(even) {
	background-color: #f9f9f9;
}

/* Style for table data */
td {
	padding: 8px;
}

/* Hover effect on rows */
tr:hover {
	background-color: #f2f2f2;
}
</style>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<h1>Task Hours Report</h1>

	<table id="taskTable" border="1">
		<thead>
			<tr>
				<th>Task ID</th>
				<th>Employee Name</th>
				<th>Project</th>
				<th>Date</th>
				<th>Start Time</th>
				<th>End Time</th>
				<th>Task Category</th>
				<th>Description</th>
			</tr>
		</thead>
		<tbody>
			<%
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;
			try {
				// Connect to the database
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_time_tracker", "root", "Vikash246@");

				// Create SQL statement
				String sql = "SELECT * FROM add_task";
				stmt = conn.createStatement();

				// Execute query
				rs = stmt.executeQuery(sql);

				// Display fetched data in a table
				while (rs.next()) {
			%>
			<tr>
				<td><%=rs.getString("task_id")%></td>
				<td><%=rs.getString("employee_name")%></td>
				<td><%=rs.getString("project")%></td>
				<td><%=rs.getString("date_1")%></td>
				<td><%=rs.getString("start_time")%></td>
				<td><%=rs.getString("end_time")%></td>
				<td><%=rs.getString("task_category")%></td>
				<td><%=rs.getString("description")%></td>
			</tr>
			<%
			}
			} catch (Exception e) {
			e.printStackTrace();
			} finally {
			// Close resources
			try {
			if (rs != null)
				rs.close();
			} catch (Exception e) {
			e.printStackTrace();
			}
			try {
			if (stmt != null)
				stmt.close();
			} catch (Exception e) {
			e.printStackTrace();
			}
			try {
			if (conn != null)
				conn.close();
			} catch (Exception e) {
			e.printStackTrace();
			}
			}
			%>
		</tbody>
	</table>

	<hr>

	<%
	// Calculate total hours for each task category
	Map<String, Double> taskCategoryHours = new HashMap<>();
	try {
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_time_tracker", "root", "Vikash246@");
		stmt = conn.createStatement();
		rs = stmt.executeQuery(
		"SELECT task_category, SUM(end_time - start_time) AS total_hours FROM add_task GROUP BY task_category");
		while (rs.next()) {
			taskCategoryHours.put(rs.getString("task_category"), rs.getDouble("total_hours") / 10000);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (rs != null)
		rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (stmt != null)
		stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (conn != null)
		conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	%>

	<%-- Draw pie chart for task category hours --%>
	<div style="display: flex; padding: 12vh;">
		<div style="max-width: 30vw;">
			<canvas id="pieChart"></canvas>
		</div>
		<div style="max-width: 30vw;">
			<canvas id="barChart"></canvas>
		</div>
	</div>

	<script>
    var taskCategoryHours = {
        <%for (Map.Entry<String, Double> entry : taskCategoryHours.entrySet()) {%>
            '<%=entry.getKey()%>': <%=entry.getValue()%>,
        <%}%>
    };
    
    var canvas = document.getElementById('pieChart');
    var ctx = canvas.getContext('2d');
    var labels = Object.keys(taskCategoryHours);
    var data = Object.values(taskCategoryHours);
    for (let i = 0; i<data.length; i++) {
    	if (data[i] < 0) {
    		data[i] = data[i] * -1
    	}
    	
    }
    var backgroundColors = [
        'rgba(255, 99, 132, 0.6)',
        'rgba(54, 162, 235, 0.6)',
        'rgba(255, 206, 86, 0.6)',
        'rgba(75, 192, 192, 0.6)',
        'rgba(153, 102, 255, 0.6)',
        'rgba(255, 159, 64, 0.6)',
        'rgba(255, 99, 132, 0.6)'
    ];
    
    var chart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                backgroundColor: backgroundColors,
                borderWidth: 1
            }]
        },
        options: {
           // responsive: true,
           // maintainAspectRatio: false,
            title: {
                display: true,
                text: 'Task Category Hours'
            }
        }
    });
</script>



	<script>
    var taskCategoryHours = {
        <%for (Map.Entry<String, Double> entry : taskCategoryHours.entrySet()) {%>
            '<%=entry.getKey()%>': <%=entry.getValue()%>,
        <%}%>
    };
    
    var canvasBar = document.getElementById('barChart');
    var ctxBar = canvasBar.getContext('2d');
    var labelsBar = Object.keys(taskCategoryHours);
    var dataBar = Object.values(taskCategoryHours);
    for (let i = 0; i<dataBar.length; i++) {
    	if (dataBar[i] < 0) {
    		dataBar[i] = dataBar[i] * -1
    	}
    	
    }
    
    var backgroundColorsBar = [
        'rgba(255, 99, 132, 0.6)',
        'rgba(54, 162, 235, 0.6)',
        'rgba(255, 206, 86, 0.6)',
        'rgba(75, 192, 192, 0.6)',
        'rgba(153, 102, 255, 0.6)',
        'rgba(255, 159, 64, 0.6)',
        'rgba(255, 99, 132, 0.6)'
    ];
    
    var chartBar = new Chart(ctxBar, {
        type: 'bar',
        data: {
            labels: labelsBar,
            datasets: [{
                label: 'Task Category Hours',
                data: dataBar,
                backgroundColor: backgroundColorsBar,
                borderWidth: 1
            }]
        },
        options: {
           
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });
</script>


</body>
</html>
