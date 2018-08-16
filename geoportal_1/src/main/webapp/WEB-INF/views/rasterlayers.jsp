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
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<!-- CSS -->
<link rel="stylesheet" href="resources/css/css/css/css/tooplate-style.css">


<!-- inline styles -->
<style>
#map {
	height: 618px;
	width: 100%;
}

.slidecontainer {
    width: 20%;
}

.slider {
    -webkit-appearance: none;
    width: 100%;
    height: 25px;
    background: #d3d3d3;
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
    background: #4CAF50;
    cursor: e-resize;
}

.slider::-moz-range-thumb {
    width: 25px;
    height: 25px;
    background: #4CAF50;
    cursor: pointer;
}

#clip {
  position: absolute;
}

#floating-panel {
        position: absolute;
        top: 137px;
        left: 8%;
        z-index: 7;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 0px;
        padding-left: 10px;
      }
</style>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDxcedr1zrD8h225vpj3hNseos5mHGEDVY&callback=initMap"></script>
<script>
		var overlay;
	    USGSOverlay.prototype = new google.maps.OverlayView();
	      
		function initMap() {
			var map = new google.maps.Map(document.getElementById('map'), {
		          zoom: 11,
		          center: {lat: 22.543055, lng: 35.705139},
		          mapTypeId: 'satellite'
		        });
			var bounds = new google.maps.LatLngBounds(
					new google.maps.LatLng(22.377222, 35.534444),
		            new google.maps.LatLng(22.708888, 35.875833));
		            
		    var bounds2 = new google.maps.LatLngBounds(
		            new google.maps.LatLng(22.377222, 35.534444),
		            new google.maps.LatLng(22.708888, 35.875833));

		    var srcImage2 = 'resources/rasterimages/photo2.png';
		    var srcImage = 'resources/rasterimages/photo1.png';
		    overlay = new USGSOverlay(bounds, srcImage, map, "clip1");
		    overlay2 = new USGSOverlay(bounds2, srcImage2, map, "clip2");
		}
		
		function update_overlay() {
	        var slider_value = document.getElementById("myRange").value;
			new_width = document.getElementById("clip2").width;
			document.getElementById("clip2").style.clip = "rect(0,"+new_width+"px, "+new_width+"px, " + 0.01* new_width * slider_value + "px)";
	    }
	    
		function USGSOverlay(bounds, image, map, id) {
			this.bounds_ = bounds;
	        this.image_ = image;
	        this.map_ = map;
			this.id_ = id;
	        this.div_ = null;
	        this.setMap(map);
	    }
	    
		USGSOverlay.prototype.onAdd = function() {
	        var div = document.createElement('div');
	        div.style.borderStyle = 'none';
	        div.style.borderWidth = '0px';
	        div.style.position = 'absolute';

	        var img = document.createElement('img');
	        img.id = this.id_;
	        img.src = this.image_;
	        img.style.width = '100%';
	        img.style.height = '100%';
	        img.style.position = 'absolute';
	        div.appendChild(img);
	        this.div_ = div;
	        var panes = this.getPanes();
	        panes.overlayLayer.appendChild(div);
	    };

	    USGSOverlay.prototype.draw = function() {
	        var overlayProjection = this.getProjection();
	        var sw = overlayProjection.fromLatLngToDivPixel(this.bounds_.getSouthWest());
	        var ne = overlayProjection.fromLatLngToDivPixel(this.bounds_.getNorthEast());
	        var div = this.div_;
	        div.style.left = sw.x + 'px';
	        div.style.top = ne.y + 'px';
	        div.style.width = (ne.x - sw.x) + 'px';
	        div.style.height = (sw.y - ne.y) + 'px';
	    };
	    
	    USGSOverlay.prototype.onRemove = function() {
	        this.div_.parentNode.removeChild(this.div_);
	        this.div_ = null;
	    };
	    
	    google.maps.event.addDomListener(window, 'load', initMap);
	    google.maps.event.addDomListener(window, 'zoom_changed', update_overlay);
	</script>
</head>
<body>
	<div class="container">
		<ul class="nav">
			<a href="searchforfarms"><img src="resources/css/css/css/css/images/SEARCH.png" alt="SEARCH"></a>
			<a href="who_we_are"><img src="resources/css/css/css/css/images/WHO ARE WE.png" alt="WHO ARE WE"></a>
			<a href="regulations_and_laws"><img src="resources/css/css/css/css/images/REGULATIONS AND LAWS.png" alt="REGULATIONS AND LAWS"></a>
			<a href="index"><img src="resources/css/css/css/css/images/HOME.png" alt="HOME"></a>
		</ul>
		<img src="resources/css/css/css/css/images/projectname.png" alt="project name" class="projectname">
	</div>
	<div class="slidecontainer" id="floating-panel">
  		<input type="range" min="0" max="100" value="0" class="slider" id="myRange">
	</div>
	<div id="map"></div>
	<script>
		var slider = document.getElementById("myRange");
		slider.oninput = function() {
		  new_width = document.getElementById("clip2").width;
		  document.getElementById("clip2").style.clip = "rect(0,"+new_width+"px, "+new_width+"px, " + 0.01* new_width * this.value + "px)";
		  
		}
	</script>
	<!-- Footer -->
	<div class="copyright">
		<p class="copyrighttext">
			Copyright © 2018, <a href="http://www.narss.sci.eg">NARSS</a>
		</p>
	</div>
</body>
</html>