package com.koreait.matzip;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class CommonUtils {
	public static HttpSession getSession(HttpServletRequest req) {
		return req.getSession();
	}
	
	public static int parseStringToInt(String str) {
		try {
			return Integer.parseInt(str);
		} catch(Exception e) {}
		return 0;
	}
	
	public static double parseStringToDouble(String str) { 
		try {
			return Double.parseDouble(str);
		} catch(Exception e) {}
		return 0;
		
	}
	
}
