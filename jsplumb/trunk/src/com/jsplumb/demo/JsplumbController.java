package com.jsplumb.demo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jsplumb.common.logger.Log;

@Controller
public class JsplumbController {
	@RequestMapping(value = { "/jsplumb/batchData.do" })
	public ModelAndView login(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response){
		Log.Debug("==== GET BATCH DATA START ====");
		ModelAndView mav = new ModelAndView();
		
		//데이터 생성 하는 부분- DB연결후에는 필요 없음
		List<Map<String, String>> arrList= new ArrayList<Map<String, String>>();
		Map<String, String> map 	= new HashMap<String, String>();
		mav.setViewName("jsonView");
		
	    for(int i=0; i < 10; i++){
	    	map = new HashMap<String, String>();
			map.put("ID", "BATCH"+i);
			map.put("POS", ""+i);
			map.put("LEVEL", ""+i);
			map.put("DESC", "배치데모"+i);
			map.put("DATE", "2015-08-19");
			arrList.add(map);
		}
	    //데이터 생성 완료
	    
	    //화면으로 batchData 전달
	    mav.addObject("records", arrList.size());
	    mav.addObject("page", 1);
		mav.addObject("rows", arrList);
		response.addHeader("Access-Control-Allow-Origin", "*");
		Log.Debug("==== GET BATCH DATA END ====");
		return mav;
	}

	@RequestMapping(value = { "/jsplumb/popup.do" })
	public ModelAndView logout(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Log.Debug("==== OPENSTACK LOGOUT START ====");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("DATA", "Logout Success");
		mav.addObject("URL", "/openstack/loginView.do");
		Log.Debug("==== OPENSTACK LOGOUT END ====");
		return mav;
	}
	
}
