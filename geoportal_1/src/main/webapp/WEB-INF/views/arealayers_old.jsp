<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>

<title>استخدامات الأراضي</title>
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

<!-- CSS for Leaflet library -->
<link rel="stylesheet" href="resources/leaflet/leaflet.css" />

<!-- inline styles -->
<style>
#map {
	height: 618px;
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
	<div id="map"></div>
	<!-- Leaflet library -->
	<script src="resources/jquery/jquery-3.1.1.min.js"></script>
	<script src="resources/leaflet/leaflet.js"></script>
	<script>
		id = "${polygonID}";
		lat = "${lat}";
		lng = "${lng}";

		var buildingprojectedstyle = {
			"color" : "#A52A2A", //brown
			"weight" : 5,
			"opacity" : 0.65
		};
		var reclaimednotplantedprojectedstyle = {
			"color" : "#000000", //black
			"weight" : 5,
			"opacity" : 0.65
		};
		var cropsprojectedstyle = {
			"color" : "#008000", //green
			"weight" : 5,
			"opacity" : 0.65
		};
		var roadsprojectedstyle = {
			"color" : "#FF0000", //red
			"weight" : 5,
			"opacity" : 0.65
		};
		var reclaimedprojectedstyle = {
			"color" : "#FFFF00", //yellow
			"weight" : 5,
			"opacity" : 0.65
		};
		var fieldcropsprojectedstyle = {
			"color" : "#0000ff", //blue
			"weight" : 5,
			"opacity" : 0.65
		};
		var landnotusedprojectedstyle = {
			"color" : "#A9A9A9", //grey
			"weight" : 5,
			"opacity" : 0.65
		};
		
		
		/*
		*different styles for different types in map
		* ready for new datasets
		
		
		//1- مبانى قائمة
		var style01_ = {
				"color" : "rgb(255,0,0)", //red
				"weight" : 5,
				"opacity" : 0.65
		};
		// 2- أراضى منزرعة - محاصيل بستانية
		var style02_ = {
				"color" : "rgb(85,255,0)", //light green
				"weight" : 5,
				"opacity" : 0.65
		};
		// 3- أراضى منزرعة - محاصيل حقلية
		var style03_ = {
				"color" : "rgb(38,115,0)", //dark green
				"weight" : 5,
				"opacity" : 0.65
		};
		// 4- أراضى مستصلحة
		var style04_ = {
				"color" : "rgb(230,152,0)", //orange
				"weight" : 5,
				"opacity" : 0.65
		};
		// 5- أراضى غير مستغلة
		var style05_ = {
				"color" : "rgb(190,190,190)", //light gray
				"weight" : 5,
				"opacity" : 0.65
		};
		*/
		
		var kyObject;
		var map = L.map('map').setView([ lat, lng ], 15);
		var basemap = L.tileLayer(
				'http://{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}', {
					maxZoom : 20,
					subdomains : [ 'mt0', 'mt1', 'mt2', 'mt3' ]
				}).addTo(map);
		function initMap() {
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Building_project.json')) {
				var Building_project = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/Building_project.json',
							dataType : "json",
							success : console
									.log("Building_project data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(Building_project).done(
						function() {
							var kyBuilding_project = L.geoJSON(
									Building_project.responseJSON, {
										style : buildingprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyBuilding_project;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Reclaimed_Notplanted_projected.json')) {
				var Reclaimed_Notplanted_projected = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id
									+ '/Reclaimed_Notplanted_projected.json',
							dataType : "json",
							success : console
									.log("Reclaimed_Notplanted_projected data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$
						.when(Reclaimed_Notplanted_projected)
						.done(
								function() {
									var kyReclaimed_Notplanted_projected = L
											.geoJSON(
													Reclaimed_Notplanted_projected.responseJSON,
													{
														style : reclaimednotplantedprojectedstyle,
														onEachFeature : onEachFeature
													}).addTo(map);
									kyObject = kyReclaimed_Notplanted_projected;
								});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/crops_projected.json')) {
				var crops_projected = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/crops_projected.json',
							dataType : "json",
							success : console
									.log("crops_projected data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(crops_projected).done(
						function() {
							var kycrops_projected = L.geoJSON(
									crops_projected.responseJSON, {
										style : cropsprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kycrops_projected;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/roads_Project.json')) {
				var roads_Project = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/roads_Project.json',
							dataType : "json",
							success : console
									.log("roads_Project data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(roads_Project).done(
						function() {
							var kyroads_Project = L.geoJSON(
									roads_Project.responseJSON, {
										style : roadsprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyroads_Project;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Building_projected.json')) {
				var Building_projected = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/Building_projected.json',
							dataType : "json",
							success : console
									.log("Building_projected data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(Building_projected).done(
						function() {
							var kyBuilding_projected = L.geoJSON(
									Building_projected.responseJSON, {
										style : buildingprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyBuilding_projected;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Crops_projected.json')) {
				var Crops_projected = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/Crops_projected.json',
							dataType : "json",
							success : console
									.log("Crops_projected data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(Crops_projected).done(
						function() {
							var kyCrops_projected = L.geoJSON(
									Crops_projected.responseJSON, {
										style : cropsprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyCrops_projected;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Reclaimed_projected.json')) {
				var Reclaimed_projected = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/Reclaimed_projected.json',
							dataType : "json",
							success : console
									.log("Reclaimed_projected data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(Reclaimed_projected).done(
						function() {
							var kyReclaimed_projected = L.geoJSON(
									Reclaimed_projected.responseJSON, {
										style : reclaimedprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyReclaimed_projected;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Roads_projected.json')) {
				var Roads_projected = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/Roads_projected.json',
							dataType : "json",
							success : console
									.log("Roads_projected data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(Roads_projected).done(
						function() {
							var kyRoads_projected = L.geoJSON(
									Roads_projected.responseJSON, {
										style : roadsprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyRoads_projected;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Field_Crops_projected.json')) {
				var Field_Crops_projected = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/Field_Crops_projected.json',
							dataType : "json",
							success : console
									.log("Field_Crops_projected data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(Field_Crops_projected).done(
						function() {
							var kyField_Crops_projected = L.geoJSON(
									Field_Crops_projected.responseJSON, {
										style : fieldcropsprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyField_Crops_projected;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Land_notused_projected.json')) {
				var Land_notused_projected = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/Land_notused_projected.json',
							dataType : "json",
							success : console
									.log("Land_notused_projected data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(Land_notused_projected).done(
						function() {
							var kyLand_notused_projected = L.geoJSON(
									Land_notused_projected.responseJSON, {
										style : landnotusedprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyLand_notused_projected;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Roads_projcted.json')) {
				var Roads_projcted = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/Roads_projcted.json',
							dataType : "json",
							success : console
									.log("Roads_projcted data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(Roads_projcted).done(
						function() {
							var kyRoads_projcted = L.geoJSON(
									Roads_projcted.responseJSON, {
										style : roadsprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyRoads_projcted;
						});
			}
			if (200 == urlExists('https://github.com/AKotb/BeheiraPortal/blame/master/geoportal_1/src/main/resources/json/'
					+ id + '/FieldCrops_projected.json')) {
				var FieldCrops_projected = $
						.ajax({
							url : 'https://github.com/AKotb/BeheiraPortal/blame/master/geoportal_1/src/main/resources/json/'
									+ id + '/FieldCrops_projected.json',
							dataType : "json",
							success : console
									.log("FieldCrops_projected data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(FieldCrops_projected).done(
						function() {
							var kyFieldCrops_projected = L.geoJSON(
									FieldCrops_projected.responseJSON, {
										style : fieldcropsprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyFieldCrops_projected;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Building_Projected.json')) {
				var Building_Projected = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/Building_Projected.json',
							dataType : "json",
							success : console
									.log("Building_Projected data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(Building_Projected).done(
						function() {
							var kyBuilding_Projected = L.geoJSON(
									Building_Projected.responseJSON, {
										style : buildingprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyBuilding_Projected;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/FieldCrops_Projected.json')) {
				var FieldCrops_Projected = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/FieldCrops_Projected.json',
							dataType : "json",
							success : console
									.log("FieldCrops_Projected data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(FieldCrops_Projected).done(
						function() {
							var kyFieldCrops_Projected = L.geoJSON(
									FieldCrops_Projected.responseJSON, {
										style : fieldcropsprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyFieldCrops_Projected;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Crops_Projected.json')) {
				var Crops_Projected = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/Crops_Projected.json',
							dataType : "json",
							success : console
									.log("Crops_Projected data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(Crops_Projected).done(
						function() {
							var kyCrops_Projected = L.geoJSON(
									Crops_Projected.responseJSON, {
										style : cropsprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyCrops_Projected;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Reclaimed_Projected.json')) {
				var Reclaimed_Projected = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/Reclaimed_Projected.json',
							dataType : "json",
							success : console
									.log("Reclaimed_Projected data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(Reclaimed_Projected).done(
						function() {
							var kyReclaimed_Projected = L.geoJSON(
									Reclaimed_Projected.responseJSON, {
										style : reclaimedprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyReclaimed_Projected;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Reclaimed_Project.json')) {
				var Reclaimed_Project = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/Reclaimed_Project.json',
							dataType : "json",
							success : console
									.log("Reclaimed_Project data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(Reclaimed_Project).done(
						function() {
							var kyReclaimed_Project = L.geoJSON(
									Reclaimed_Project.responseJSON, {
										style : reclaimedprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyReclaimed_Project;
						});
			}
			if (200 == urlExists('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
					+ id + '/Roads_Projected.json')) {
				var Roads_Projected = $
						.ajax({
							url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/'
									+ id + '/Roads_Projected.json',
							dataType : "json",
							success : console
									.log("Roads_Projected data successfully loaded."),
							error : function(xhr) {
								alert(xhr.statusText)
							}
						})
				$.when(Roads_Projected).done(
						function() {
							var kyRoads_Projected = L.geoJSON(
									Roads_Projected.responseJSON, {
										style : roadsprojectedstyle,
										onEachFeature : onEachFeature
									}).addTo(map);
							kyObject = kyRoads_Projected;
						});
			}
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

		function highlightFeature(e) {
			var layer = e.target;
			layer.setStyle({
				weight : 5,
				color : '#666',
				dashArray : '',
				fillOpacity : 0.7
			});
			if (!L.Browser.ie && !L.Browser.opera && !L.Browser.edge) {
				layer.bringToFront();
			}
			var arname = layer.feature.properties.Ar_Name;
			if (arname) {
				arname = arname;
			} else {
				arname = "غير متوفر";
			}
			var enname = layer.feature.properties.EN_Name;
			if (enname) {
				enname = enname;
			} else {
				enname = "غير متوفر";
			}
			var area = layer.feature.properties.Area;
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
			var currlat = e.latlng.lat;
			var currlng = e.latlng.lng;
			var latlng = L.latLng(currlat, currlng);
			var popup = L.popup({
				maxWidth : 550,
				maxHeight : 300
			}).setLatLng(latlng).setContent(content).openOn(map);
		}

		function resetHighlight(e) {
			kyObject.resetStyle(e.target);
		}

		function onEachFeature(feature, layer) {
			layer.on({
				click : highlightFeature,
				mouseout : resetHighlight
			});
		}
	</script>
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDxcedr1zrD8h225vpj3hNseos5mHGEDVY&callback=initMap"></script>

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
<script id="ftnt_topbar_script"
	src="//bl.ocks.org:8011/bard869310725fadc44f49c3f15554c5279.js"
	type="text/javascript" class="52"></script>