package com.azwell.openstack;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.openstack4j.api.OSClient;
import org.openstack4j.model.compute.Flavor;
import org.openstack4j.model.compute.Server;
import org.openstack4j.model.compute.VNCConsole;
import org.openstack4j.model.compute.VNCConsole.Type;
import org.openstack4j.model.image.Image;
import org.openstack4j.openstack.OSFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.azwell.common.cookie.Cookie;
import com.azwell.common.logger.Log;

@Controller
public class OpenstackController {
	private static final String FIX_URL 			= "http://192.168.47.1";
	private static final String FIX_KEYSTONE_PORT	= "5000";
	private static final String FIX_INIT_CMD		= "/v2.0";
	private static final String FIX_TENANT_NAME		= "DEMO";
	private static String authKeystoneUrl = FIX_URL+":"+FIX_KEYSTONE_PORT+"/"+FIX_INIT_CMD;
	private static String userid = "";
	private static String password = "";
	
//	@RequestMapping(value = { "/em/search.do" })
//	public ModelAndView search(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
//		Log.Debug("==== EMI TOS START ====");
//		String resutlApiStr = getHttpsCall(paramMap, request, response);
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("jsonView");
//		mav.addObject("DATA", resutlApiStr);
//		Log.Debug("==== EMI TOS END ====");
//		return mav;
//	}

	@RequestMapping(value = { "/openstack/login.do" })
	public ModelAndView login(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response){
		Log.Debug("==== OPENSTACK LOGIN START ====");
		String authKeystoneUrl = FIX_URL+":"+FIX_KEYSTONE_PORT+"/"+FIX_INIT_CMD;
		userid 	= (String)paramMap.get("userid"); 
		password = (String)paramMap.get("password"); 
		
//		Log.Debug("### URL :: "+authKeystoneUrl);
//		Log.Debug("### ID/PASS :: "+userid+"/"+password);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		try {
			OSClient os = OSFactory	.builder()
							.endpoint(authKeystoneUrl)
							.credentials(userid,password)
							.tenantName("demo")
							.authenticate();
			List<? extends Server> servers = os.compute().servers().list();
			System.out.println("SERVERS : STATUS --> "+servers.get(0).getStatus().name());
			
			mav.addObject("DATA", "Login Success");
			mav.addObject("URL", "/openstack/mainView.do");
			Cookie.setLogin(true);
			Cookie.setOs(os);
		} catch (Exception e) {
			// TODO: handle exception
			mav.addObject("DATA", "Login Fail");
			mav.addObject("URL", "/openstack/loginView.do");
		}
		
		Log.Debug("==== OPENSTACK LOGIN END ====");
		return mav;
	}

	@RequestMapping(value = { "/openstack/logout.do" })
	public ModelAndView logout(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Log.Debug("==== OPENSTACK LOGOUT START ====");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("DATA", "Logout Success");
		mav.addObject("URL", "/openstack/loginView.do");
		Log.Debug("==== OPENSTACK LOGOUT END ====");
		return mav;
	}
	
	@RequestMapping(value = { "/openstack/instance.do" })
	public ModelAndView instance(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Log.Debug("==== OPENSTACK INSTANCE START ====");
		if(!Cookie.isLogin()){
			response.sendRedirect("/openstack/loginView.do");
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		OSClient os = OSFactory	.builder()
				.endpoint(authKeystoneUrl)
				.credentials(userid,password)
				.tenantName("demo")
				.authenticate();
		List<? extends Server> servers 	= os.compute().servers().list();
		List<? extends Image> images 	= os.images().list();
		List<? extends Flavor> flavors 	= os.compute().flavors().list();
		List consoleList					= new ArrayList();
		List vncconsoleList 				= new ArrayList();
		Map tmpMap						= null;
		
		VNCConsole vncconsole = null;
		
		for(int i=0; i<servers.size(); i++){
			tmpMap						= new HashMap();
			Log.Debug("SERVER ID : "+servers.get(i).getId());
			tmpMap.put("id", servers.get(i).getId());
			tmpMap.put("console", os.compute().servers().getConsoleOutput(servers.get(i).getId(), 50));
			consoleList.add(tmpMap);
			
			tmpMap						= new HashMap();
			vncconsole = os.compute().servers().getVNCConsole(servers.get(i).getId(), Type.NOVNC);
			tmpMap.put("id", servers.get(i).getId());
			tmpMap.put("consoleUrl", vncconsole.getURL());
			vncconsoleList.add(tmpMap);
		}

		
		mav.addObject("KEYSTONE",os.getAccess().getToken());
		mav.addObject("DATA",servers.toArray());
		mav.addObject("IMAGE",images);
		mav.addObject("FLAVOR",flavors);
		mav.addObject("CONSOLE",consoleList);
		mav.addObject("NVCCONSOLE",vncconsoleList);
		Log.Debug("==== OPENSTACK INSTANCE END ====");
		return mav;
	}
	
}
