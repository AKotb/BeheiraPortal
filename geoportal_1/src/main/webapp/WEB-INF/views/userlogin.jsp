<%-- 
    Document   : adminManage
    Created on : Oct 3, 2018, 9:29:39 AM
    Author     : HEBA ALAA
--%>
<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>تسجيل الدخول</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="author" content="Tooplate">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">

<!-- CSS -->
<link rel="stylesheet"
	href="resources/css/css/css/css/tooplate-style.css">
<link rel="stylesheet"
	href="resources/css/beheira.css">
	
</head>

<body>
		<div class="container">
		 
		<ul class="nav">
			<a href="searchforfarms"> <img
				src="resources/css/css/css/css/images/SEARCH.png" alt="SEARCH" /></a>
			<a href="who_we_are"><img
				src="resources/css/css/css/css/images/WHO ARE WE.png"
				alt="WHO ARE WE"></a>
			<a href="regulations_and_laws"><img
				src="resources/css/css/css/css/images/REGULATIONS AND LAWS.png"
				alt="REGULATIONS AND LAWS"></a>
			<a href="statistics"><img
				src="resources/css/css/css/css/images/STATISTICS.png"
				alt="STATISTICS"></a>
			<a href="index"><img
				src="resources/css/css/css/css/images/HOME.png" alt="HOME"></a>
                   
		</ul>
		<p class='cur_title'>تسجيل دخول</p>
		<img src="resources/css/css/css/css/images/projectname.png"
			alt="project name" class="projectname">
               
	</div>
	<div class="extra_noheight" style="dir: rtl;">
		<div id="searchForm" class="modal-content" align="center" >
		
                    <table border="0" style="dir: rtl;">
                        <tr>
					<td align="right" ><input type="text" class="input-box" id="username" name="username" /></td>
					<td  style="color: #3d6266;">اسم المستخدم</td>
				</tr>
		
		
		  <tr>
					<td align="right"><input type="password"class="input-box" id="password" name="password" /></td>
					<td  style="color: #3d6266;">رمز المرور</td>
				</tr>
		
		<tr>
		<td align="center"><button onclick="loginUser()" class="btnsearch" id="saveBtn">تسجيل دخول</button></td>
                <td align="center"><a href="register_form"> مستخدم جديد</a></td>
                
					
				</tr>
                                <tr><td align="center">
                         <% 
             HttpSession sessions = request.getSession(true);
               String errormsg = (String)sessions.getAttribute("loginmessage");
               if(errormsg==null){%> <%}
           else{%>
               
               <h2 style="color:red;"><%=errormsg%></h2><%}%> 
                </td>
                                </tr>
		<br/>
		
           
         
                        </table>
		</div>
        </div>
<script>

		function loginUser() {
			
		 username = document.getElementById("username").value;
                       password = document.getElementById("password").value;
			var params = [ username, password];
			var location = "<c:url value='user_login'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", params);
			window.location.href = location;
		}
	</script>
	<!-- SCRIPTS -->
	<script src="resources/javascript/js/js/js/jquery.js"></script>
	<script src="resources/javascript/js/js/js/bootstrap.min.js"></script>
	<script src="resources/javascript/js/js/js/jquery.sticky.js"></script>
	<script src="resources/javascript/js/js/js/jquery.stellar.min.js"></script>
	<script src="resources/javascript/js/js/js/wow.min.js"></script>
	<script src="resources/javascript/js/js/js/smoothscroll.js"></script>
	<script src="resources/javascript/js/js/js/owl.carousel.min.js"></script>
	<script src="resources/javascript/js/js/js/custom.js"></script>

	<!-- Footer -->
	
</body>
</html>