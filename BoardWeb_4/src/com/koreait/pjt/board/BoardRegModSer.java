package com.koreait.pjt.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.Const;
import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.db.UserDAO;
import com.koreait.pjt.vo.BoardDomain;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;

@WebServlet("/board/regmod")
public class BoardRegModSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 화면 띄우는 용도(등록창/수정창)
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession hs = request.getSession();
		UserVO loginUser = (UserVO) hs.getAttribute(Const.LOGIN_USER);
		if (MyUtils.isLogout(request)) {
			response.sendRedirect("/login");
			return;
		}

		String strI_board = request.getParameter("i_board");

		if (strI_board != null) {
			int i_board = MyUtils.parseStrToInt(strI_board, 0); // 문자열을 정수로 바꿈.혹시 숫자가 아닌 문자열이 섞여있으면 0이 리턴
			BoardVO param = new BoardVO();
			param.setI_board(i_board);
			param.setI_user(loginUser.getI_user());
			request.setAttribute("data", BoardDAO.selBoard(param)); // DB로 값 받기
		}

		ViewResolver.forwardLoginChk("board/regmod", request, response);
	}

	// 처리 용도(DB에 등록/수정)실시
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		String strI_board = request.getParameter("i_board");
		
		HttpSession hs = request.getSession();
		UserVO loginUser = (UserVO) hs.getAttribute(Const.LOGIN_USER);

		BoardVO param = new BoardVO();
		param.setTitle(title);
		param.setCtnt(ctnt);
		param.setI_user(loginUser.getI_user());
		int result = 0;
		
		if ("".equals(strI_board)) {
			result = BoardDAO.insBoard(param); // 새글
			response.sendRedirect("/board/list");
		}else{
			int i_board = MyUtils.parseStrToInt(request.getParameter("i_board"));
			param.setI_board(i_board);
			result = BoardDAO.updBoard(param); // 수정

			response.sendRedirect("/board/detail?i_board="+i_board);
		}


		if (result != 1) {
			// "에러가 발생하였습니다. 관리자에게 문의 해주세요"
			request.setAttribute("msg", "에러가 발생하였습니다. 관리자에게 문의 해주세요");
			request.setAttribute("data", param);
		}

	}

}
