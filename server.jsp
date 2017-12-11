<%@page language="java" import="java.sql.*,java.util.*,java.lang.*"%>

<%	

/*A web-based UI for The Soda Sommelier. Runs on Apache Tomcat & utilizes the JDBS driver.
 * Created by Elizabeth Fregoso
 * Last updated 12/05/2017
 */
 
	//Initialization of the database connection with login info
	Driver DriverRecordset1 = (Driver) Class.forName("com.mysql.jdbc.Driver").newInstance();
	Properties props = new Properties();
	props.setProperty("user", "root");
	props.setProperty("password", "Star#001");
	String url = "jdbc:mysql://localhost/mydb";
	Connection Conn = DriverManager.getConnection(url, props);
	
	//Variables for storing various types of responses, depending on the query
	String foodResponse = new String();
	String sodaResponse = new String();
	String newFoodName = new String();
	String newFoodType = new String();
	String newSodaName = new String();
	String newSodaType = new String();

	/*Check for where there is a field that isn't empty.
	 * First, check FFS.
	 */
	String submitName = "FFS";
	String responseName = request.getParameter("FFS");
	if (responseName != null && responseName != "") {
		responseName = responseName.toLowerCase();
	}
	
	//If FFS hasn't come back with anything, check SSF.
	if (responseName == "" || responseName == null) {
		submitName = "SFF";
		responseName = request.getParameter("SFF");
		if (responseName != null && responseName != "") {
			responseName = responseName.toLowerCase();
		}
		//If SFF hasn't come back with anything, check RFFAS.
		if (responseName == "" || responseName == null){
			submitName = "RFFAS";
			foodResponse = request.getParameter("RFFASF");
			if (foodResponse != null && foodResponse != "") {
				foodResponse = foodResponse.toLowerCase();
			}
			sodaResponse = request.getParameter("RFFASS");
			if (sodaResponse != null && sodaResponse != "") {
				sodaResponse = sodaResponse.toLowerCase();
			}
			/*If one or the other of these two fields are blank...
			if (foodResponse != "" || sodaResponse != "") {
				//If both are blank, return to homepage with error message to fill in both blanks
				if (foodResponse == "" || sodaResponse == "") {
					//return to home page with error message
				}
			}
			*/
			//If RFFAS hasn't come back with anything, check NF.
			if ((foodResponse == "" && sodaResponse == "") || (foodResponse == null && sodaResponse == null)) {
				submitName = "NF";
				newFoodName = request.getParameter("NF");
				if (newFoodName != null && newFoodName != "") {
					newFoodName = newFoodName.toLowerCase();
				}
				newFoodType = request.getParameter("foodTypes");
				if (newFoodType != null && newFoodType != "") {
					newFoodType = newFoodType.toLowerCase();
				}
				//If NF hasn't come back with anything, check NS.
				if (newFoodName == "" || newFoodName == null) {
					submitName = "NS";
					newSodaName = request.getParameter("NS");
					if (newSodaName != null && newSodaName != "") {
						newSodaName = newSodaName.toLowerCase();
					}
					newSodaType = request.getParameter("sodaTypes");
					if (newSodaType != null && newSodaType != "") {
						newSodaType = newSodaType.toLowerCase();
					}
					//FOR SOME REASON RFF REDIRECTS TO THE HOMEPAGE. THERE'S NOT EVEN A REDIRECT OPTION HERE.
					//If NS hasn't come back with anything, check RFF
					if (newSodaName == "" || newSodaName == null){
						submitName = "RFF";
						responseName = request.getParameter("RFF");
						if (responseName != null && responseName != "") {
							responseName = responseName.toLowerCase();
						}
						//If RFF hasn't come back with anything, check RFS
						if (responseName == "" || responseName == null){
							submitName = "RFS";
							responseName = request.getParameter("RFS");
							if (responseName != null && responseName != "") {
								responseName = responseName.toLowerCase();
							}
							//If the response name hasn't come back with anything, check SNAR
							if (responseName == "" || responseName == null) {
								submitName = "SNAR";
								responseName = request.getParameter("SNAR");
								if (responseName != null && responseName != ""){
									responseName = responseName.toLowerCase();
								}
								//If responseName hasn't come back with anything, check FNAR
								if (responseName == "" || responseName == null){
									submitName = "FNAR";
									responseName = request.getParameter("FNAR");
									if (responseName != null && responseName != ""){
										responseName = responseName.toLowerCase();
									}
									/* If responseName hasn't come back with anything, check ANP
									if (responseName == "" || responseName == null){
										submitName = "ANP";
										responseName = request.getParameter("ANP");
										if (responseName != null && responseName != ""){
											responseName.toLowerCase();
										}
									*/
									//Else, if nothing has been filled in, return to the homescreen.
									if (responseName == null && responseName == "") {
									%>
									<table>
									<tr>
									<td>
										<span>You didn't enter anything! Click <a href="/EECS340Final/sodaindex.jsp">here</a> to return to the home screen & try again.</span>
									</td>
									</tr>
									</table>
									<%	
									}
								}
							}
						}
					}
				}
			}
		}
	}
		
	
	//Establish a connection
	Statement st = Conn.createStatement();
	//Use dynamic SQL here to insert the query including the parameters for the proper submit
	String query = new String();
			
	//If user asked for FOOD from SODA (FFS), alter query to the parameters given.
	if (submitName == "FFS" && responseName != "" && responseName != null) {
		query = "SELECT f.foodName FROM Foods f, SpecificPairings p, Sodas s WHERE f.foodID = p.foodID AND p.sodaID = s.sodaID AND s.sodaName = '" + responseName + "'";
	}
	//If user asked for SODA from FOOD (SFF), alter query to the parameters given.
	else if (submitName == "SFF" && responseName != "" && responseName != null) {
		query = "SELECT s.sodaName FROM Foods f, SpecificPairings p, Sodas s WHERE s.sodaID = p.sodaID AND p.foodID = f.foodID AND f.foodName = '" + responseName + "'";
	}
	//If user asked for RESTAURANT from FOOD & SODA PAIRING (RFFASP), alter query to the parameters given.
	else if (submitName == "RFFAS" && foodResponse != "" && foodResponse != null && sodaResponse != "" && sodaResponse != null){
		query = "SELECT r.restaurantName, r.restaurantAddr FROM Restaurants r, FoodMenuEntry f, SodaMenuEntry s, Foods fo, Sodas so WHERE s.sodaID = so.sodaID AND so.sodaName = '" + sodaResponse + "' AND f.foodID = fo.foodID AND fo.foodName = '" + foodResponse + "' AND s.restaurantID = r.restaurantID AND f.restaurantID = r.restaurantID";
	}
	/*If the user asked to add a new food to the database, (NF) add it. 
	 */
	else if (submitName == "NF" && newFoodName != "") {
		newFoodName.toLowerCase();
		newFoodType.toLowerCase();
		query = "INSERT INTO Foods (foodName, foodType, flag) VALUES ('" + newFoodName + "', '" + newFoodType + "', 1)";
	}
	/*If the user asked to add a new soda to the database, (NS) add it. 
	 */
	else if (submitName == "NS" && newSodaName != "") {
		newSodaName.toLowerCase();
		newSodaType.toLowerCase();
		query = "INSERT INTO Sodas (sodaName, sodaType, sodaFlavor, flag) VALUES ('" + newSodaName + "', '" + newSodaType + "', 'original', 1)";
	}
	//If user asked for RESTAURANTS from FOOD (RFF), alter query to the given parameters
	else if (submitName == "RFF"){
		query = "SELECT r.restaurantName FROM Restaurants r, Foods f, FoodMenuEntry fm WHERE f.foodName = '" + responseName + "' AND f.foodID = fm.foodID AND fm.restaurantID = r.restaurantID";
	}
	//If user asked for RESTAURANTS from SODA (RFS), alter query to the given parameters
	else if (submitName == "RFS"){
		query = "SELECT r.restaurantName FROM Restaurants r, Sodas s, SodaMenuEntry sm WHERE s.sodaName = '" + responseName + "' AND s.sodaID = sm.sodaID AND sm.restaurantID = r.restaurantID";
	}
	//If user asked for SODAS NOT AVAILABLE AT RESTAURANTS (SNAR), alter query to the given parameters.
	else if (submitName == "SNAR"){
		query = "SELECT s.sodaName FROM Sodas s WHERE s.sodaName NOT IN (SELECT s2.sodaName FROM Sodas s2, Restaurants r, SodaMenuEntry sm WHERE r.restaurantName = '" + responseName + "' AND sm.restaurantID = r.restaurantID AND sm.sodaID = s2.sodaID)";
	}
	//If user asked for FOODS NOT AVAILABLE AT RESTAURANTS (FNAR), alter query to the given parameters.
	else if (submitName == "FNAR"){
		query = "SELECT f.foodName FROM Foods f WHERE f.foodName NOT IN (SELECT f2.foodName FROM Foods f2, Restaurants r, FoodMenuEntry fm WHERE r.restaurantName = '" + responseName + "' AND fm.restaurantID = r.restaurantID AND fm.foodID = f2.foodID)";
	}
	
	/* If a new food/soda request, try run executeUpdate.
	 * If update is successful. show success message.
	 * Else, show error message.
	 * Finally, close the connection to the database.
	 * If exception thrown, catch & show error message.
	 */
	if (submitName == "NF" || submitName == "NS") {
		try {
			Statement st2 = Conn.createStatement();
			int result = st2.executeUpdate(query);
			
			//If the update went okay, show the new tuple & a success message.
			if (result != 0) {
				//If a new food was added...
				if (submitName == "NF"){
					ResultSet rs3 = st.executeQuery("SELECT * FROM Foods f WHERE f.foodName = '" + newFoodName + "'");
					ResultSetMetaData rsd = rs3.getMetaData();
					int numCols = rsd.getColumnCount();
					%>
					<table border = "1">
					<tr>
					<%
					while (rs3.next()) { %>
						<tr>
					<%
						for (int i = 1; i <= numCols; i++){ %>
							<td><%=rs3.getString(i)%></td>
						<%	
						}	
						%>
						<tr>
							<td><span>Successfully submitted!</span></td>
						</tr>
					</table>
					<!-- Link for returning to homepage -->
					<a href="/EECS341Final/sodaindex.jsp">Return to home</a>
					<%
					}
				}
				//Else, if a new soda was added...
				else {
					ResultSet rs3 = st.executeQuery("SELECT * FROM Sodas s WHERE s.sodaName = '" + newSodaName + "'");
					ResultSetMetaData rsd = rs3.getMetaData();
					int numCols = rsd.getColumnCount();
					%>
					<table border = "1">
					<tr>
					<%
					while (rs3.next()) {
						for (int i = 1; i <= numCols; i++){ %>
							<td><%=rs3.getString(i)%></td>
						<%	
						}	
						%>
						<tr>
							<td><span>Successfully submitted!</span></td>
						</tr>
						</table>
					<!-- Link for returning to homepage -->
					<a href="/EECS341Final/sodaindex.jsp">Return to home</a>
					<%
					}
				}
			}

			//Else, show an error message.
			else {
				%>
				<table border = "1">
					<tr>
						<td><span>Error code 01: An error adding new item occurred! Please contact a system admin.</span></td>
					</tr>
				</table>
				<!-- Link for returning to homepage -->
				<a href="/EECS341Final/sodaindex.jsp">Return to home</a>
				<%
			}
			Conn.close();
		}
		
		catch (Exception e) {
			%>
			<table border = "1">
				<tr>
					<td><span>Error Code 02: An unknown error occurred! Please contact a system admin.</span></td>
				</tr>
			</table>
			<!-- Link for returning to homepage -->
			<a href="/EECS341Final/sodaindex.jsp">Return to home</a>
			<%
		}
	}
	
	/* Else, if a standard query, try run executeQuery.
	 * Show results
	 * Finally, close the connection to the database.
	 * If exception thrown, catch & show error message.
	 */
	else {
		try {
			//Retrieve the resultset from these queries
			ResultSet rs = st.executeQuery(query);
				
			//Return the resultset in the form of an HTML table
			%>
			<table border = "1">
				<%
					while (rs.next()) {
				%>
					<tr>
					<td><%=rs.getString(1)%></td>
				<%
					}
				%>
				</tr>
			</table>
			
			<!-- Link for returning to homepage -->
			<a href="/EECS341Final/sodaindex.jsp">Return to home</a>
			
			<%
			
			//Close the connection to the ResultSet and the database
			rs.close();
			Conn.close();
		}
		
		catch (Exception e) {
			%>
			<table border = "1">
				<tr>
					<td><%=submitName + "|"%><span>Error Code 03: An error occurred! Please contact a system admin.</span></td>
				</tr>
			</table>
			
			<!-- Link for returning to homepage -->
			<a href="/EECS341Final/sodaindex.jsp">Return to home</a>
			<%
		}
	}
%>
