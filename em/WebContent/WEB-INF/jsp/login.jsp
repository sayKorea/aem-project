<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<!DOCTYPE html>
<html class="hidden">
<head>
<%@ include file="/WEB-INF/jsp/common/include/meta.jsp"%><!-- Meta -->
<title>Azwell EM Login</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<style type="text/css">
* {
	box-sizing: border-box;
	padding: 0;
	margin: 0;
}

body {
	font-family: "HelveticaNeue-Light", "Helvetica Neue Light",
		"Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
	color: white;
	font-size: 12px;
	background: #333;
}

form {
	background: #111;
	width: 300px;
	margin: 30px auto;
	border-radius: 0.4em;
	border: 1px solid #191919;
	overflow: hidden;
	position: relative;
	box-shadow: 0 5px 10px 5px rgba(0, 0, 0, 0.2);
}

form:after {
	content: "";
	display: block;
	position: absolute;
	height: 1px;
	width: 100px;
	left: 20%;
	background: linear-gradient(left, #111, #444, #b6b6b8, #444, #111);
	top: 0;
}

form:before {
	content: "";
	display: block;
	position: absolute;
	width: 8px;
	height: 5px;
	border-radius: 50%;
	left: 34%;
	top: -7px;
	box-shadow: 0 0 6px 4px #fff;
}

.inset {
	padding: 20px;
	border-top: 1px solid #19191a;
}

form h1 {
	font-size: 18px;
	text-shadow: 0 1px 0 black;
	text-align: center;
	padding: 15px 0;
	border-bottom: 1px solid rgba(0, 0, 0, 1);
	position: relative;
}

form h1:after {
	content: "";
	display: block;
	width: 250px;
	height: 100px;
	position: absolute;
	top: 0;
	left: 50px;
	pointer-events: none;
	transform: rotate(70deg);
	-webkit-transform: rotate(70deg);
	background: linear-gradient(50deg, rgba(255, 255, 255, 0.15),
		rgba(0, 0, 0, 0) );
	background-image: -webkit-linear-gradient(50deg, rgba(255, 255, 255, 0.05),
		rgba(0, 0, 0, 0) ); /* For Safari */
}

label {
	color: #666;
	display: block;
	padding-bottom: 9px;
}

input[type=text],input[type=password] {
	width: 100%;
	padding: 8px 5px;
	background: linear-gradient(#1f2124, #27292c);
	border: 1px solid #222;
	box-shadow: 0 1px 0 rgba(255, 255, 255, 0.1);
	border-radius: 0.3em;
	margin-bottom: 20px;
	color:white;
}

label[for=remember] {
	color: white;
	display: inline-block;
	padding-bottom: 0;
	padding-top: 5px;
}

input[type=checkbox] {
	display: inline-block;
	vertical-align: top;
}

.p-container {
	padding: 0 20px 20px 20px;
}

.p-container:after {
	clear: both;
	display: table;
	content: "";
}

.p-container span {
	display: block;
	float: left;
	color: #0d93ff;
	padding-top: 8px;
}

input[type=button] {
	padding: 5px 20px;
	border: 1px solid rgba(0, 0, 0, 0.4);
	text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.4);
	box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.3), inset 0 10px 10px
		rgba(255, 255, 255, 0.1);
	border-radius: 0.3em;
	background: #0184ff;
	color: white;
	float: right;
	font-weight: bold;
	cursor: pointer;
	font-size: 13px;
}

input[type=button]:hover {
	box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.3), inset 0 -10px 10px
		rgba(255, 255, 255, 0.1);
}

input[type=text]:hover,input[type=password]:hover,label:hover  ~ input[type=text],label:hover 
	~ input[type=password] {
	background: #27292c;
}
</style>
<script type="text/javascript">
	$(function(){
		$("#go").click(function(){
			event.preventDefault();
			validation();
		});
		
		$("#userid,#password").keyup(function(event){
			if ( event.which == 13 ) {
			    event.preventDefault();
			    validation();
			}
		});
		
		$("#userid").focus();
	});
	function validation(){
		if( $.trim($("#userid").val()) == ""){
			alert("사용자 ID를 입력 하세요."); return false;
		}
		if( $.trim($("#password").val()) == ""){
			alert("사용자 PASSWORD를 입력 하세요."); return false;
		}
		login();
	}
	function login(){
		$.ajax({
			url 		: "/em/login.do",
			type 		: "post",
			dataType 	: "json",
			async 		: false,
			data 		: $("#loginForm").serialize(),
			success : function(rv) {
				$(".p-container > span").text(rv.DATA);
				$(location).attr("href", rv.URL);
			}, error : function(jqXHR, ajaxSettings, thrownError) { 
				$(".p-container > span").text("Login Error");
			}
		});
	}
	
</script>
</head>
<body>

	<form id="loginForm">
		<h1>Enterprise Manager Log in</h1>
		<div class="inset">
			<p> <label for="email">USER ID</label> <input type="text" name="userid" id="userid"> </p>
			<p> <label for="password">PASSWORD</label> <input type="password" name="password" id="password"> </p>
			<!--   <p> -->
			<!--     <input type="checkbox" name="remember" id="remember"> -->
			<!--     <label for="remember">Remember me for 14 days</label> -->
			<!--   </p> -->
		</div>
		<p class="p-container">
			<span></span> <input type="button" name="go" id="go" value="Log in">
		</p>
	</form>

</body>
</html>
