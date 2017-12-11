<%@page language="java" import="java.sql.*,java.util.*, java.lang.*"%>

<%
	Driver DriverRecordset1 = (Driver) Class.forName("com.mysql.jdbc.Driver").newInstance();
	Properties props = new Properties();
	props.setProperty("user", "root");
	props.setProperty("password", "Star#001");
	String url = "jdbc:mysql://localhost/mydb";
	Connection Conn = DriverManager.getConnection(url, props);
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	Statement st = Conn.createStatement();
	
	//check on the username & password combination
	String query = new String();
	
	//if username & password fields are not empty, 
	//grab the password associated with the username from the database into a ResultSet
	if (username != "" && password != "") {
		query = "SELECT u.password FROM Users u WHERE u.userid = '" + username + "'";
	}
	
	try {
		
		ResultSet rs = st.executeQuery(query);
		
		//check if there is a returned column value
		while (rs.next()) {
			String DBpassword = rs.getString(1);
			if (DBpassword.equals(password)) { %>
				<span>Thank you for logging in! Click <a href="sodaindex.jsp">here</a> to head to the homepage.</span>
		<%	}
			else { %>
				<span>Incorrect password! Click <a href="login.jsp">here</a> to head back to the login page.</span>
		<%	}
		}
		rs.close();
		Conn.close();
	}
	
	catch (Exception e) { %>
		<span>No such user exists! Click <a href="login.jsp">here</a> to head back to the login page.</span>
		<br/>
<% /**	<span>Want to register? Enter in your username & password here.</span>
		<br/>
		<span>Username: </span><input type="text" name="newUsername"/>
		<br/>
		<span>Password: </span><input type="text" name="newPassword"/>
/**/%><% }
%>
