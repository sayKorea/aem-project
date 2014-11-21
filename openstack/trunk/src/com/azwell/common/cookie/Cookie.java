package com.azwell.common.cookie;

import org.openstack4j.api.OSClient;

/**
 * 공통 Cookie
 * 
 * @author ParkMoohun
 */
public class Cookie {
	private static String cookie 	= "";
	private static boolean login 	= false;
	private static OSClient os 		= null;
	
	
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
	public static OSClient getOs() {
		return os;
	}
	public static void setOs(OSClient os) {
		Cookie.os = os;
	}
}
