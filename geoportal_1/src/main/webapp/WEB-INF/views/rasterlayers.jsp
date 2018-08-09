<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>

<title>تنمية أراضي محافظة البحيرة</title>
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

.slider {
    -webkit-appearance: none;
    width: 100%;
    height: 20px;
    background: #fcbb5b;
    outline: none;
    opacity: 0.7;
    -webkit-transition: .2s;
    transition: opacity .2s;
}

.slider:hover {
    opacity: 1;
}

.slider::-webkit-slider-thumb {
    -webkit-appearance: none;
    appearance: none;
    width: 10px;
    height: 25px;
    background: #396266;
    cursor: e-resize;
}

.slider::-moz-range-thumb {
    width: 25px;
    height: 25px;
    background: #396266;
    cursor: pointer;
}

#clip {
  position: absolute;
  /*clip: rect(0, 1200px, 1200px, 0);*/
  /* clip: shape(top, right, bottom, left); NB 'rect' is the only available option */
}

#floating-panel {
        position: relative;
        top: 2px;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 0px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
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
	<div class="slidecontainer" id="floating-panel">
  		<input type="range" min="0" max="100" value="0" class="slider" id="myRange">
  		<!-- <p>Value: <span id="demo"></span></p> -->
	</div>
	<div id="map"></div>
	<!-- Leaflet library -->
	<script src="resources/jquery/jquery-3.1.1.min.js"></script>
	<script src="resources/leaflet/leaflet.js"></script>
	<script>
		/*id = "${polygonID}";
		lat = "${lat}";
		lng = "${lng}";
		*/
				
		var overlay;
		var overlay2;
	    USGSOverlay.prototype = new google.maps.OverlayView();
	      
		function initMap() {
			var map = new google.maps.Map(document.getElementById('map'), {
		          zoom: 11,
		          center: {lat: 22.543055, lng: 35.705139},
		          mapTypeId: 'satellite'
		        });
		        
		        
		       /*
		        var lat = 22.543055;
				var lng = 35.705139;
				var map = L.map('map').setView([ lat, lng ], 11);
				var basemap = L.tileLayer(
						'http://{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}', {
							maxZoom : 16,
							subdomains : [ 'mt0', 'mt1', 'mt2', 'mt3' ]
						}).addTo(map);
		        
		        */

		        var bounds = new google.maps.LatLngBounds(
		            new google.maps.LatLng(22.377222, 35.534444),
		            new google.maps.LatLng(22.708888, 35.875833));
		            
		        var bounds2 = new google.maps.LatLngBounds(
		            new google.maps.LatLng(22.377222, 35.534444),
		            new google.maps.LatLng(22.708888, 35.875833));

		        // The photograph is courtesy of the U.S. Geological Survey.
		        var srcImage2 = 'https://github.com/AKotb/BeheiraPortal/blob/master/geoportal_1/src/main/resources/raster/LC817244_rgb_15m.png';
		        
		        var srcImage = 'https://github.com/AKotb/BeheiraPortal/blob/master/geoportal_1/src/main/resources/raster/LC817244_rgb_30m.png';

		        //https://drive.google.com/file/d/1A5S300q66jkId7mHRiMK8-nVs5kfVqRf/view?usp=sharing
		        // The custom USGSOverlay object contains the USGS image,
		        // the bounds of the image, and a reference to the map.
		        overlay = new USGSOverlay(bounds, srcImage, map, "clip1");
		        overlay2 = new USGSOverlay(bounds2, srcImage2, map, "clip2");
		}
		
		function update_overlay() {
	        var slider_value = document.getElementById("myRange").value;
			new_width = document.getElementById("clip2").width;
			document.getElementById("clip2").style.clip = "rect(0,"+new_width+"px, "+new_width+"px, " + 0.01* new_width * slider_value + "px)";
	      }

	      /** @constructor */
	      function USGSOverlay(bounds, image, map, id) {

	        // Initialize all properties.
	        this.bounds_ = bounds;
	        this.image_ = image;
	        this.map_ = map;
			this.id_ = id;

	        // Define a property to hold the image's div. We'll
	        // actually create this div upon receipt of the onAdd()
	        // method so we'll leave it null for now.
	        this.div_ = null;

	        // Explicitly call setMap on this overlay.
	        this.setMap(map);
	      }

	      /**
	       * onAdd is called when the map's panes are ready and the overlay has been
	       * added to the map.
	       */
	      USGSOverlay.prototype.onAdd = function() {

	        var div = document.createElement('div');
	        div.style.borderStyle = 'none';
	        div.style.borderWidth = '0px';
	        div.style.position = 'absolute';

	        // Create the img element and attach it to the div.
	        var img = document.createElement('img');
	        img.id = this.id_;
	        img.src = this.image_;
	        img.style.width = '100%';
	        img.style.height = '100%';
	        img.style.position = 'absolute';
	        div.appendChild(img);

	        this.div_ = div;

	        // Add the element to the "overlayLayer" pane.
	        var panes = this.getPanes();
	        panes.overlayLayer.appendChild(div);
	      };

	      USGSOverlay.prototype.draw = function() {

	        // We use the south-west and north-east
	        // coordinates of the overlay to peg it to the correct position and size.
	        // To do this, we need to retrieve the projection from the overlay.
	        var overlayProjection = this.getProjection();

	        // Retrieve the south-west and north-east coordinates of this overlay
	        // in LatLngs and convert them to pixel coordinates.
	        // We'll use these coordinates to resize the div.
	        var sw = overlayProjection.fromLatLngToDivPixel(this.bounds_.getSouthWest());
	        var ne = overlayProjection.fromLatLngToDivPixel(this.bounds_.getNorthEast());

	        // Resize the image's div to fit the indicated dimensions.
	        var div = this.div_;
	        div.style.left = sw.x + 'px';
	        div.style.top = ne.y + 'px';
	        div.style.width = (ne.x - sw.x) + 'px';
	        div.style.height = (sw.y - ne.y) + 'px';
	      };

	      // The onRemove() method will be called automatically from the API if
	      // we ever set the overlay's map property to 'null'.
	      USGSOverlay.prototype.onRemove = function() {
	        this.div_.parentNode.removeChild(this.div_);
	        this.div_ = null;
	      };

	      google.maps.event.addDomListener(window, 'load', initMap);
	      google.maps.event.addDomListener(window, 'zoom_changed', update_overlay);

				
	</script>
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDxcedr1zrD8h225vpj3hNseos5mHGEDVY&callback=initMap&v=3.exp&sensor=false"></script>
		
	
	<script>
		var slider = document.getElementById("myRange");
		var output = document.getElementById("demo");
		output.innerHTML = slider.value;
		
		slider.oninput = function() {
		  output.innerHTML = this.value;
		  new_width = document.getElementById("clip2").width;
		  document.getElementById("clip2").style.clip = "rect(0,"+new_width+"px, "+new_width+"px, " + 0.01* new_width * this.value + "px)";
		  
		}
	</script>

	<!-- SCRIPTS -->
	<!-- <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script> -->
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