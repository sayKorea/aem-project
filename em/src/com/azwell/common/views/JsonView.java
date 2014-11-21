package com.azwell.common.views;

import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.web.servlet.view.AbstractView;

import com.azwell.common.logger.Log;

/**
 * xstream json view
 * 
 * @author jaratus
 *
 */
public class JsonView extends AbstractView {

	String contentType = null;
	
	protected void renderMergedOutputModel(Map map, HttpServletRequest request, HttpServletResponse response) throws Exception {

		Log.Debug("Entering JsonView.renderMergedOutputModel()"+map);
		
		boolean isArray = false;
		String json = "";
		JSONObject jsonObject = null;
		JSONArray jsonArray = null;
		
		
		  Set<String> keySet = map.keySet();  
		  Iterator<String> iterator = keySet.iterator();  
		  while (iterator.hasNext())  
		  {  
		   String key = iterator.next();  
		   Object value = map.get("hashMapList");  
		   System.out.printf("key : %s , value : %s %n", key, value);  
		  } 
		  
		Object model = map.get("hashMapList");
		if (model != null) {
			if (model instanceof List) {
				isArray = true;
				jsonArray = JSONArray.fromObject(model);
			} else
				jsonObject = JSONObject.fromObject(model);
		} else {
			jsonObject = JSONObject.fromObject(map);
		}
		
		if (isArray)
			json = jsonArray.toString();
		else
			json = jsonObject.toString();
		
		
//		response.getOutputStream().write(json.getBytes());
		response.setContentType(getContentType());
		response.setHeader("Cache-Control", "no-cache");
		
		PrintWriter writer = response.getWriter();
		writer.write(json);
		writer.close();
		
		Log.Debug("json ::: "+ json);
	}

	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

}
