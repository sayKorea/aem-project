<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<!DOCTYPE html>
<html class="hidden">
<head>
<%@ include file="/WEB-INF/jsp/common/include/meta.jsp"%><!-- Meta -->
<title>JSPLUMB DEMO</title>
<link rel="stylesheet" type="text/css" href="http://www.guriddo.net/demo/css/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="http://www.guriddo.net/demo/css/trirand/ui.jqgrid.css">
<link rel="stylesheet" type="text/css" href="http://www.guriddo.net/demo/css/prettify.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Lato:400,700">
<!-- <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"> -->
<link rel="stylesheet" type="text/css" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="/common/css/demo-all.css">
<link rel="stylesheet" type="text/css" href="/common/css/demo.css">

<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script type="text/javascript" src="http://www.guriddo.net/demo/js/trirand/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="http://www.guriddo.net/demo/js/trirand/i18n/grid.locale-en.js"></script>
<script type="text/javascript" src="http://www.guriddo.net/demo/js/prettify/prettify.js"></script>

<!-- <script type="text/javascript" src="/common/js/jquery.ui.touch-punch.min.js"></script> -->
<!-- <script type="text/javascript" src="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script> -->
<script type="text/javascript" src="/common/js/jsBezier-0.6.js"></script>
<script type="text/javascript" src="/common/js/jsplumb-geom-0.1.js"></script>
<script type="text/javascript" src="/common/js/util.js"></script>
<script type="text/javascript" src="/common/js/dom-adapter.js"></script>
<script type="text/javascript" src="/common/js/jsPlumb.js"></script>
<script type="text/javascript" src="/common/js/endpoint.js"></script>
<script type="text/javascript" src="/common/js/connection.js"></script>
<script type="text/javascript" src="/common/js/anchors.js"></script>
<script type="text/javascript" src="/common/js/defaults.js"></script>

<!-- 연결선 종류-->
<!-- <script type="text/javascript" src="/common/js/connectors-bezier.js"></script> -->
<script type="text/javascript" src="/common/js/connectors-statemachine.js"></script>
<!-- <script type="text/javascript" src="/common/js/connectors-flowchart.js"></script> -->
<!-- <script type="text/javascript" src="/common/js/connector-editors.js"></script> -->

<!-- 화면그리는부분 -->
<script type="text/javascript" src="/common/js/renderers-svg.js"></script>
<script type="text/javascript" src="/common/js/renderers-canvas.js"></script>
<script type="text/javascript" src="/common/js/renderers-vml.js"></script>
<script type="text/javascript" src="/common/js/jquery.jsPlumb.js"></script>

<script type="text/javascript">
	$(document).bind('ajaxComplete', function(event, xhr, options) {
	    var redirectHeader = xhr.getResponseHeader('Location');
	    if(xhr.readyState == 4 && redirectHeader != null) {
	        window.location.href = redirectHeader;
	    }
	});
	
	$(function() {
		$("#jqGrid").jqGrid({
            url: "/jsplumb/batchData.do",
            mtype: "GET",
            datatype: "json",
            caption: 'JQGrid MASTER GRID',
            colModel: [
                { label: 'ID', 			name: 'ID', 	key: true, 	width: 75 },
                { label: 'POSITION',	name: 'POS', 				width: 150 },
                { label: 'LEVEL', 		name: 'LEVEL', 				width: 150 },
                { label: 'DESCRIPTION', name: 'DESC', 				width: 150 },
                { label: 'DATE', 		name: 'DATE', 				width: 150 }
            ],
			viewrecords: true,
            width: 780,
            height: 270,
            rowNum: 20,
            pager: "#jqGridPager",
            onSelectRow: function(rowid, selected) {
				if(rowid != null) {
					$( "#main" ).dialog( "open" );
				}					
			}
        });
		
		$( "#main" ).dialog({
	      	autoOpen: false,
	      	height: 800,
	        width: 1024,
	      	modal: true,
	        buttons: {
	          Close: function() {
	            $( this ).dialog( "close" );
	          }
	        }
	    }); 
  	});
	
	
	//JSPLUMB 스크립트 부분
	jsPlumb.ready(function() {
		var instance = jsPlumb.getInstance({
			Connector:"StateMachine",
// 			Connector:"Flowchart",
			PaintStyle:{ lineWidth:3, strokeStyle:"#ffa500", "dashstyle":"2 4" },
			Endpoint:[ "Dot", { radius:5 } ],
			EndpointStyle:{ fillStyle:"#ffa500" },
			Container:"perimeter-demo"
		});

		var shapes = jsPlumb.getSelector(".shape");			
		instance.draggable(shapes);
		  
		instance.doWhileSuspended(function() {	
			for (var i = 0; i < shapes.length; i++) {
				for (var j = i + 1; j < shapes.length; j++) {						
					instance.connect({
						source:shapes[i],  
						target:shapes[j],
						anchors:[
							[ "Perimeter", { shape:shapes[i].getAttribute("data-shape"), rotation:shapes[i].getAttribute("data-rotation") }],
							[ "Perimeter", { shape:shapes[j].getAttribute( "data-shape"), rotation:shapes[j].getAttribute("data-rotation") }]
						]
					});				
				}	
			}   
		});
  	});
	
  </script>
</head>
<body data-demo-id="flowchart" data-library="jquery">
	<table id="jqGrid"></table>
	<div id="jqGridPager"></div>
	<div id="main" title="JSPLUMB POPUP">
		<div id="perimeter-demo">
			<div class="shape" 		data-shape="Rectangle" 	style="left:380px;top:505px;">START</div>
			<div class="shape" 		data-shape="Ellipse" 	style="left:250px;top:300px;">Ellipse</div>
			<div class="shape" 		data-shape="Circle" 	style="left:100px;top:60px;">Circle</div>
			<div class="shape" 		data-shape="Circle" 	style="left:400px;top:150px;">QUESTION</div>
			<div class="shape" 		data-shape="Diamond" 	style="left:550px;top:150px;">CHOICE</div>
			<div class="shape" 		data-shape="Diamond" 	style="left:150px;top:250px;">CHECK</div>
			<div class="shape" 		data-shape="Triangle" 	style="left:700px; top:380px;">Triangle</div>
			<div class="shape _90" 	data-shape="Triangle" data-rotation="90" style="left:60px; top:500px;">90&#176; rotation</div>
		</div>
	</div>
</body>
</html>