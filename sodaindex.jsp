<html>
<head><title>The Soda Sommelier</title></head>
<body>

<h1>Welcome to The Soda Sommelier!</h1>

<table>
	<tr>
		<td>
			<h2>Food recommendations for soda:</h2>
			<form action="server.jsp" method="get">
			<input type="text" name="FFS"/>
			<input type="submit" value="Submit" name="submitFFS"/>
			</form>
		</td>
		<td>
			<h2>Soda recommendations for food:</h2>
			<form action="server.jsp" method="get">
			<input type="text" name="SFF"/>
			<input type="submit" value="Submit" name="submitSFF"/>
			</form>
		</td>
	</tr>

	<tr>
		<td>
			<h2>Find restaurants having both food & soda...:</h2>
			<form action="server.jsp" method="get">
			<span>Food:</span><input type="text" name="RFFASF"/>
			AND
			<span>Soda:</span><input type="text" name="RFFASS"/>
			<input type="submit" value="Submit" name="submitRFFAS"/>
			</form>
		</td>
	</tr>
	
	<tr>
		<td>
			<h2>Add a new food entry: </h2>
			<form action="server.jsp" method="get">
			<span>Food Name: </span><input type="text" name="NF"/>
			<span>Food Type: </span><select name="foodTypes">
			<option></option>
			<option>chicken</option>
			<option>chips</option>
			<option>salad</option>
			<option>seafood</option>
			<option>popcorn</option>
			<option>barbecue</option>
			<option>burger</option>
			<option>spicy</option>
			<option>pasta</option>
			<option>pizza</option>
			<option>pastry</option>
			<option>beef</option>
			<option>cheesy</option>
			<option>savory</option>
			<option>deli sandwich</option>
			</select>
			<input type="submit" value="Submit" name="submitNF"/>
			</form>
		</td>
		<td>
			<h2>Add a new soda entry: </h2>
			<form action="server.jsp" method="get">
			<span>Soda Name: </span><input type="text" name="NS"/>
			<span>Soda Type: </span><select name="sodaTypes">
			<option></option>
			<option>traditional cola</option>
			<option>fruity</option>
			<option>root beer</option>
			<option>ginger ale</option>
			<option>distinctive</option>
			</select>
			<input type="submit" value="Submit" name="submitNS"/>
			</form>
		</td>
	</tr>
	
	<tr>
		<td>
			<h2>Find restaurants having food...:</h2>
			<form>
			<input type="text" name="RFF"/>
			<input type="submit" value="Submit" name="submitRFF"/>
			</form>
		</td>
		<td>
			<h2>Find restaurants having sodas...:</h2>
			<form action="server.jsp" method="get">
			<input type="text" name="RFS"/>
			<input type="submit" value="Submit" name="submitRFS"/>
			</form>
		</td>
	</tr>
	
	<tr>
		<td>
			<h2>Find sodas not available in restaurant named...:</h2>
			<form action="server.jsp" method="get">
			<input type="text" name="SNAR"/>
			<input type="submit" value="Submit" name="submitSNAR"/>
			</form>
		</td>
		<td>
			<h2>Find foods not available in restaurant named...:</h2>
			<form action="server.jsp" method="get">
			<input type="text" name="FNAR"/>
			<input type="submit" value="Submit" name="submitFNAR"/>
			</form>
		</td>
	</tr>
	
</table>


</body>
</html>