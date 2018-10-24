<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>

<title>المرئيات الفضائية</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="author" content="Tooplate">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<!-- CSS -->
<link rel="stylesheet"
	href="resources/css/css/css/css/tooplate-style.css">
<link rel="stylesheet" href="resources/css/beheira.css">


<style>
.img_slider {
	position: absolute;
}
</style>
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
			<a href="index"><img
				src="resources/css/css/css/css/images/HOME.png" alt="HOME"></a>
		</ul>
		<p class='cur_title'>مرئيات فضائية</p>
		<img src="resources/css/css/css/css/images/projectname.png"
			alt="project name" class="projectname">
	</div>
	<div id="extra">
		<!-- <div class="floating-menu">
		    <h3>Layers Information</h3>
		    <h4>Top Layer:</h4>
		    <h5>Sentinel2 Septemper 2018</h5>
		    <h4>Bottom Layer:</h4>
		    <h5>Pleiades March 2017</h5>
	  	</div> -->
		<div id="floating-panel" align='center'>
			<!-- id="floating-panel" class="slidecontainer" -->
			<input class="slider" type="range" min="0" max="100" value="0"
				id="myRange">
			<!-- class="slider" -->
		</div>
		<div id="raster_view">
			<img id='img1' class='img_slider' src='resources/rasterimages/0.png'>
			<div id='img1_title' class='legend'>
				<p class='img_title bottom_title'>Pleiades March 2017</p>
			</div>
			<img id='img2' class='img_slider' src='resources/rasterimages/0.png'>
			<div id='img2_title' class='legend'>
				<p class='img_title top_title'>Sentinel2 Septemper 2018</p>
			</div>
			<div id='controlbuttons' class='control_buttons'>
				<a href="javascript:void(0);" onclick="move();" class="button">استخدامات
					الأراضى</a> <a href="javascript:void(0);" onclick="vouchers();"
					class="button">طلب إجراءات التقنين</a> 
					<a href="javascript:void(0);" onclick="gotoMahdar();" target="_blank" class="button">محضر معاينة</a> 
					<a href="javascript:void(0);"
					onclick="back();" class="button">رجوع</a>
			</div>
		</div>
	</div>
	<script>
		var id = "${polygonID}";
		var lat = "${lat}";
		var lng = "${lng}";
		document.getElementById('img1').src = 'resources/rasterimages/png_new/'
				+ id + '.png';
		document.getElementById('img2').src = 'resources/rasterimages/png_old/'
				+ id + '.png';
		var img_height = 500;
		var img_width = 800;
		window.onload = function() {
			new_width = document.getElementById("img2").width;
			new_height = document.getElementById("img2").height;
			img_height = new_height;
			img_width = new_width;
			document.getElementById("img1").width = new_width;
			document.getElementById("img1").height = new_height;
			if(new_width > 800){
				ratio = new_height / new_width;
				new_height = ratio * 800;
				new_width = 800;
			}
			
			ratio = new_width / new_height;
			new_height = 500;
			new_width = ratio * 500;
			
			img_height = new_height;
			img_width = new_width;
			/*if(new_height > 500){
				ratio = new_width / new_height;
				img_height = 500;
				img_width = ratio * 500;
			}
			else{
				img_width = new_width;
				img_height = new_height;
				
			}*/
			
			document.getElementById("img2").width = img_width;
			document.getElementById("img2").height = img_height;
			document.getElementById("img1").width = img_width;
			document.getElementById("img1").height = img_height;
			
			document.getElementById("img2_title").width = img_width;
			document.getElementById("img2_title").height = img_height;
			document.getElementById("img1_title").width = img_width;
			document.getElementById("img1_title").height = img_height;
			//document.getElementById("myRange").style.width = img_width;
			
			shift = (document.getElementById("img2").parentElement.clientWidth - img_width) / 2;
			document.getElementById("img1").style.left = shift + 'px';
			document.getElementById("img2").style.left = shift + 'px';
			
			document.getElementById("img1_title").style.left = shift + 'px';
			document.getElementById("img2_title").style.left = shift + 'px';
			//document.getElementById("myRange").style.left = shift + 'px';
			
		};

		var slider = document.getElementById("myRange");
		slider.oninput = function() {
			document.getElementById("img1").style.clip = "rect(0," + img_width
					+ "px, " + img_height + "px, " + "0px)";
			document.getElementById("img2").style.clip = "rect(0," + img_width
					+ "px, " + img_height + "px, " + 0.01 * img_width
					* this.value + "px)";

			document.getElementById("img1_title").style.clip = "rect(0,"
					+ img_width + "px, " + img_height + "px, " + "0px)";
			document.getElementById("img2_title").style.clip = "rect(0,"
					+ img_width + "px, " + img_height + "px, " + 0.01
					* img_width * this.value + "px)";

		}

		function vouchers() {
			var params = [ id, lat, lng ];
			var location = "<c:url value='vouchers'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", params);
			window.location.href = location;
		}

		function move() {
			var params = [ id, lat, lng ];
			var location = "<c:url value='arealayers'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", params);
			window.location.href = location;
		}

		function back() {
			var params = [ id, lat, lng ];
			var location = "<c:url value='showonmap'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", params);
			window.location.href = location;
		}
		
		function gotoMahdar() {
			var location;
			if (200 == urlExists('resources/mahader/' + id + '.png')) {
				location = 'resources/mahader/' + id + '.png';
			}else{
				location = 'resources/mahader/" + 0 + ".png';
			}
			window.location.href = location;
		}
		
		function urlExists(checkedurl) {
			var http = $.ajax({
				type : "HEAD",
				url : checkedurl,
				async : false
			})
			return http.status;
			// this will return 200 on success, and 0 or negative value on error
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