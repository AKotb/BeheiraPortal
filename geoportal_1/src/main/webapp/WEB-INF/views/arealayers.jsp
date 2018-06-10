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

table, th, td {
	border: 1px solid black;
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
		
			if (id == 0) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/0/Building_project.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/0/Reclaimed_Notplanted_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/0/crops_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/0/roads_Project.json');
			}
			if (id == 1) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/1/Building_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/1/Crops_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/1/Reclaimed_Notplanted_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/1/Reclaimed_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/1/Roads_projected.json');
			}
			if (id == 2) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/2/Building_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/2/Crops_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/2/Field_Crops_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/2/Land_notused_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/2/Reclaimed_Notplanted_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/2/Reclaimed_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/2/Roads_projcted.json');
			}
			if (id == 3) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/3/Building_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/3/Crops_projected.json');
				map.data
						.loadGeoJson('https://github.com/AKotb/BeheiraPortal/blame/master/geoportal_1/src/main/resources/json/3/FieldCrops_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/3/Roads_projected.json');
			}
			if (id == 4) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/4/Building_Projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/4/FieldCrops_Projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/4/Reclaimed_Notplanted_projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/4/Roads_projected.json');
			}
			if (id == 5) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/5/Building_Projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/5/Crops_Projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/5/FieldCrops_Projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/5/Reclaimed_Notplanted_Projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/5/Reclaimed_Projected.json');
			}
			if (id == 6) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/6/Building_Projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/6/Crops_Projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/6/Reclaimed_Notplanted_Projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/6/Reclaimed_Project.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/6/Roads_Projected.json');
			}
			if (id == 7) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/7/Building_Projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/7/Crops_Projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/7/FieldCrops_Projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/7/Reclaimed_Notplanted_Projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/7/Roads_Projected.json');
			}
			if (id == 8) {
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/8/Building_Projected.json');
				map.data
						.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/8/FieldCrops_Projected.json');
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
			// When the user clicks, set 'isColorful', changing the color of the letters.
			map.data.addListener('click', function(event) {
			});

			map.data.addListener('mouseover', function(event) {

			});
			map.data.addListener('mouseout', function(event) {

			});
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