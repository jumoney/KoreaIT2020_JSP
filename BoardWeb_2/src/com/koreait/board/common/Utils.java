package com.koreait.board.common;

public class Utils {
	
	public static int parseStringToInt(String str, int n) {
		int num = n;
		try {
			num = Integer.parseInt(str);
		} catch (Exception e) {
			
		}
		
		return num;
	}
	
	public static int parseStringToInt(String str) {
		int num = 0;
		try {
			num = Integer.parseInt(str);
		} catch (Exception e) {
			
		}
		
		return num;
	}
}
