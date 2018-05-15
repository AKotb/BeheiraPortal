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
			<%-- <a href="<c:url value='otherholdings'/>"><img
				src="resources/css/css/css/css/images/OTHER HOLDINGS.png"
				alt="OTHER HOLDINGS"></a>
			<a href="<c:url value='byforce'/>"><img
				src="resources/css/css/css/css/images/BY FORCE.png" alt="BY FORCE"></a>
			<a href="<c:url value='rent'/>"><img
				src="resources/css/css/css/css/images/RENT.png" alt="RENT"></a>
			<a href="<c:url value='ownership'/>"><img
				src="resources/css/css/css/css/images/OWNERSHIP.png" alt="OWNERSHIP"></a> --%>
			<a href="http://localhost:8080/beheiraportal/"><img
				src="resources/css/css/css/css/images/HOME.png" alt="HOME"></a>
		</ul>
		<img src="resources/css/css/css/css/images/projectname.png"
			alt="project name" class="projectname">
	</div>
	<div id="extra"></div>
		<script>
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
				/* var ctaLayer = new google.maps.KmlLayer({
			          url: 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/db.kml',
			          map: map
			     }); */
				/* var ctaLayer2 = new google.maps.KmlLayer({
			          url: 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/2km_buffer.kml',
			          map: map
			     }); */
				var ctaLayer3 = new google.maps.KmlLayer({
			          url: 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/165.kml',
			          map: map
			     });
				
				infowindow = new google.maps.InfoWindow();
				//map.data.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/165.geojson');
				//map.data.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/2km_buffer.geojson');
				//map.data.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/db.geojson');
				//map.data.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/narss-DB.geojson');
				
				map.data.setStyle(function(feature) {
			          var color = 'blue';
			          if (feature.getProperty('isColorful')) {
			            color = 'red';
			          }
			          return /** @type {google.maps.Data.StyleOptions} */({
			            fillColor: color,
			            strokeColor: color,
			            strokeWeight: 2
			          });
			        });
				
				// When the user clicks, set 'isColorful', changing the color of the letters.
				map.data.addListener('click', function(event) {
					/* var govcode = event.feature.getProperty('GOVS_CODE');
					// Beheira Governorate clicked
					if(govcode =='18'){
						window.location.href = "<c:url value='view_beheira'/>";
					}
					// Fayoum Governorate clicked
					if(govcode =='23'){
						window.location.href = "<c:url value='view_fayoum'/>";
					}
					
					// Elwadi Elgedeed Governorate clicked
					if(govcode =='32'){
						window.location.href = "<c:url value='view_wadigedeed'/>";
					}
					
					// Qalyoubia Governorate clicked
					if(govcode =='14'){
						window.location.href = "<c:url value='view_qalyoubia'/>";
					} */
					
				});
				
				map.data.addListener('mouseover', function(event) {
			        map.data.revertStyle();
			        map.data.overrideStyle(event.feature, {strokeWeight: 4, fillColor: 'yellow'});
			        
			        
					var name = event.feature.getProperty('Name');
					//var desc = event.feature.getProperty('description');
			        var content = "<div><table><tr><td>اسم المزرعة</td></tr><tr><td>"+name+"</td></tr></table></div>";
			        
			        infowindow.setContent(content);
			        infowindow.setPosition(event.feature.getGeometry().getAt(0).getAt(0));
			        infowindow.setOptions({pixelOffset: new google.maps.Size(0,-30)});
			        infowindow.open(map);
			    });

			    map.data.addListener('mouseout', function(event) {
			       map.data.revertStyle();
			       infowindow.close();
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