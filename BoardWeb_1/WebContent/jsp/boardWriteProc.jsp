<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
    
<%!   
public Connection getCon() throws Exception {
   String url = "jdbc:oracle:thin:@localhost:1521:orcl";
   String userName = "hr";
   String password = "koreait2020";
   
   Class.forName("oracle.jdbc.driver.OracleDriver");  
   Connection con = DriverManager.getConnection(url, userName, password);
   System.out.println("접속성공!");
   return con;
}
%>
<%
	String title = request.getParameter("title");
	String ctnt = request.getParameter("ctnt");
	String strI_student = request.getParameter("i_student");
	
	Connection con = null;
	PreparedStatement ps = null;
	
	String sql = " INSERT INTO t_board(i_board, title, ctnt, i_student) " 
		+	" SELECT nvl(max(i_board), 0) + 1, ?, ? ,? " 
		+	" FROM t_board ";
	
	try{
		con = getCon();
		ps = con.prepareStatement(sql);
	 
	    ps.setString(1, title); 
	    ps.setString(2, ctnt);
	    ps.setString(3, strI_student); 
	    ps.executeUpdate();
	    
	}catch(Exception e) {
		e.printStackTrace();
	}finally {
		/*rs, ps, con 의 try catch문을 따로 사용한 이유는 rs든 
		어디든 예외가 발생해도 다른 것들이라도 닫아주기 위해*/
		
		if(ps != null) {try {ps.close();} catch(Exception e){} }
		if(con != null) {try {con.close();} catch(Exception e){} }
	}
	
%>
<div>title : <%= title %></div>
<div>ctnt : <%= ctnt %></div>
<div>i_student : <%= strI_student %></div>