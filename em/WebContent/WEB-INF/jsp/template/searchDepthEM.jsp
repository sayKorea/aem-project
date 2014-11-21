<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<!DOCTYPE html> 
<html class="hidden"><head> 
<%@ include file="/WEB-INF/jsp/common/include/meta.jsp"%><!-- Meta -->
<meta charset="utf-8">
<title>AZWELL</title>
<%-- <%@ include file="/WEB-INF/jsp/common/include/jqueryScript.jsp"%> --%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>

<link rel="stylesheet" href="http://jqueryui.com/resources/demos/style.css">
<script>
	var availableTags = [
			"/em/cloud/"
			,"/em/cloud/jaas/zone/D3F3FA2D72CCAA67325FB428A34F30D3"
			,"/em/cloud/jaas/zone/1140CE74F4A32B2CCFD0C4BE6C53698F"
			,"/em/cloud/jaas/zone/D02DEEC3574A6E61E08FC4FBE0217875"
			,"/em/cloud/dbaas/zone/D3F3FA2D72CCAA67325FB428A34F30D3"
			,"/em/cloud/dbaas/zone/1140CE74F4A32B2CCFD0C4BE6C53698F"
			,"/em/cloud/dbaas/zone/D02DEEC3574A6E61E08FC4FBE0217875"
			,"/em/cloud/dbaas/dbplatformtemplate/05D8BF3C6C8668EEE053B6277FD224A0"
			,"/em/cloud/dbaas/dbplatformtemplate/0345A6AD08693CD6E053B6277FD2BF20"
			,"/em/cloud/dbaas/dbplatformtemplate/035D53BE6E9AE128E053B6277FD219BA"
			,"/em/cloud/dbaas/dbplatformtemplate/04EB972102845917E053B6277FD2D618" 
			,"/em/cloud/dbaas/dbplatformtemplate/03C2F4865F4A375AE053B6277FD2F2BC"
			,"/em/cloud/iaas/servicetemplate/assembly/oracle%3AdefaultService%3Aem%3Aprovisioning%3A1%3Acmp%3AVirtualization%3AAssembly%3A04F255DC1477E848E053B6277FD281E6%3A0.1"
			,"/em/cloud/service_family_type/jaas/em/cloud/service_family_type/dbaas"
			,"/em/cloud/service_family_type/opc/em/cloud/service_family_type/iaas"
			,"/em/cloud/request/03D27644F49EFD73E053B6277FD23776"
			,"/em/cloud/request/04DE002542CB53E3E053B6277FD2E249"
			,"/em/cloud/request/04ED19D6C8122FABE053B6277FD2DB86"
			,"/em/cloud/request/04EDAF6861054D2EE053B6277FD2A856"
			,"/em/cloud/request/04EE9811620CE575E053B6277FD20332"
			,"/em/cloud/request/04EE9811622CE575E053B6277FD20332"
			,"/em/cloud/request/058641EA62BDB86BE053B6277FD235E5"
			,"/em/cloud/request/05948E0EB8911665E053B6277FD2AB9E"
			,"/em/cloud/request/0597D25910494662E053B6277FD28C5C"
			,"/em/cloud/request/05D17D2C9E7CC029E053B6277FD28289"
			,"/em/cloud/request/05D8BF9D566A68FCE053B6277FD2433C"
			,"/em/cloud/request/05D8BF9D566B68FCE053B6277FD2433C"
			,"/em/cloud/request/037311FA2F33C492E053B6277FD22A8E"
			,"/em/cloud/request/04C80C2AD663055AE053B6277FD2ECF2"
			,"/em/cloud/request/04ED205D16432FA7E053B6277FD200D5"
			,"/em/cloud/request/0594D8F491CFFC38E053B6277FD21CA8"
			,"/em/cloud/request/059B695FCAEF2B65E053B6277FD220A3"
			,"/em/cloud/request/05DCA55D94B698E0E053B6277FD2D108"
			,"/em/cloud/request/05E59880A42C262BE053B6277FD24E53"
			,"/em/cloud/request/05E59880A434262BE053B6277FD24E53"
			,"/em/cloud/request/05E59880A437262BE053B6277FD24E53"
			,"/em/cloud/request/034668FD0AD21E3FE053B6277FD224DF"
			,"/em/cloud/request/035D579159330AD5E053B6277FD21824"
			,"/em/cloud/request/03D2277E894CCF40E053B6277FD29131"
			,"/em/cloud/request/03D2B157CB8E5170E053B6277FD231B1"
			,"/em/cloud/request/04DB6116B9BC204BE053B6277FD2916C"
			,"/em/cloud/request/04ECBF7A920760BAE053B6277FD287AD"
			,"/em/cloud/request/04ECBF7A924A60BAE053B6277FD287AD"
			,"/em/cloud/request/04ECBF7A92AA60BAE053B6277FD287AD"
			,"/em/cloud/request/0371BBA05EE1E396E053B6277FD272BC"
			,"/em/cloud/request/03BD82E14F102747E053B6277FD257F2"
			,"/em/cloud/request/04DE3A13D4CE705DE053B6277FD2D48C"
			,"/em/cloud/request/04ECE2E636A057D4E053B6277FD2644F"
			,"/em/cloud/request/04EC8D82192C55EFE053B6277FD22AE2"
			,"/em/cloud/request/04EC8D82192D55EFE053B6277FD22AE2"
			,"/em/cloud/request/058650042C4DB86FE053B6277FD24B4B"
			,"/em/cloud/request/058650042C4FB86FE053B6277FD24B4B"
			,"/em/cloud/request/0586515255CEB87BE053B6277FD2C325"
			,"/em/cloud/request/0586515255E1B87BE053B6277FD2C325"
			,"/em/cloud/request/0587C88AE35B22D8E053B6277FD23C09"
			,"/em/cloud/request/059518F6CE4AFA51E053B6277FD26A49"
			,"/em/cloud/request/059B32B421456583E053B6277FD2C371"
			,"/em/cloud/request/05D8BF3C6C8A68EEE053B6277FD224A0"
			,"/em/cloud/request/05D8BF3C6C9E68EEE053B6277FD224A0"
			,"/em/cloud/request/05D8BF3C6D2A68EEE053B6277FD224A0"
			,"/em/cloud/request/05DA3C5FCF19A90EE053B6277FD27CD3"
			,"/em/cloud/request/03C2F4865F4E375AE053B6277FD2F2BC"
			,"/em/cloud/request/04EC88AB5EE6581BE053B6277FD264FD"
			,"/em/cloud/request/04EDF519C0440B06E053B6277FD20AC4"
			,"/em/cloud/request/0587ADE77CD722D4E053B6277FD2670F"
			,"/em/cloud/request/0587357537CD4B83E053B6277FD29D2A"
			,"/em/cloud/request/059B36F8E4EB2B69E053B6277FD22E47"
			,"/em/cloud/request/059B36F8E5012B69E053B6277FD22E47"
			,"/em/cloud/request/05D11B74EF34D83EE053B6277FD22FD0"
			,"/em/cloud/request/05D1179F96500DACE053B6277FD2A0E2"
			,"/em/cloud/request/05D1179F96540DACE053B6277FD2A0E2"
			,"/em/cloud/request/05D8BA6DE744B37CE053B6277FD28CED"
			,"/em/cloud/request/05DC76470DE23BBBE053B6277FD20811"
			,"/em/cloud/iaas/request/84/em/cloud/iaas/request/83"
			,"/em/cloud/iaas/request/82/em/cloud/iaas/request/81"
			,"/em/cloud/iaas/request/77/em/cloud/iaas/request/76"
			,"/em/cloud/iaas/request/75/em/cloud/iaas/request/74"
			,"/em/cloud/iaas/request/73/em/cloud/iaas/request/72"
			,"/em/cloud/iaas/request/71/em/cloud/iaas/request/70"
			,"/em/cloud/iaas/request/69/em/cloud/iaas/request/68"
			,"/em/cloud/iaas/request/67/em/cloud/iaas/request/66"
			,"/em/cloud/iaas/request/65/em/cloud/iaas/request/64"
			,"/em/cloud/iaas/request/63/em/cloud/iaas/request/62"
			,"/em/cloud/iaas/request/61/em/cloud/iaas/request/60"
			,"/em/cloud/iaas/request/59/em/cloud/iaas/request/58"
			,"/em/cloud/iaas/request/57/em/cloud/iaas/request/56"
			,"/em/cloud/iaas/request/55/em/cloud/iaas/request/54"
			,"/em/cloud/iaas/request/53/em/cloud/iaas/request/52"
			,"/em/cloud/iaas/request/51/em/cloud/iaas/request/50"
			,"/em/cloud/iaas/request/49/em/cloud/iaas/request/48"
			,"/em/cloud/iaas/request/47/em/cloud/iaas/request/46"
			,"/em/cloud/iaas/request/45/em/cloud/iaas/request/44"
			,"/em/cloud/iaas/request/43/em/cloud/iaas/request/42"
			,"/em/cloud/iaas/request/41/em/cloud/iaas/request/40"
			,"/em/cloud/iaas/request/39/em/cloud/iaas/request/38"
			,"/em/cloud/iaas/request/37/em/cloud/iaas/request/36"
			,"/em/cloud/iaas/request/35/em/cloud/iaas/request/34"
			,"/em/cloud/iaas/request/33/em/cloud/iaas/request/32"
			,"/em/cloud/iaas/request/31/em/cloud/iaas/request/30"
			,"/em/cloud/iaas/request/29/em/cloud/iaas/request/28"
			,"/em/cloud/iaas/request/27/em/cloud/iaas/request/26"
			,"/em/cloud/iaas/request/25/em/cloud/iaas/request/24"
			,"/em/cloud/iaas/request/23/em/cloud/iaas/request/22"
			,"/em/cloud/iaas/request/21/em/cloud/iaas/request/1"
   	];
	var accordionTmp = "<h3 style='color:RED'>#searchTitle#<h style='color:blue'>#searchUrl#</h><h style='color:green'>#searchDt#</h></h3> <div> <p>#content#</p> </div>";
			
	function dpTime(){
    	var now = new Date();
        hours = now.getHours();
        minutes = now.getMinutes();
        seconds = now.getSeconds();
 
        if (hours > 12){ hours -= 12; ampm = "오후 ";
        }else{ ampm = "오전 "; }
        if (hours < 10){ hours = "0" + hours; }
        if (minutes < 10){  minutes = "0" + minutes; }
        if (seconds < 10){ seconds = "0" + seconds; }
        return ampm + hours + ":" + minutes + ":" + seconds;
	}
	
	$(function() {
		$( "#cmd" ).autocomplete({ source: availableTags });
		var icons = {
			      header: "ui-icon-circle-arrow-e"
			      , activeHeader: "ui-icon-circle-arrow-s"
			    };
		$( "#accordion" ).accordion({
          	heightStyle: "content",
          	collapsible: true,
          	icons: icons
        });
	
		$( "#cmdBtn" ).button().click(function( event ) {
			event.preventDefault();
			parserAPI($("#cmd").val(),"one");
    	});
		$( "#cmdAllBtn" ).button().click(function( event ) {
			event.preventDefault();
			for(i=0; i<availableTags.length; i++){
				parserAPI(availableTags[i]);
			}
    	});
		$( "#cmdDelBtn" ).button().click(function( event ) {
			event.preventDefault();
			$("#accordion").empty();
    	});
  	});
	
	function parserAPI(cmd){
		
		$.ajax({
			url 		: "/em/search.do",
			type 		: "post",
			dataType 	: "json",
			async 		: true,
			data 		: "cmd="+cmd,
			success : function(rv) {
				var dt = eval("("+rv.DATA+")");
				var copySearchTmp = accordionTmp.replace(/#searchTitle#/gi, "[ " + dt.name + " ] ")
				  								.replace(/#searchUrl#/gi, cmd )
				  								.replace(/#searchDt#/gi, " [ "+dpTime()+ " ]")
				  								.replace(/#content#/gi, formatJson( rv.DATA ));
				$("#accordion").prepend(copySearchTmp);
				
				var splitDataArray = (rv.DATA).split("\"uri\" : \"");
				var cutDataArray = new Array(), cd, sd, ss, sr;
				for(i=1; i<splitDataArray.length; i++){
					cr = cmd.replace(/\//gi,"");
					sd = splitDataArray[i];
					ss = sd.split("\"");
					sr = ss[0].replace(/\//gi,"");
					
					if( cr != sr){ 
						cutDataArray.push(ss[0]);
					}
				}
				for(i=0; i<cutDataArray.length; i++){
					parserAPI2(cutDataArray[i]);
				}
			}, error : function(jqXHR, ajaxSettings, thrownError) {
				var copySearchTmp = accordionTmp.replace(/#searchTitle#/gi, "[ ERROR ] ")
												.replace(/#searchUrl#/gi, cmd)
												.replace(/#searchDt#/gi, "")
												.replace(/#content#/gi, formatJson( "No Contents" ));
				$("#accordion").append(copySearchTmp);
			}, complete : function(){
				$( "#accordion" ).accordion( "refresh" );
			}
		}).done(function(){
		});	
	}
	
	function parserAPI2(cmd){
		$.ajax({
			url 		: "/em/search.do",
			type 		: "post",
			dataType 	: "json",
			async 		: true,
			data 		: "cmd="+cmd,
			success : function(rv) {
				var dt = eval("("+rv.DATA+")");
				var copySearchTmp = accordionTmp.replace(/#searchTitle#/gi, "[ " + dt.name + " ] ")
				  								.replace(/#searchUrl#/gi, cmd )
				  								.replace(/#searchDt#/gi, " [ "+dpTime()+ " ]")
				  								.replace(/#content#/gi, formatJson( rv.DATA ));
				$("#accordion").prepend(copySearchTmp);
			}, error : function(jqXHR, ajaxSettings, thrownError) {
				var copySearchTmp = accordionTmp.replace(/#searchTitle#/gi, "[ ERROR ] ")
												.replace(/#searchUrl#/gi, cmd)
												.replace(/#searchDt#/gi, "")
												.replace(/#content#/gi, formatJson( "No Contents" ));
				$("#accordion").append(copySearchTmp);
			}, complete : function(){
				$( "#accordion" ).accordion( "refresh" );
			}
		}).done(function(){
		});	
	}
	
	function formatJson(jsonStr){
	    var f = { brace: 0 }; 
		var regeStr = jsonStr.replace(/({|}[,]*|[^{}:]+:[^{}:,]*[,{]*)/g, function (m, p1) {
		var rtnFn = function() {
		        return '<div style="text-indent: ' + (f['brace'] * 20) + 'px;">' + p1 + '</div>';
		    },
		    rtnStr = 0;
		    if (p1.lastIndexOf('{') === (p1.length - 1)) {
		        rtnStr = rtnFn(); f['brace'] += 1;
		    } else if (p1.indexOf('}') === 0) {
				f['brace'] -= 1; rtnStr = rtnFn();
		    } else {
		        rtnStr = rtnFn();
		    }
		    return rtnStr;
		});
		return regeStr;
	}
  </script>
</head>
<body>
	<form id="myForm">
		<div class="ui-widget">
		  <label for="cmd">EM URL : </label>
		  <input id="cmd" name="cmd" style="width:500px;">
		  <button id="cmdBtn">조회</button>
		  <button id="cmdAllBtn">전체조회</button>
		  <button id="cmdDelBtn">전체삭제</button>
		</div>
	</form>
	<div id="accordion"> </div>
	<div id="uri"> </div>
</body>
</html>