package com.azwell.openstack;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.azwell.common.logger.Log;

@Controller
public class OpenstackView {
	@RequestMapping(value={"/openstack/loginView.do"})
    public String loginView(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Log.Debug("==== LOGIN UI START ====");
        return "login";
    }
	@RequestMapping(value={"/openstack/mainView.do"})
    public String mainView(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Log.Debug("==== MAIN UI START ====");
        return "openstack/main";
    }
    @RequestMapping(value={"/openstack/instanceView.do"})
    public String instanceView(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Log.Debug("==== INSTANCE UI START ====");
        return "openstack/instance";
    }
    @RequestMapping(value={"/openstack/flavorsView.do"})
    public String searchView(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Log.Debug("==== FLAVORS UI START ====");
        return "template/flavors";
    }

}
