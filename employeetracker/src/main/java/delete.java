import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class delete extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        try {
            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver"); // Assuming MySQL database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_time_tracker", "root", "Vikash246@");

            // Execute query to fetch task data
            String query = "SELECT * FROM task";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            // Create a JSON array to store task data
            out.println("[");
            boolean first = true;
            while (rs.next()) {
                if (!first) {
                    out.println(",");
                }
                out.println("{");
                out.println("\"task_id\": " + rs.getInt("task_id") + ",");
                out.println("\"employee_name\": \"" + rs.getString("employee_name") + "\",");
                out.println("\"project\": \"" + rs.getString("project") + "\",");
                out.println("\"date\": \"" + rs.getString("date") + "\",");
                out.println("\"start_time\": \"" + rs.getString("start_time") + "\",");
                out.println("\"end_time\": \"" + rs.getString("end_time") + "\",");
                out.println("\"task_category\": \"" + rs.getString("task_category") + "\",");
                out.println("\"description\": \"" + rs.getString("description") + "\"");
                out.println("}");
                first = false;
            }
            out.println("]");

        } catch (Exception e) {
            e.printStackTrace();
            // Handle any errors that may occur
            out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            out.close();
        }
    }
}
