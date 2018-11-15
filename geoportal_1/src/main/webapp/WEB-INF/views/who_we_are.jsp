<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>من نحن؟</title>
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
           <a href="userlogin" class ="loginanchor">تسجيل دخول</a>
           <%} else {%>
           
           <div>اهلا ب يا<%=username%> <a href="userlogout">الخروج</a> </div> 
           
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
		<p class='cur_title'>من نحن ؟</p>
		<img src="resources/css/css/css/css/images/projectname.png"
			alt="project name" class="projectname">
	</div>
	<div class="extra_noheight">
		<div id="searchForm" class="modal-content" align="center">
			<!-- <h1 class="formheader" align="center">من نحن ؟</h1> -->
			<h5 class='text-block'>
			بدأ نشاط الإستشعار من البعد فى مصر مع بداية السبعينات وتحديدا عام 1971 من خلال مشروع بحثى مشترك بأكاديمية البحث العلمى والتكنولوجيا مع جامعة أكلاهوما الأمريكية ثم تطور إلى إنشاء  مركز للاستشعار من البعد تابعا لأكاديمية البحث العلمى والتكنولوجيا عام 1972.

أنشئت الهيئة القومية للاستشعار من البعد وعلوم الفضاء عام 1991 كهيئة عامة تتبع وزارة البحث العلمى، ثم أعيد تنظيمها عام 1994 كهيئة قومية
<span style='color:blue'>
 بقرار رئيس الجمهورية رقم 261 لسنة 1994.
</span>
 <br>

تهدف الهيئة القومية للاستشعار من البعد وعلوم الفضاء إلى متابعة ونقل وتقديم أحدث التقنيات فى مجالات الاستشعار من البعد والتطبيقات السلمية لعلوم الفضاء، وبناء القدرات الذاتية لتطبيقها ونشر الاستفادة منها والتعاون مع مختلف مؤسسات الدولة لخدمة خطط وأهداف التنمية.
<a href="https://www.narss.sci.eg/" target="_blank">للمزيد اضغط هنا</a>
 
			</h5>
		</div>
	</div>

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