<%-- 
    Document   : adminManage
    Created on : Oct 30, 2018, 9:29:39 AM
    Author     : HEBA ALAA
--%>

<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>التحكم علي المستخدمين</title>
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
                 	   <% 
               HttpSession sessions = request.getSession(true);
               String username = (String)sessions.getAttribute("UserName");
               if(username==null){
               
                   %>
           <a href="userlogin">تسجيل دخول</a>
           <%} else {%>
           
           <div>اهلا ب يا<%=username%> <a href="userlogout">الخروج</a></div> 
           <%}%>
		<ul class="nav">
			<a href="searchforfarms"> <img
				src="resources/css/css/css/css/images/SEARCH.png" alt="SEARCH" /></a>
			<a href="who_we_are"><img
				src="resources/css/css/css/css/images/WHO ARE WE.png"
				alt="WHO ARE WE"></a>
			<a href="regulations_and_laws"><img
				src="resources/css/css/css/css/images/REGULATIONS AND LAWS.png"
				alt="REGULATIONS AND LAWS"></a>
			<a href="index"><img
				src="resources/css/css/css/css/images/HOME.png" alt="HOME"></a>
		</ul>
		<p class='cur_title'><title>التحكم علي المستخدمين</title></p>
		<img src="resources/css/css/css/css/images/projectname.png"
			alt="project name" class="projectname">
	
          
	</div>
	

	<div class="extra_noheight" style="dir: rtl;">
	<div align="center" id='user_list'></div>
        <div align="center">     
                         <% 
             
               if(request.getAttribute("adminmessage")==null){%> <%}
           else{%>
               
               <h2 style="color:red;"><%=request.getAttribute("adminmessage")%></h2><%}%> 
                </div>
      
        <script>
            window.onload = function() {
			
			usersjson = '${users}';
			var num_of_items = 0;
			var results = "";
			if (usersjson) {
				var users = JSON.parse(usersjson);
				
				var displayedownership = "";
                                var userName = "";
				var userMail = "";
				var userIdentifyNum = "";
				var userPhoneNumber = "";
				var userRole = "";
				for ( var i in users) {
					num_of_items = num_of_items + 1;
                                        
					if (users[i].name) {
						userName = users[i].name;
					} else {
						userName = "غير متوفر";
					}
					if (users[i].email) {
						userMail = users[i].email;
					} else {
						userMail = "غير متوفر";
					}

					if (users[i].identificationID) {
						userIdentifyNum = users[i].identificationID;
					} else {
						userIdentifyNum = "غير متوفر";
					}

					if (users[i].phoneNumber) {
						userPhoneNumber = users[i].phoneNumber;
					} else {
						userPhoneNumber = "غير متوفر";
					}
                                        if (users[i].roleid) {
						userRole = users[i].roleid;
						if(userRole === 1){
							displayedownership = "زائر";
						}
						if(userRole === 2){
							displayedownership = "مشرف الموقع";
						}
						if(userRole === 3){
							displayedownership = "موظف";
						}
						if(userRole === null){
							displayedownership = "غير متوفر";
						}
						if(userRole === 'غير متوفر'){
							displayedownership = "غير متوفر";
						}
					} else {
						userRole = "غير متوفر";
						displayedownership = "غير متوفر";
					}

					results = results
							+ '<tr class=\"resulttr\">'
                                                        +'<td style=\"width:5%;\"><div>'
                                                        + '<button onclick=\"edituserrole(\''
							+ userName
							+ '_'
							+ userMail
							+ '_'
							+ userIdentifyNum
							+ '_'
							+ userPhoneNumber
							+ '_'
							+ userRole
                                                        + '_'
							+  i
							+ '\')\" class=\"button\" id=\"editselectedBtn\">حفظ</button>' +'</div></td>'
                                                 + '<td align=\"right\" style=\"width:10%;\"><div style=\"word-break:break-all;\">'+
                                                 '<select id="user_role'+i+'" size="1" style="width:80px;">'
							+"<option value=''>"+displayedownership+"</option>"
							+"<option value="+'1'+">زائر</option>"
							+"<option value="+'2'+" >مشرف الموقع</option>"
							+"<option value="+'3'+" >موظف</option></select>"+'</div></td>' 
                                                + '<td align=\"right\" style=\"width:15%;\"><div style=\"word-break:break-all;\">' + userPhoneNumber
							+ '</div></td>'+ '<td align=\"right\" style=\"width:10%;\"><div style=\"word-break:break-all;\">' + userIdentifyNum
							+ '</div></td>' + 
                                                        '<td align=\"right\" style=\"width:25%;\"><div style=\"word-break:break-all;\">' + userMail
							+ '</div></td>' 
                                                        + '<td style=\"width:5%;\">'+'<input class=\"input-box\" type=\"text\"id=\"usernametxt'+i+'\" value=\"'+ userName+'\" readonly>'  + '</input></td>' + '</tr>';
				}

			}
			if (num_of_items > 0) {
				var search_header = '<div align=\"center\"><h3 align=\"center\">تم إيجاد '
						+ num_of_items
						+ ' من نتائج البحث </h3><br><table border=\"0\" align=\"center\" style=\"width:100%;\">'
						+ '<tr>'
                                                + '<th class=\"resultth\">تعديل</th>'
						+ '<th class=\"resultth\">الوظيفة</th>'
						+ '<th class=\"resultth\"> رقم التليفون </th>'
						+ '<th class=\"resultth\">رقم القومي</th>'
						+ '<th class=\"resultth\">البريد الالكتروني</th>'
						+ '<th class=\"resultth\"> اسم المستخدم </th>' + '</tr>';

				results = search_header + results
						+'</td></tr>'+ '</table></div><br><br><br><br>';
				document.getElementById('user_list').innerHTML = results;
			} else {
				//document.getElementById('searchResults').innerHTML = '<div align=\"center\"><h3>عفوا ، لا توجد نتائج</h3></div>';
			}}
                    
                    
                    function edituserrole(selecteduserdata) {
                        
                        var res = selecteduserdata.split("_");
			userName = res[0];
                        userRole=res[4];
                        num=res[5];
			
                        var userroledrp = document.getElementById("user_role"+num);
                                //  document.getElementById("usernametxt").value=userName;
                       var userrole= userroledrp.options[userroledrp.selectedIndex].text;
			//var strrole=$ ("#user_role: selected").val();
                      
                       var params = [userrole,userName];
			var location = "<c:url value='edituserrole'><c:param name='params' value='paramsvalues'/></c:url>";
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
	<div class="copyright">
		<p class="copyrighttext">
			Copyright © 2018, <a href="http://www.narss.sci.eg">NARSS</a>
		</p>
	</div>
</body>
</html>