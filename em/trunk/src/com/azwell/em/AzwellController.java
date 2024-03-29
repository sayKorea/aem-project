package com.azwell.em;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.util.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.azwell.common.cookie.Cookie;
import com.azwell.common.logger.Log;

/**
 * 메뉴명 Controller
 * 
 * @author 이름
 * 
 */
@Controller
public class AzwellController {
	private static final String FIX_URL = "https://210.127.39.181:7799/";
	private static final String FIX_INIT_CMD = "em/cloud/";
	private static final String FIX_KEY = "Authorization";
	private static final String FIX_KEY_BASIC = "basic";

	private static String loginId = "";
	private static String password = "";
	protected static HttpsURLConnection httpsCon = null;

	private static boolean loginCheck(HttpServletResponse response) {
		// Log.Debug("==== HTTPS API INITIALIZE START ====");
		String loginVal = loginId + ":" + password;
		String ba64Chg = Base64.encode(loginVal.getBytes());

		if (loginId.equals("") || password.equals("")) {
			try {
				Log.Debug("Redirect");
				response.sendRedirect("/em/loginView.do");
			} catch (IOException e) {
				e.printStackTrace();
			}
			return false;
		}

		Log.Debug(loginVal + " KEY VALUE : " + ba64Chg);
		if (Cookie.isLogin()) {
			return true;
		}
		URL url = null;
		try {
			url = new URL(FIX_URL + FIX_INIT_CMD);
			httpsCon = (HttpsURLConnection) url.openConnection();
			httpsCon.setRequestProperty(FIX_KEY, FIX_KEY_BASIC + " " + ba64Chg);// c3lzbWFuOmRwd21kbnBmZW0=
			httpsCon.setHostnameVerifier(new HostnameVerifier() {
				@Override
				public boolean verify(String hostname, SSLSession session) {
					return true;
				}
			});
			httpsCon.connect();
			Log.Debug("====" + httpsCon.getHeaderFields().toString());
			Cookie.setCookie(httpsCon.getHeaderField("Set-Cookie"));
			if (!Cookie.getCookie().equals("")) {
				Cookie.setLogin(true);
				return true;
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			Log.Debug("Redirect");
			response.sendRedirect("/em/loginView.do");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

	private static String getHttpsCall(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws IOException {
		Log.Debug("==== HTTPS API CALL START ====");
		loginCheck(response);
		String cmd = (String) paramMap.get("cmd");
		URL url = new URL(FIX_URL + cmd);
		httpsCon = (HttpsURLConnection) url.openConnection();
		httpsCon.setRequestProperty("Authorization", "basic c3lzbWFuOmRwd21kbnBmZW0=");
		httpsCon.setRequestProperty("Cookie", Cookie.getCookie());
		HttpsURLConnection.setDefaultRequestProperty((String) "Set-Cookie", (String) Cookie.getCookie());
		httpsCon.setHostnameVerifier(new HostnameVerifier() {
			@Override
			public boolean verify(String hostname, SSLSession session) {
				return true;
			}
		});
		httpsCon.connect();
		Log.Debug("==== HTTPS API CALL END ====");
		return getStringFromInputStream(httpsCon.getInputStream());
	}

	@RequestMapping("EMI")
	public void emi(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Log.Debug("==== EMI TOS START ====");
		String resutlApiStr = getHttpsCall(paramMap, request, response);
		PrintWriter writer = response.getWriter();

		// WRITE
		writer.write(resutlApiStr);
		Log.Debug("==== EMI TOS END ====");
	}

	private static String getStringFromInputStream(InputStream is) {
		BufferedReader br = null;
		StringBuilder sb = new StringBuilder();
		String line;
		try {
			br = new BufferedReader(new InputStreamReader(is));
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return sb.toString();
	}

	@RequestMapping(value = { "/em/writeData.do" })
	public void writeData(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Log.Debug("==== EMI writeData START ====");
		String resutlApiStr = getHttpsCall(paramMap, request, response);
		PrintWriter writer = response.getWriter();
		writer.write(resutlApiStr);
		Log.Debug("==== EMI writeData END ====");
	}

	@RequestMapping(value = { "/em/search.do" })
	public ModelAndView search(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Log.Debug("==== EMI TOS START ====");
		String resutlApiStr = getHttpsCall(paramMap, request, response);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("DATA", resutlApiStr);
		Log.Debug("==== EMI TOS END ====");
		return mav;
	}

	@RequestMapping(value = { "/em/login.do" })
	public ModelAndView login(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Log.Debug("==== LOGIN START ====");
		loginId = (String) paramMap.get("userid");
		password = (String) paramMap.get("password");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		if (loginCheck(response)) {
			mav.addObject("DATA", "Login Success");
			mav.addObject("URL", "/em/cloud/databaseView.do");

		} else {
			mav.addObject("DATA", "Login Fail");
		}
		Log.Debug("==== LOGIN END ====");
		return mav;
	}

	@RequestMapping(value = { "/em/logout.do" })
	public ModelAndView logout(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Log.Debug("==== LOGOUT START ====");
		loginId = "";
		password = "";
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("DATA", "Logout Success");
		mav.addObject("URL", "/em/loginView.do");
		Log.Debug("==== LOGOUT END ====");
		return mav;
	}
}
