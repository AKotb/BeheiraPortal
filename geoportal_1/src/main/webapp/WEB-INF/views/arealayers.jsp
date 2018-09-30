<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>

<title>استخدامات الاراضى</title>

<!-- meta tags -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="author" content="Tooplate">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<!-- CSS -->
<link rel="stylesheet"	href="resources/css/css/css/css/tooplate-style.css">
<link rel="stylesheet" href="resources/css/beheira.css">
</head>

<body>
<!-- Leaflet library -->
<script src="resources/jquery/jquery-3.1.1.min.js"></script>
<script src="resources/leaflet/leaflet.js"></script>
	<div class="container">
		<ul class="nav">
			<a href="searchforfarms"><img
				src="resources/css/css/css/css/images/SEARCH.png" alt="SEARCH"></a>
			<a href="who_we_are"><img
				src="resources/css/css/css/css/images/WHO ARE WE.png"
				alt="WHO ARE WE"></a>
			<a href="regulations_and_laws"><img
				src="resources/css/css/css/css/images/REGULATIONS AND LAWS.png"
				alt="REGULATIONS AND LAWS"></a>
			<a href="index"><img
				src="resources/css/css/css/css/images/HOME.png" alt="HOME"></a>
		</ul>
		<img src="resources/css/css/css/css/images/projectname.png"
			alt="project name" class="projectname">
	</div>
	<div id="extra"></div>
	<script>
		id = "${polygonID}";
		lat = "${lat}";
		lng = "${lng}";
		farmjson = '${farmdata}';
		farmdata = JSON.parse(farmjson);
		var map;
		var infowindow;
		function initMap() {
			var Egypt = {
				lat : 30.2519715,
				lng : 30.2761235
			};
			map = new google.maps.Map(document.getElementById('extra'), {
				zoom : 11,
				center : Egypt,
				mapTypeId : 'hybrid'
			});
			map.setZoom(15);
			map.setCenter(new google.maps.LatLng(lat, lng));
			var admin_layer = new google.maps.Data({map: map});
			var landuse_layer = new google.maps.Data({map: map});
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/innerlayers/admin_'+id+'.json')) {
				//map.data.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/innerlayers/admin_'+id+'.json'); 
				admin_layer.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/innerlayers/admin_'+id+'.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/innerlayers/landuse_'+id+'.json')) {
				//map.data.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/innerlayers/landuse_'+id+'.json');
				landuse_layer.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/innerlayers/landuse_'+id+'.json');
			}
			infowindow = new google.maps.InfoWindow();
			admin_layer.setStyle(function(feature) {
					return ({
						fillColor : 'transparent',
						strokeColor : 'black',
						strokeWeight : 2
					});
			});
			landuse_layer.setStyle(function(feature) {
				var landusecode = feature.getProperty('LanduseCod');
				if(landusecode == '1'){
					return ({
						fillColor : 'red',
						strokeColor : 'red',
						strokeWeight : 2
					});
				}
				if(landusecode == '2'){
					return ({
						fillColor : 'lightgreen',
						strokeColor : 'lightgreen',
						strokeWeight : 2
					});
				}
				if(landusecode == '3'){
					return ({
						fillColor : 'darkgreen',
						strokeColor : 'darkgreen',
						strokeWeight : 2
					});
				}
				if(landusecode == '4'){
					return ({
						fillColor : 'orange',
						strokeColor : 'orange',
						strokeWeight : 2
					});
				}
				if(landusecode == '5'){
					return ({
						fillColor : 'lightgray',
						strokeColor : 'lightgray',
						strokeWeight : 2
					});
				}
			});
			landuse_layer.addListener('click', function(event) {
				landuse_layer.revertStyle();
				landuse_layer.overrideStyle(event.feature, {
					strokeWeight : 4,
					fillColor : 'yellow'
				});
				var arname = 'غير متوفر';
				var landusecode = event.feature.getProperty('LanduseCod');
				if(landusecode == '1'){
					arname = 'مباني';
				}
				if(landusecode == '2'){
					arname = 'أراضي منزرعة-محاصيل حقلية';
				}
				if(landusecode == '3'){
					arname = 'أراضي منزرعة-محاصيل بستانية';
				}
				if(landusecode == '4'){
					arname = 'أراضي مستصلحة';
				}
				if(landusecode == '5'){
					arname = 'أراضي غير مستغلة';
				}
				/* var arname = event.feature.getProperty('Ar_Name');
				if (arname) {
					arname = arname;
				} else {
					arname = "غير متوفر";
				}
				var enname = event.feature.getProperty('EN_Name');
				if (enname) {
					enname = enname;
				} else {
					enname = "غير متوفر";
				}
				var area = event.feature.getProperty('Area');
				var feddan;
				var qirat;
				var sahm;
				if (area) {
					area = area;
					var areaspace = area.toString();
					var fedarr = areaspace.split(".");
					feddan = fedarr[0];
					var frac_fed = areaspace - fedarr[0];
					var qiratstr = (frac_fed * 24).toString();
					var qiratarr = qiratstr.split(".");
					qirat = qiratarr[0];
					var frac_qirat = qiratstr - qirat;
					var sahmstr = (frac_qirat * 24).toString();
					var sahmarr = sahmstr.split(".");
					sahm = sahmarr[0];
				} else {
					area = "0";
					feddan = "غير متوفر";
					qirat = "غير متوفر";
					sahm = "غير متوفر";
				} */
				if (farmdata.farmID) {
					db_farmid = farmdata.farmID;
				} else {
					db_farmid = "غير متوفر";
				}
				if (farmdata.farmName) {
					db_farmname = farmdata.farmName;
				} else {
					db_farmname = "غير متوفر";
				}
				if (farmdata.reclamedArea) {
					db_reclamedArea = farmdata.reclamedArea;
				} else {
					db_reclamedArea = "غير متوفر";
				}
				if (farmdata.urbanArea) {
					db_urbanArea = farmdata.urbanArea;
				} else {
					db_urbanArea = "غير متوفر";
				}
				if (farmdata.unusedArea) {
					db_unusedArea = farmdata.unusedArea;
				} else {
					db_unusedArea = "غير متوفر";
				}
				if (farmdata.fieldCropsArea) {
					db_fieldCropsArea = farmdata.fieldCropsArea;
				} else {
					db_fieldCropsArea = "غير متوفر";
				}
				if (farmdata.cropsArea) {
					db_cropsArea = farmdata.cropsArea;
				} else {
					db_cropsArea = "غير متوفر";
				}

				var link4 = "<a href=\'resources/datafiles/landuse/"+db_farmid+".jpg\' target='_blank'><img class=\'infowindowimg\' src=\'resources/datafiles/landuse/"+db_farmid+".jpg\' alt=\'Icon\' style=\"width:300px;height:170px;\"></a>";
				var content = "<div style=\"text-align:center; overflow:hidden;\"><h1 style=\"background-color: #44a959;\">"
					+ "بيانات قطعة الأرض" + "</h1><br>"
					+ link4
					+ "<br>"
					+ "<table class=\"outertable\" style=\"dir: rtl;\"><tr><td class=\'td\'>"
					+ db_farmid
					+ "</td><td class=\'rightcolumn\'>كود المزرعة / الشركة</td></tr><tr><td class=\'td\'>"
					+ db_farmname
					+ "</td><td class=\'rightcolumn\'>اسم المزرعة / الشركة</td></tr><tr><td colspan='2' style=\"text-align:center; overflow:hidden; background-color: #44a959;\" >إجمالي المساحات المستخدمة</td></tr><tr><td class=\'td\'>"
					+ db_fieldCropsArea
					+ "</td><td class=\'rightcolumn\'>محاصيل حقلية</td></tr><tr><td class=\'td\'>"
					+ db_cropsArea
					+ "</td><td class=\'rightcolumn\'>محاصيل بستانية</td></tr><tr><td class=\'td\'>"
					+ db_reclamedArea
					+ "</td><td class=\'rightcolumn\'>مستصلحة</td></tr><tr><td class=\'td\'>"
					+ db_urbanArea
					+ "</td><td class=\'rightcolumn\'>مباني</td></tr><tr><td class=\'td\'>"
					+ db_unusedArea
					+ "</td><td class=\'rightcolumn\'>غير مستغلة</td></tr></table>"
					+ "<br><h1 style=\"background-color: #44a959;\">"
					+ arname
					+ "</h1>"
					+ "<span onclick='close_infowindow()' class='searchClose'>[&times;]</span></div>";
				
				/* var content = "<div style=\"text-align:center; overflow:hidden;\"><h1 style=\"background-color: #396266;\">"
						+ "بيانات قطعة الأرض"
						+ "</h1><br>"
						+ "<table class=\"outertable\" style=\"dir: rtl;\"><tr><td class=\'td\'>"
						+ arname
						+ "</td><td class=\'rightcolumn\'>الاسم باللغة العربية</td></tr><tr><td class=\'td\'>"
						+ enname
						+ "</td><td class=\'rightcolumn\'>الاسم باللغة الانجليزية</td></tr><tr><td class=\'td\'><table class=\"innertable\"><tr><td class=\'td\'>س</td><td class=\'td\'>ط</td><td class=\'td\'>ف</td></tr><tr><td class=\'td\'>"
						+ sahm
						+ "</td><td class=\'td\'>"
						+ qirat
						+ "</td><td class=\'td\'>"
						+ feddan
						+ "</td></tr></table>"
						+ "</td><td class=\'rightcolumn\'>المساحة</td></tr></table><br>"
						+ "</div>"; */

				infowindow.setContent(content);
				infowindow.setPosition(event.feature.getGeometry().getAt(0).getAt(0));
				infowindow.setOptions({
					pixelOffset : new google.maps.Size(0, -30)
				});
				infowindow.open(map);
			});

			landuse_layer.addListener('mouseover',function(event) {});
			landuse_layer.addListener('mouseout', function(event) {
				landuse_layer.revertStyle();
				//infowindow.close();
			});
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
		
		function close_infowindow() {
			//alert("Closing info window");
			infowindow.close();
		}
	</script>
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDxcedr1zrD8h225vpj3hNseos5mHGEDVY&callback=initMap">
		
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