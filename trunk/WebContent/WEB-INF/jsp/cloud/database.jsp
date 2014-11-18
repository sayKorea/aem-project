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
</style>

<script>
	var databasePool, service, serviceProfile, quotas, popup, roleCnt;
	var reservationSpinner, retirementSpinner, archiveFreqSpinner;
	
	$(function() {
		reservationSpinner = $( "#reservationSpinner" ).spinner(); 	reservationSpinner.spinner( { min: 1,start: 1} );	reservationSpinner.spinner( "disable" ); 
		retirementSpinner = $( "#retirementSpinner" ).spinner(); 	retirementSpinner.spinner( { min: 1,start: 1} );	retirementSpinner.spinner( "disable" );
		archiveFreqSpinner= $( "#archiveFreqSpinner" ).spinner(); 	archiveFreqSpinner.spinner( { min: 1,start: 1});	archiveFreqSpinner.spinner( "disable" );
		
		$("#Request select").prop("disabled",true);
		
		$("#reservationRadio,#retirementRadio,#archiveFreqRadio").change( function(){
			var objtxt = $(this).attr("id").replace(/Radio/gi,"");
			if($(this).val()=="2"){
				$( "#"+objtxt+"Spinner" ).spinner("enable");
				$( "#"+objtxt+"Select" ).removeAttr("disabled");
			}else{
				$( "#"+objtxt+"Spinner" ).spinner("disable");
				$( "#"+objtxt+"Select" ).prop("disabled",true);
			}
		});
		
		$( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
	    $( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
	    
	    databasePool = $('#databasePool').DataTable({ 
	    	  paging		: false
			, searching		: true
			, lengthChange	: false
// 			, "scrollY"		: 200
// 			, deferRender:    true
// 	        , "scrollX"		: true
// 			, "scrollCollapse": true
//         	, "jQueryUI"	: true
			, columnDefs	: [
			                 	  { "targets": [ 6 ], "visible": false, "searchable": false }
				            	, { "targets": [ 7 ], "visible": false, "searchable": false }
				            ]
	    });
	    quotas = $('#quotasTable').DataTable({ 
	    	  paging		: false
			, searching		: true
			, lengthChange	: false
			, columnDefs	: [
			                 	  { "targets": [ 6 ], "visible": false, "searchable": false }
				            	, { "targets": [ 7 ], "visible": false, "searchable": false }
				            ]
	    });
	    serviceProfile = $('#serviceProfileTable').DataTable({ 
	    	  paging		: false
			, searching		: true
			, lengthChange	: false
			, columnDefs	: [
			                 	  { "targets": [ 3 ], "visible": false, "searchable": false }
				            	, { "targets": [ 4 ], "visible": false, "searchable": false }
				            ]
	    });
	    service = $('#serviceTable').DataTable({ 
	    	  paging		: false
			, searching		: true
			, lengthChange	: false
			, columnDefs	: [
			                 	  { "targets": [ 5 ], "visible": false, "searchable": false }
				            	, { "targets": [ 6 ], "visible": false, "searchable": false }
				            ]
	    });
	    $('#serviceTable tbody').on( 'click', 'tr', function () {
	    	var rowData = service.row( this ).data();
	   		$.ajax({
				url 		: "/em/search.do", type 		: "post", dataType 	: "json", async 		: false, data 		: "cmd="+rowData[5],
				success : function(rv) {
					var zt = eval("("+rv.DATA+")");
					$("#templatesPopup").empty();
					$("#templatesPopup").append(rv.DATA);
					popup.dialog("open");
					popup.dialog('option', 'title', rowData[0]+" Detail View");
				}, error : function(jqXHR, ajaxSettings, thrownError) { }
			});
	    } );
	    
	    
	    popup = $( "#templatesPopup" ).dialog({
	    	autoOpen: false,
	        height: 400,
	        width: 600,
	        modal: true,
	        buttons: {
	          "Close": function() { $( this ).dialog( "close" ); }
	        }
		});
	    
// 	    new $.fn.dataTable.AutoFill( databasePool );
// 	    new $.fn.dataTable.AutoFill( service );
// 	    new $.fn.dataTable.AutoFill( serviceProfile );
// 	    new $.fn.dataTable.AutoFill( quotas );
	    
	    databasePoolAPI();
	    requestAPI();
	    quotasAPI();
	    serviceTemplateAPI();
	    
	    $( "#tabs" ).show( "drop", {percent: 100}, 500 );
  	});
	
	function databasePoolAPI(){
		var url = "em/websvcs/restful/extws/cloudservices/admin/cfw/v1/softwarepools/";
		$.ajax({
			url 		: "/em/search.do", type 		: "post", dataType 	: "json", async 		: false, data 		: "cmd="+url,
			success : function(rv1) {
				var rvData1 = eval("("+rv1.DATA+")");
				for(i=0; i<rvData1.items.length; i++){
					$.ajax({
						url 		: "/em/search.do", type 		: "post", dataType 	: "json", async 		: false, data 		: "cmd="+url+rvData1.items[i].id,
						success : function(rv2) {
							var rvData2 = eval("("+rv2.DATA+")");
							var memType = rvData2.type=="Database Zone"?"Oracle 홈":"UNKNOW";
							databasePool.row.add([
								  rvData2.name
								, rvData2.owner
								, rvData2.zoneName
								, memType
								, rvData2.members.numberOfPoolMembers
								, rvData2.description
								, url
								, rvData2.id
							]);
						}, error : function(jqXHR, ajaxSettings, thrownError) { }
						, complete : function(){ databasePool.draw(); }
					});
				}
			}, error : function(jqXHR, ajaxSettings, thrownError) { }
		});
	}
	function requestAPI(){
		var url = "em/cloud/dbaas/requestsettings";
		$.ajax({
			url 		: "/em/search.do", type 		: "post", dataType 	: "json", async 		: false, data 		: "cmd="+url,
			success : function(rv1) {
				var rvData1 = eval("("+rv1.DATA+")");
				var frl, drp, mad, valTmp;
				
				frl = rvData1["Request Settings"]["futureReservationLength"];
				drp = rvData1["Request Settings"]["defaultRetirementPeriod"];
				mad = rvData1["Request Settings"]["maximumArchiveDuration"];
				
				if(frl != "No Reservation"){
					$("input:radio[name=reservationRadio][value='2']").attr("checked","checked");
					valTmp = frl.split(" ");
					reservationSpinner.spinner( "value",valTmp[0]);
					reservationSpinner.spinner( "enable" ); 
					$('#reservationSelect').val(valTmp[1]).removeAttr("disabled");
				}
				if(drp != "No Reservation"){
					$("input:radio[name=retirementRadio][value='2']").attr("checked","checked");
					valTmp = drp.split(" ");
					retirementSpinner.spinner( "value", valTmp[0] );
					retirementSpinner.spinner( "enable" ); 
					$('#retirementSelect').val(valTmp[1]).removeAttr("disabled");
				}
				if(mad != "No Reservation"){
					$("input:radio[name=archiveFreqRadio][value='2']").attr("checked","checked");
					valTmp = mad.split(" ");
					archiveFreqSpinner.spinner( "value", valTmp[0]);
					archiveFreqSpinner.spinner( "enable" ); 
					$('#archiveFreqSelect').val(valTmp[1]).removeAttr("disabled");
				}
// 				"futureReservationLength" : "1 Days" ,
// 				"defaultRetirementPeriod" : "No Reservation" ,
// 				"maximumArchiveDuration" : "No Reservation"
			}, error : function(jqXHR, ajaxSettings, thrownError) { }
		});
	}
	function quotasAPI(){
		var url = "em/cloud/dbaas/quota";
		$.ajax({
			url 		: "/em/search.do",
			type 		: "post",
			dataType 	: "json",
			async 		: false,
			data 		: "cmd="+url,
			success : function(rv1) {
				var rvData1 = eval("("+rv1.DATA+")");
				for(i=0; i<rvData1.Quotas.length; i++){
					quotas.row.add([
						  rvData1.Quotas[i]["Role Name"]
						, rvData1.Quotas[i]["Memory(GB)"]
						, rvData1.Quotas[i]["Storage(GB)"]
						, rvData1.Quotas[i]["Number of Database Requests"]
						, rvData1.Quotas[i]["Number of Schema Service Requests"]
						, rvData1.Quotas[i]["Number of Pluggable database Service Requests"]
						, rvData1.uri
						, rvData1.canonicalLink
					]);
				}
				roleCnt = rvData1.Quotas.length;
			}, error : function(jqXHR, ajaxSettings, thrownError) { }
			, complete : function(){ quotas.draw(); }
		});
	}
	
	function serviceTemplateAPI(){
		var creator="";
		var url = "em/cloud/service_family_type/dbaas";
		$.ajax({
			url 		: "/em/search.do", type 		: "post", dataType 	: "json", async 		: false, data 		: "cmd="+url,
			success : function(rv1) {
				var rv1Data = eval("("+rv1.DATA+")");
				var zonesCount;
				for(i=0; i<rv1Data.service_templates.elements.length; i++){
// 					rowText = "";
// 					rowText += "<tr>";
// 					rowText += "<td>"+dt.service_templates.elements[i].name+"</td>";
// 					rowText += "<td>"+"</td>";
// 					rowText += "<td>"+"</td>";
// 					rowText += "<td>"+"</td>";
// 					rowText += "<td>"+dt.service_templates.elements[i].description+"</td>";
// 					rowText += "</tr>";
					$.ajax({
						url 		: "/em/search.do",
						type 		: "post",
						dataType 	: "json",
						async 		: false,
						data 		: "cmd="+rv1Data.service_templates.elements[i].uri,
						success : function(rv2) {
							var rv2Data = eval("("+rv2.DATA+")");
							zonesCount = rv2Data.zones.total;
						}, error : function(jqXHR, ajaxSettings, thrownError) { }
					});
				
					service.row.add([
						  rv1Data.service_templates.elements[i].name
						, creator
						, zonesCount
						, ""
						, rv1Data.service_templates.elements[i].description
						, rv1Data.service_templates.elements[i].uri
						, rv1Data.service_templates.elements[i].canonicalLink
					]);
				}
			}, error : function(jqXHR, ajaxSettings, thrownError) {
				//ajaxJsonErrorAlert(jqXHR, ajaxSettings, thrownError);
			}, complete : function(){ service.draw(); }
		}).done(function(){
// 			$( "#accordion" ).accordion( "refresh" );//alert("done");
		});	
	}
	
  </script>
</head>
<body>
	<div id="tabs" style="display: none">
		<ul>
			<li><a href="#Pools">데이터베이스 풀</a></li>
			<li><a href="#Request">요청 설정</a></li>
			<li><a href="#Quotas">할당량</a></li>
			<li><a href="#Templates">프로파일 및 서비스 템플릿</a></li>

		</ul>
		<div id="Pools" style="width: 82%;">
			<table id="databasePool" class="display" cellspacing="0" width="100%">
				<h2>데이터베이스 풀</h2>
				<p>데이터베이스 풀이란 셀프 서비스 사용자가 요청한 서비스 인스턴스를 프로비전하는 데 사용되는 Oracle 홈이나
					데이터베이스 또는 컨테이너 데이터베이스의 동일 기종 모음입니다. 풀 내의 모든 엔티티는 동일한 버전과 플랫폼을 사용해야
					하며, 동일한 PaaS 기반 구조 영역에 속해야 합니다.</p>
				<thead>
					<tr>
						<th>풀이름</th>
						<th>소유자</th>
						<th>PasS 기반 구조영역</th>
						<th>멤버 대상 유형</th>
						<th>대상</th>
						<th>설명</th>
						<th>HIDDEN URI</th>
						<th>HIDDEN CANONICALLINK</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="Request" style="width: 82%;">
			<table id="requestTable" class="display" cellspacing="0" width="100%">
				<h2>요청 설정</h2>
				<fieldset>
					<legend>이후 요청 일정 기간</legend>
					<p>셀프 서비스 사용자가 미리 요청 일정을 잡을 수 있는 기간입니다.</p>
					<br> <input type="radio" id="reservationRadio"
						name="reservationRadio" value="1" checked> <label
						for="reservationRadio">제한 없음</label><br> <input type="radio"
						id="reservationRadio" name="reservationRadio" value="2"> <label
						for="reservationRadio">제한 기간</label> <input
						id="reservationSpinner" name="reservationSpinner"
						style="width: 20px"> <select name="reservationSelect"
						id="reservationSelect">
						<option value="Days" selected="selected">일</option>
						<option value="Weeks">주</option>
						<option value="Months">개월</option>
						<option value="Years">년</option>
					</select>
				</fieldset>
				<fieldset>
					<legend>기본 보존 기간</legend>
					<p>셀프 서비스 사용자가 서비스 인스턴스를 보존할 수 있는 최대 기간입니다.</p>
					<br> <input type="radio" id="retirementRadio"
						name="retirementRadio" value="1" checked> <label
						for="retirementRadio">제한 없음</label><br> <input type="radio"
						id="retirementRadio" name="retirementRadio" value="2"> <label
						for="retirementRadio">제한 기간</label> <input id="retirementSpinner"
						name="retirementSpinner" style="width: 20px"> <select
						name="retirementSelect" id="retirementSelect">
						<option value="Days" selected="selected">일</option>
						<option value="Weeks">주</option>
						<option value="Months">개월</option>
						<option value="Years">년</option>
					</select>
				</fieldset>
				<fieldset>
					<legend>요청 비우기 기간</legend>
					<p>셀프 서비스 생성 요청이 저장소에서 비워지는 '완료됨' 이후의 기간입니다.</p>
					<br> <input type="radio" id="archiveFreqRadio"
						name="archiveFreqRadio" value="1" checked> <label
						for="archiveFreqRadio">제한 없음</label><br> <input type="radio"
						id="archiveFreqRadio" name="archiveFreqRadio" value="2"> <label
						for="archiveFreqRadio">제한 기간</label> <input
						id="archiveFreqSpinner" name="archiveFreqSpinner"
						style="width: 20px"> <select name="archiveFreqSelect"
						id="archiveFreqSelect">
						<option value="Days" selected="selected">일</option>
						<option value="Weeks">주</option>
						<option value="Months">개월</option>
						<option value="Years">년</option>
					</select>
				</fieldset>
			</table>
		</div>
		<div id="Quotas" style="width: 82%;">
			<table id="quotasTable" class="display" cellspacing="0" width="100%">
				<h2>할당량</h2>
				<p>할당량은 제공된 롤에 속해 있는 셀프 서비스 사용자별로 계산되며, 사용자가 한번에 차지할 수 있는 리소스 양에
					대한 집계입니다. 할당량은 셀프 서비스 응용 프로그램을 통해 프로비전되는 서비스 인스턴스에만 적용됩니다.</p>
				<thead>
					<tr>
						<th>롤이름</th>
						<th>메모리(GB)</th>
						<th>저장 영역(GB)</th>
						<th>데이터베이스 요청 수</th>
						<th>스키마 서비스 요청 수</th>
						<th>플러그 가능 데이터베이스 서비스 요청 수</th>
						<th>HIDDEN URI</th>
						<th>HIDDEN CANONICALLINK</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="Templates" style="width: 82%;">
			<table id="serviceProfileTable" class="display" cellspacing="0"
				width="100%">
				<h2>프로파일</h2>
				<p>프로파일은 프로비전을 위해 소스 데이터베이스 정보를 캡처하는 엔티티입니다. 프로파일은 전체 데이터베이스를
					나타내거나 응용 프로그램을 형성하는 관련 스키마 집합을 나타낼 수 있습니다.</p>
				<thead>
					<tr>
						<th>이름</th>
						<th>설명</th>
						<th>유형</th>
						<th>HIDDEN URI</th>
						<th>HIDDEN CANONICALLINK</th>
					</tr>
				</thead>
			</table>
			<table id="serviceTable" class="display" cellspacing="0" width="100%">
				<h2>서비스 템플리트</h2>
				<p>서비스 템플리트는 데이터베이스나 스키마를 생성하기 위해 셀프 서비스 사용자에게 제공되는 표준화된 서비스
					정의입니다.</p>
				<thead>
					<tr>
						<th>서비스 템플리트 이름</th>
						<th>생성자</th>
						<th>영역</th>
						<th>롤</th>
						<th>설명</th>
						<th>HIDDEN URI</th>
						<th>HIDDEN CANONICALLINK</th>
					</tr>
				</thead>

				<!--         <tfoot> -->
				<!--             <tr> -->
				<!--                 <th>Name</th> -->
				<!--                 <th>Position</th> -->
				<!--                 <th>Office</th> -->
				<!--                 <th>Age</th> -->
				<!--                 <th>Start date</th> -->
				<!--                 <th>Salary</th> -->
				<!--             </tr> -->
				<!--         </tfoot> -->

			</table>
		</div>
	</div>
	<div id="templatesPopup" title=""></div>
</body>
</html>