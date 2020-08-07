package com.koreait.board.db;

import java.sql.*;
import java.util.*;

import com.koreait.board.vo.BoardVO;

public class BoardDAO {

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

	// insert
	public static void insertBoard(BoardVO param) {
		BoardVO vo = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		
		String sql = " INSERT INTO t_board(i_board, title, ctnt, i_student) " 
			+	" SELECT nvl(max(i_board), 0) + 1, ?, ?, ? " 
			+	" FROM t_board ";
		
		try{
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
		 
		    ps.setString(1, param.getTitle()); 
		    ps.setString(2, param.getCtnt());
		    ps.setInt(3, param.getI_student()); 
		    ps.executeQuery();
		    
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DbCon.close(con, ps);
		}
	}
}
