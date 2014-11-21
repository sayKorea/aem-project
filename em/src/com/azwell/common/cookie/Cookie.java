package com.azwell.common.cookie;

/**
 * 공통 Cookie
 * 
 * @author ParkMoohun
 */
public class Cookie {
	private static String cookie = "";
	private static boolean login = false;
	
	public static boolean isLogin() {
		return login;
	}
	public static void setLogin(boolean login) {
		Cookie.login = login;
	}
	public static String getCookie() {
		return Cookie.cookie;
	}
	public static void setCookie(String cookie) {
		Cookie.cookie = cookie;
	}
}
