package com.cbox.member.command;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cbox.common.Action;
import com.cbox.member.dao.MemberDAO;
import com.cbox.member.vo.MemberVO;

public class memberInsertAction implements Action {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		MemberDAO dao = new MemberDAO();
		MemberVO vo = new MemberVO();
		
		vo.setMbr_id(request.getParameter("mbr_id"));
		vo.setMbr_pw(request.getParameter("mbr_pw"));
		vo.setMbr_nm(request.getParameter("mbr_nm"));
		vo.setMbr_birth(Date.valueOf(request.getParameter("mbr_birth")));
		vo.setMbr_phone(request.getParameter("mbr_phone"));
		vo.setMbr_email(request.getParameter("mbr_email"));
		vo.setMbr_e_yn(request.getParameter("mbr_e_yn"));
		int n = dao.insert(vo);
		
		if (n != 0) { // n이 0이 아니면 성공
			response.setContentType("text/html; charset=UTF-8");
			try {
				PrintWriter out = response.getWriter();
				out.println("<script>alert('회원가입 성공');</script>");
				out.println("<script>location.href='main.do';</script>");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			try {
				PrintWriter out = response.getWriter();
				out.println("<script>alert('회원가입 실패');</script>");
				out.println("<script>location.href='memberForm.do';</script>");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
}
