package com.azwell.em;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.azwell.common.logger.Log;

/**
 * 메뉴명 Controller
 * 
 * @author 이름
 * 
 */
@Controller
public class AzwellView {
    @RequestMapping(value={"/em/loginView.do"})
    public String loginView(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Log.Debug("==== LOGIN UI START ====");
        return "login";
    }
    
    @RequestMapping(value={"/em/test/searchView.do"})
    public String searchView(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Log.Debug("==== SEARCH UI START ====");
        return "template/searchEM";
    }
    @RequestMapping(value={"/em/test/searchDepthView.do"})
    public String searchDepthView(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Log.Debug("==== SEARCH DEPTH UI START ====");
        return "template/searchDepthEM";
    }

    @RequestMapping(value={"/em/cloud/databaseView.do"})
    public String searchEmi(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Log.Debug("==== CLOUD DATABSE UI START ====");
        return "cloud/database";
    }

}
