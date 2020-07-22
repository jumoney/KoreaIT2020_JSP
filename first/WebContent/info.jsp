<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.koreait.first.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
String url = "jdbc:oracle:thin:@localhost:1521:orcl";
String userName = "hr";
String password = "koreait2020";
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

String sql = "SELECT * FROM countries ";
List<ContriesVO> list = new ArrayList();

Class.forName("oracle.jdbc.driver.OracleDriver");
try {
	con = DriverManager.getConnection(url, userName, password);
	ps = con.prepareStatement(sql);
	rs = ps.executeQuery();
	
	while(rs.next()){
		String country_id = rs.getString("country_id");
		String country_name = rs.getString("country_name");
		int region_id = rs.getInt("region_id");
		
		ContriesVO vo = new ContriesVO();
		vo.setCountry_id(country_id);
		vo.setCountry_name(country_name);
		vo.setRegion_id(region_id);
		
		list.add(vo);
		
		
	}
} catch (Exception e) {

} finally {
	try {
		rs.close();
		ps.close();
		con.close();
	} catch (Exception e) {

	}
}
System.out.println("접속 성공!!!");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Info</title>
</head>
<body>
	<div>나라 정보</div>
	<div>
		<table>
			<tr>
				<th>country_id</th>
				<th>나라명</th>
				<th>지역ID</th>
			</tr>
			
			<%for(ContriesVO vo : list) {%>
			<tr>
				<td><%=vo.getCountry_id() %></td>
				<td><%=vo.getCountry_name() %></td>
				<td><%=vo.getRegion_id() %></td>
			</tr>
			<% } %>
		</table>
	</div>
	
</body>
</html>