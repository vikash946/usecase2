import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/index")
public class signin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // JDBC URL, username, and password of MySQL server
        String url = "jdbc:mysql://localhost:3306/employee_time_tracker";
        String dbUsername = "root";
        String dbPassword = "Vikash246@";

        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish connection to MySQL database
            conn = DriverManager.getConnection(url, dbUsername, dbPassword);

            // SQL query to check if the username and password exist in the database
            String sql = "SELECT * FROM employee_login WHERE username=? AND password=?";
            statement = conn.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);

            // Execute the query
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Authentication successful
                response.sendRedirect("home.html"); // Redirect to home.html after successful login
            } else {
                // Authentication failed
                response.sendRedirect("signin.html"); // Redirect back to sign-in page
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.html"); // Redirect to an error page if an exception occurs
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
