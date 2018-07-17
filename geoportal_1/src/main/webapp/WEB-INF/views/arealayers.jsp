<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>EL-BEHIRA GOVERNORATE</title>
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
<style>
#extra {
	height: 550px;
	width: 100%;
}

#infowindow {
	background-color: #f6f6f6;
	right: 0px;
	position: absolute;
	top: 144px;
	height: 550px;
	width: 20%;
}

.outertable {
	border-collapse: collapse;
	width: 500px;
	text-align: right;
	padding: 8px;
	border: 1px solid black;
}

.th {
	border-collapse: collapse;
	width: 500px;
	text-align: right;
	padding: 8px;
	border: 1px solid black;
}

.td {
	border-collapse: collapse;
	width: 500px;
	text-align: right;
	padding: 8px;
	border: 1px solid black;
}

.innertable {
	border-collapse: collapse;
	width: 100%;
	text-align: right;
	padding: 8px;
	border: 1px solid black;
}

.rightcolumn {
	background-color: #396266;
	color: white;
	width: 30%;
	border-collapse: collapse;
	text-align: right;
	padding: 8px;
	border: 1px solid black;
	border-collapse: collapse;
}

.infowindowimg {
	display: block;
	margin-left: auto;
	margin-right: auto;
}
</style>
</head>

<body>
	<div class="container">
		<ul class="nav">
			<a href="#"><img
				src="resources/css/css/css/css/images/SEARCH.png" alt="SEARCH"></a>
			<a href="#"><img
				src="resources/css/css/css/css/images/WHO ARE WE.png"
				alt="WHO ARE WE"></a>
			<a href="#"><img
				src="resources/css/css/css/css/images/REGULATIONS AND LAWS.png"
				alt="REGULATIONS AND LAWS"></a>
			<a href="http://localhost:8080/beheiraportal/"><img
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
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Building_project.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/Building_project.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Reclaimed_Notplanted_projected.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/Reclaimed_Notplanted_projected.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/crops_projected.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/crops_projected.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/roads_Project.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/roads_Project.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Building_projected.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/Building_projected.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Crops_projected.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/Crops_projected.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Reclaimed_projected.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/Reclaimed_projected.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Roads_projected.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/Roads_projected.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Field_Crops_projected.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/Field_Crops_projected.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Land_notused_projected.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/Land_notused_projected.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Roads_projcted.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/Roads_projcted.json');
			}
			if (200 == urlExists('https://github.com/AKotb/BeheiraPortal/blame/master/geoportal_1/src/main/resources/json/'
					+ id + '/FieldCrops_projected.json')) {
				map.data
						.loadGeoJson('https://github.com/AKotb/BeheiraPortal/blame/master/geoportal_1/src/main/resources/json/'
								+ id + '/FieldCrops_projected.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Building_Projected.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/Building_Projected.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/FieldCrops_Projected.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/FieldCrops_Projected.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Crops_Projected.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/Crops_Projected.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Reclaimed_Projected.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/Reclaimed_Projected.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Reclaimed_Project.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/Reclaimed_Project.json');
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Roads_Projected.json')) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
								+ id + '/Roads_Projected.json');
			}

			map.setZoom(15);
			map.setCenter(new google.maps.LatLng(lat, lng));
			infowindow = new google.maps.InfoWindow();
			map.data.setStyle(function(feature) {
				var color = 'blue';
				return ({
					fillColor : color,
					strokeColor : color,
					strokeWeight : 2
				});
			});
			map.data.addListener('click', function(event) {
			});

			map.data
					.addListener(
							'mouseover',
							function(event) {
								map.data.revertStyle();
								map.data.overrideStyle(event.feature, {
									strokeWeight : 4,
									fillColor : 'yellow'
								});

								var arname = event.feature
										.getProperty('Ar_Name');
								if (arname) {
									arname = arname;
								} else {
									arname = "غير متوفر";
								}
								var enname = event.feature
										.getProperty('EN_Name');
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
								}

								var content = "<div style=\"text-align:center; overflow:hidden;\"><h1 style=\"background-color: #396266;\">"
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
										+ "</div>";

								infowindow.setContent(content);
								infowindow.setPosition(event.feature
										.getGeometry().getAt(0).getAt(0));
								infowindow.setOptions({
									pixelOffset : new google.maps.Size(0, -30)
								});
								infowindow.open(map);
							});
			map.data.addListener('mouseout', function(event) {
				map.data.revertStyle();
				infowindow.close();
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