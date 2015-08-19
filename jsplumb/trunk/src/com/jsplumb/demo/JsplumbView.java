package com.jsplumb.demo;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jsplumb.common.logger.Log;


@Controller
public class JsplumbView {
	@RequestMapping(value={"/jsplumb/mainView.do"})
    public String mainView(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Log.Debug("==== MAIN UI START ====");
        return "jsplumb/main";
    }
}
