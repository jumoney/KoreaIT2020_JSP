package com.koreait.pjt.board;

import java.io.IOException;
import java.util.List;

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
import com.koreait.pjt.vo.BoardDomain;
import com.koreait.pjt.vo.UserVO;


@WebServlet("/board/list")
public class BoardListSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession hs = request.getSession();
		
		if(null == hs.getAttribute(Const.LOGIN_USER)) {
			response.sendRedirect("/login");
			return;
		}
		
		int page = MyUtils.getIntParameter(request, "page");
		page = (page == 0 ? 1: page);
		
		BoardDomain param = new BoardDomain();
		
		if(request.getParameter("record_cnt") == null) {
			param.setRecord_cnt(Const.RECORD_CNT);
		}else {
			int record_cnt = MyUtils.getIntParameter(request, "record_cnt");
			param.setRecord_cnt(record_cnt);
		}

		int eldx = page * param.getRecord_cnt();
		int sldx = eldx - param.getRecord_cnt();
		param.setSldx(sldx);
		param.setEldx(eldx);
		
		List list = BoardDAO.selBoardList(param);
		
		request.setAttribute("pagingCnt", BoardDAO.selPagingcnt(param));
		request.setAttribute("page", page);
		request.setAttribute("list", list);
		
		if(request.getParameter("err") != null) {
			int err = Integer.parseInt(request.getParameter("err"));
			request.setAttribute("err", err);
			System.out.println(err);
		}
		
		ViewResolver.forwardLoginChk("board/list", request, response);
		
		
		
	}

}
