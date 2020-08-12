package com.koreait.board.db;

import java.sql.*;
import java.util.*;

import com.koreait.board.vo.BoardVO;

public class BoardDAO {
	
	// insert
		public static int insBoard(BoardVO param) {
			int result = 0;
			Connection con = null;
			PreparedStatement ps = null;
			
			
			String sql = " INSERT INTO t_board "
					+ "(i_board, title, ctnt, i_student) " 
				+	" VALUES "
				+ "(seq_board.nextval, ?, ?, ?)";	
			
			try{
				con = DbCon.getCon();
				ps = con.prepareStatement(sql);
			    ps.setString(1, param.getTitle()); 
			    ps.setString(2, param.getCtnt());
			    ps.setInt(3, param.getI_student()); 
			    
			    result = ps.executeUpdate();
			    
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				DbCon.close(con, ps);
			}
			
			return result;
		}

	public static List<BoardVO> selBoardList() {
		List<BoardVO> list = new ArrayList();

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = " SELECT i_board, title, i_student FROM t_board ORDER BY i_board DESC ";

		try {

			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) {
				BoardVO vo = new BoardVO();

				vo.setI_board(rs.getInt("i_board"));
				vo.setTitle(rs.getString("title"));
				vo.setI_student(rs.getInt("i_student"));

				list.add(vo);
			}

		} catch (Exception e) {

		} finally {
			DbCon.close(con, ps, rs);
		}

		return list;
	}

	// 디테일
	public static BoardVO selBoard(BoardVO param) {
		BoardVO vo = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = " SELECT i_board, title, ctnt, i_student" + " FROM t_board " + " where i_board = ? ";

		try {
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			ps.setInt(1, param.getI_board());

			rs = ps.executeQuery();

			if (rs.next()) {
				int i_board = rs.getInt("i_board");
				String title = rs.getNString("title");
				String ctnt = rs.getNString("ctnt");
				int i_student = rs.getInt("i_student");

				vo = new BoardVO();
				vo.setI_board(i_board);
				vo.setTitle(title);
				vo.setCtnt(ctnt);
				vo.setI_student(i_student);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con, ps, rs);
		}

		return vo;
	}
	
	public static int updateBoard(BoardVO param) {
		int result = 0;
		Connection con = null;
		PreparedStatement ps = null;
		
		
		String sql = " UPDATE t_board "
				+ "SET title=?, "
				+ " ctnt=?, "
				+ " i_student=? " 
				+ " WHERE i_board = ? ";
		
		try{
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
		    ps.setString(1, param.getTitle()); 
		    ps.setString(2, param.getCtnt());
		    ps.setInt(3, param.getI_student()); 
		    ps.setInt(4, param.getI_board());
		    
		    result = ps.executeUpdate();
		    
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DbCon.close(con, ps);
		}
		
		return result;
	}
	
	public static int delBoard(int i_board) {
		int result = 0;
		Connection con = null;
		PreparedStatement ps = null;
		
		String sql = " DELETE FROM t_board WHERE i_board = ? ";
		
		try{
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
		    ps.setInt(1, i_board); 
		   
		    result = ps.executeUpdate();
		    
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DbCon.close(con, ps);
		}
		
		return result;
	}
	
}
