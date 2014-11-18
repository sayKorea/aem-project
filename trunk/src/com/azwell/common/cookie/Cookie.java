package com.azwell.common.cookie;

/**
 * 공통 Cookie
 * 
 * @author ParkMoohun
 */
public class Cookie {
	private static String cookie = "";
	private static boolean init = false;

	public static boolean isInit() {
		return Cookie.init;
	}

	public static void setInit(boolean init) {
		Cookie.init = init;
	}

	public static String getCookie() {
		return Cookie.cookie;
	}

	public static void setCookie(String cookie) {
		Cookie.cookie = cookie;
	}
}
