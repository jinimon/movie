package com.cbox.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainAction implements Action {


	public String exec(HttpServletRequest request, HttpServletResponse response) {
		return "main.jsp";
	}
}