<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<!DOCTYPE html> <html class="hidden"> <head>
<%@ include file="/WEB-INF/jsp/common/include/meta.jsp"%><!-- Meta -->
<title>AZWELL CLOUD</title>
<link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="http://cdn.datatables.net/plug-ins/380cb78f450/integration/jqueryui/dataTables.jqueryui.css">
<link rel="stylesheet" type="text/css" href="http://jqueryui.com/resources/demos/style.css">
<!-- <link rel="stylesheet" type="text/css" href="http://datatables.net/release-datatables/media/css/jquery.dataTables.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="http://datatables.net/release-datatables/extensions/AutoFill/css/dataTables.autoFill.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="http://cdn.datatables.net/1.10.3/css/jquery.dataTables.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="http://datatables.net/release-datatables/extensions/Scroller/css/dataTables.scroller.css"> -->

<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script type="text/javascript" src="http://cdn.datatables.net/1.10.3/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="http://cdn.datatables.net/plug-ins/380cb78f450/integration/jqueryui/dataTables.jqueryui.js"></script>
<!-- <script type="text/javascript" language="javascript" src="http://cdn.datatables.net/plug-ins/380cb78f450/integration/bootstrap/3/dataTables.bootstrap.js"></script> -->
<!-- <script type="text/javascript" language="javascript" src="http://datatables.net/release-datatables/media/js/jquery.js"></script> -->
<!-- <script type="text/javascript" language="javascript" src="http://datatables.net/release-datatables/media/js/jquery.dataTables.js"></script> -->
<!-- <script type="text/javascript" language="javascript" src="http://datatables.net/release-datatables/extensions/AutoFill/js/dataTables.autoFill.js"></script> -->
<!-- <script type="text/javascript" language="javascript" src="http://datatables.net/release-datatables/extensions/Scroller/js/dataTables.scroller.js"></script> -->
<script type="text/javascript" src="/jquery.bpopup.min.js"></script>

<style>
.ui-tabs-vertical { width: 98% %;V }
.ui-tabs-vertical .ui-tabs-nav { padding: .1em .1em .1em .1em; float: left; width: 15%; }
.ui-tabs-vertical .ui-tabs-nav li {
	clear: left;
	width: 100%;
	border-bottom-width: 1px !important;
	border-right-width: 0 !important;
	margin: 0 -1px .2em 0;
}
.ui-tabs-vertical .ui-tabs-nav li a { display: block; }
.ui-tabs-vertical .ui-tabs-nav li.ui-tabs-active {
	padding-bottom: 0;
	padding-right: .1em;
	border-right-width: 1px;
	border-right-width: 1px;
}
.ui-tabs-vertical .ui-tabs-panel { padding: 1em; float: left; width: 1em; }
div.dataTables_wrapper { margin: 0 auto; }
#element_to_pop_up { display:none; }
</style>

<script type="text/javascript">
	var instance, popup, roleCnt;
	var keystone, data, image, flavor, console, vncconsole;
	$(document).bind('ajaxComplete', function(event, xhr, options) {
	    var redirectHeader = xhr.getResponseHeader('Location');
	    if(xhr.readyState == 4 && redirectHeader != null) {
	        window.location.href = redirectHeader;
	    }
	});
	
	$(function() {
		$( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
	    $( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
	    
	    instance = $('#InstanceTable').DataTable({ 
	    	  paging		: false
			, searching		: true
			, lengthChange	: false
	    });
	    $('#InstanceTable tbody').on( 'click', 'tr', function () {
	    	var rowData = instance.row( this ).data();
	    	var left 	= parseInt((screen.availWidth/2) - (width/2));
			var top 	= parseInt((screen.availHeight/2) - (height/2));
			var width 	= "720";
			var height	= "435";
			var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;

	    	window.open(rowData[10], "subWind", windowFeatures);
// 	    	window.open(rowData[10],"NVC Console", "width=800,height=600,scrollbars=yes,resizeable=no,left=800,top=600");
// 	    	$('element_to_pop_up').bPopup({
// 	            contentContainer:'.content',
// 	            loadUrl: rowData[11] //Uses jQuery.load()
// 	        });

	    } );
	    
	    instanceAPI();
	    
	    $( "#tabs" ).show( "drop", {percent: 100}, 500 );
	    
// 	    $("#logout").button();
// 	    $("#logout").click(function(){
// 	    	$.ajax({
// 				url 		: "/em/logout.do", type 		: "post", dataType 	: "json", async 		: false,
// 				success : function(rv) {
// 					$(location).attr("href",rv.URL);
// 				}, error : function(jqXHR, ajaxSettings, thrownError) { }
// 			});
// 	    });
  	});
	
	function instanceAPI(){
		$.ajax({
			  url 		: "/openstack/instance.do"
			, type 		: "post"
			, dataType 	: "json"
			, async 	: false,
			success : function(rv1) {
				keystone	= rv1.KEYSTONE;
				data		= rv1.DATA;
				image		= rv1.IMAGE;
				flavor		= rv1.FLAVOR;
				console		= rv1.CONSOLE;
				nvcconsole	= rv1.NVCCONSOLE;
				var nvcUrl		= "";
				var urlSplit 	= ""; 
				var imageName 	= "";
				var flavorName		= "";
				
				for(var i=0; i<data.length; i++){
					for(var x=0; x<image.length; x++){
						if(image[x]["id"] == data[i]["image"]["id"]){
							imageName = image[x]["name"];
						}
					}
					for(var x=0; x<flavor.length; x++){
						if(flavor[x]["id"] == data[i]["flavor"]["id"]){
							flavorName = flavor[x]["name"];
						}
					}
					for(var x=0; x<nvcconsole.length; x++){
						if( nvcconsole[x].id ==  data[i].id ){
							urlSplit = nvcconsole[x].consoleUrl.split(":");
							nvcUrl = "http://192.168.47.1:"+urlSplit[2];
						}
					}
					instance.row.add([
										  keystone["tenant"]["name"]
										, data[i]["hypervisorHostname"]
										, data[i]["name"]
										, imageName
										, data[i]["addresses"]["addresses"]["private"][0]["addr"]
										, flavorName
										, data[i]["status"]
										, "none"
										, data[i]["powerState"]
										, " "
										, nvcUrl
					]);
				}
			}, error : function(jqXHR, ajaxSettings, thrownError) { }
			, complete : function(){ instance.draw(); }
		});
	}
	
  </script>
</head>
<body>
<!-- 	<div > -->
<!-- 		<button id="logout">Logout</button> -->
<!-- 	</div> -->
	<div id="tabs" style="display: none">
		<ul>
			<li><a href="#Pools">인스턴스</a></li>
<!-- 			<li><a href="#Request">Flavors</a></li> -->
		</ul>
		<div id="Instance" style="width: 82%;">
			<table id="InstanceTable" class="display" cellspacing="0" width="100%">
				<thead>
					<tr>
						<th>프로젝트</th>
						<th>호스트</th>
						<th>이름</th>
						<th>이미지 이름</th>
						<th>IP 주소</th>
						<th>크기</th>
						<th>상태</th>
						<th>작업</th>
						<th>전원 상태</th>
						<th>생성된 이후 시간</th>
						<th>terminalUrl</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div id="templatesPopup" title=""></div>
	<div id="element_to_pop_up">Content of popup</div>
	
</body>
</html>