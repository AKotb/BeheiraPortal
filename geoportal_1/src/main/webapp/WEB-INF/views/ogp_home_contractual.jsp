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
	border-collapse: collapse;
	width: 500px;
	text-align: right;
	padding: 8px;
	border: 1px solid black;
}

.innertable{
	border-collapse: collapse;
	width: 100%;
	text-align: right;
	padding: 8px;
	border: 1px solid black;
}

.rightcolumn {
	background-color: #396266;
	color: white;
	width: 30%
}

.infowindowimg {
	display: block;
	margin-left: auto;
	margin-right: auto;
}

.divider{
    width:5px;
    height:auto;
    display:inline-block;
}

/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

.button {
	font: bold 11px Arial;
	text-decoration: none;
	background-color: #396266;
	color: white;
	padding: 2px 6px 2px 6px;
	border-top: 1px solid #CCCCCC;
	border-right: 1px solid #333333;
	border-bottom: 1px solid #333333;
	border-left: 1px solid #CCCCCC;
}

.button:hover,
.button:focus {
	background-color: #3d6266;
    color: #fcbb5b;
    text-decoration: none;
    cursor: pointer;
}

input.input-box, textarea {
    background-color: #fdddad; /* Green */
    color: #3d6266;
    padding: 2px;
    text-align: right;
    text-decoration: none;
}

.btnsearch {border-radius: 12%;}

/* Modal Content */
.modal-content {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 30%;
}

/* The Close Button */
.close {
    color: #aaaaaa;
    float: left;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}


</style>
</head>

<body>
	<div class="container">
		<ul class="nav">
			<a href="#" id="mysearch" onclick="searchBox('Hello')"><img
				src="resources/css/css/css/css/images/SEARCH.png" alt="SEARCH"></a>
				<!-- The Modal -->
				<div id="myModal" class="modal">
				
				  <!-- Modal content -->
				  <div class="modal-content">
				    <span class="close">&times;</span>
				    
				    <h1 style="color:#3d6266;" align="center">بحث عن قطعة أرض</h1>
				    
				    <div align="center">	
					    
					    <table border="0" style="dir:rtl;">
					    	<tr>
					    		<td align="right"><input class="input-box" type="text" name="farm_name" value=""></td>
					    		<td align="right" style="color:#3d6266;">اسم المزرعة / الشركة</td>
					    	</tr>
					    	<tr>
					    		<td align="right"><input class="input-box" type="text" name="ownership" value=""></td>
					    		<td align="right" style="color:#3d6266;">نوع الحيازة</td>
					    	</tr>
					    	<tr>
					    		<td align="right"><input class="input-box" type="text" name="owner" value=""></td>
					    		<td align="right" style="color:#3d6266;">اسم المالك / واضع اليد</td>
					    	</tr>
					    	<tr>
					    		<td align="right"><input class="input-box" type="text" name="sid" value=""></td>
					    		<td align="right" style="color:#3d6266;">الرقم القومى</td>
					    	</tr>
					    	<tr>
					    		<td align="right"><input class="input-box" type="text" name="phone" value=""></td>
					    		<td align="right" style="color:#3d6266;">التليفون</td>
					    	</tr>
					    </table>
					        
				    </div>
				    
				    <h2 align="center">  <button onclick="searchAction()" class="button btnsearch" id="searchBtn">بحث</button></h2>
				    
				  </div>
				
				</div>
				
				<script type="application/javascript">
				function searchBox(item) {
					// Get the modal
					var modal = document.getElementById('myModal');
	
					// Get the button that opens the modal
					var btn = document.getElementById("mysearch");
	
					// Get the <span> element that closes the modal
					var span = document.getElementsByClassName("close")[0];
	
					// When the user clicks the button, open the modal 
					btn.onclick = function() {
					    modal.style.display = "block";
					}
	
					// When the user clicks on <span> (x), close the modal
					span.onclick = function() {
					    modal.style.display = "none";
					}
	
					// When the user clicks anywhere outside of the modal, close it
					window.onclick = function(event) {
					    if (event.target == modal) {
					        modal.style.display = "none";
					    }
					}
				}
				
				function searchAction() {
				    alert(document.getElementById("sid").value);
				}
				
	        	</script>
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
			map.data
					.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/db.json');
			map.data
					.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/165.json');
			//map.data.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/2km_buffer.json');
			var kmbuffer2Layer = new google.maps.KmlLayer(
					{
						url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/2km_buffer.kml',
						map : map
					});
			infowindow = new google.maps.InfoWindow();
			map.data.setStyle(function(feature) {
				var folderpath = feature.getProperty('FolderPath');
				if (folderpath == 'areea2/areea2'
						|| folderpath == 'areea1/areea1') {
					return ({
						fillColor : 'transparent',
						strokeColor : 'blue',
						strokeWeight : 2
					});
				} else {
					var color = 'blue';
					return ({
						fillColor : color,
						strokeColor : color,
						strokeWeight : 2
					});
				}
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

			map.data
					.addListener(
							'mouseover',
							function(event) {
								var folderpath = event.feature
										.getProperty('FolderPath');
								if (folderpath == 'areea2/areea2'
										|| folderpath == 'areea1/areea1') {
								} else {
									map.data.revertStyle();
									map.data.overrideStyle(event.feature, {
										strokeWeight : 4,
										fillColor : 'yellow'
									});
								}

								var owner = event.feature.getProperty('OWNER');
								var farm_name = event.feature
										.getProperty('Farm_Name');
								var sid = event.feature.getProperty('Owner_ID');
								var phone = event.feature
										.getProperty('Mang_Tel');
								var ownership = event.feature
										.getProperty('Ownership');
								var area_id = event.feature.getProperty('id');
								var area_feddan = event.feature
										.getProperty('area_fadda');
								var area = area_feddan.toString();
								var fedarr = area.split(".");
								var feddan = fedarr[0];
								var frac_fed = area - fedarr[0];
								var qiratstr = (frac_fed * 24).toString();
								var qiratarr = qiratstr.split(".");
								var qirat = qiratarr[0];
								var frac_qirat = qiratstr - qirat;
								var sahmstr = (frac_qirat * 24).toString();
								var sahmarr = sahmstr.split(".");
								var sahm = sahmarr[0];

								var link2 = "<a href=\'#\' class=\'button\'>"
										+ " مرئيات فضائية " + "</a>";
								var link3 = "<a href=\'#\' class=\'button\'>"
									+ " طلب إجراءات التقنين_المعاينة/الفحص "
										+ "</a>";
								if (area_id == 0) {
									var link4 = "<a href=\'#\'><img class=\'infowindowimg\' src=\'resources/datafiles/0.jpg\' alt=\'Icon\' style=\"width:300px;height:170px;\"></a>";
									var link1 = "<a href=\'javascript:void(0);\' onclick=\'move(0);\' class=\'button\'>"
											+ " خرائط استخدامات الأراضى "
											+ "</a>";
								}
								if (area_id == 1) {
									var link4 = "<a href=\'#\'><img class=\'infowindowimg\' src=\'resources/datafiles/1.jpg\' alt=\'Icon\' style=\"width:300px;height:170px;\"></a>";
									var link1 = "<a href=\'javascript:void(0);\' onclick=\'move(1);\' class=\'button\'>"
											+ " خرائط استخدامات الأراضى "
											+ "</a>";
								}
								if (area_id == 2) {
									var link4 = "<a href=\'#\'><img class=\'infowindowimg\' src=\'resources/datafiles/2.jpg\' alt=\'Icon\' style=\"width:300px;height:170px;\"></a>";
									var link1 = "<a href=\'javascript:void(0);\' onclick=\'move(2);\' class=\'button\'>"
											+ " خرائط استخدامات الأراضى "
											+ "</a>";
								}
								if (area_id == 3) {
									var link4 = "<a href=\'#\'><img class=\'infowindowimg\' src=\'resources/datafiles/3.jpg\' alt=\'Icon\' style=\"width:300px;height:170px;\"></a>";
									var link1 = "<a href=\'javascript:void(0);\' onclick=\'move(3);\' class=\'button\'>"
											+ " خرائط استخدامات الأراضى "
											+ "</a>";
								}
								if (area_id == 4) {
									var link4 = "<a href=\'#\'><img class=\'infowindowimg\' src=\'resources/datafiles/4.jpg\' alt=\'Icon\' style=\"width:300px;height:170px;\"></a>";
									var link1 = "<a href=\'javascript:void(0);\' onclick=\'move(4);\' class=\'button\'>"
											+ " خرائط استخدامات الأراضى "
											+ "</a>";
								}
								if (area_id == 5) {
									var link4 = "<a href=\'#\'><img class=\'infowindowimg\' src=\'resources/datafiles/5.jpg\' alt=\'Icon\' style=\"width:300px;height:170px;\"></a>";
									var link1 = "<a href=\'javascript:void(0);\' onclick=\'move(5);\' class=\'button\'>"
											+ " خرائط استخدامات الأراضى "
											+ "</a>";
								}
								if (area_id == 6) {
									var link4 = "<a href=\'#\'><img class=\'infowindowimg\' src=\'resources/datafiles/6.jpg\' alt=\'Icon\' style=\"width:300px;height:170px;\"></a>";
									var link1 = "<a href=\'javascript:void(0);\' onclick=\'move(6);\' class=\'button\'>"
											+ " خرائط استخدامات الأراضى "
											+ "</a>";
								}
								if (area_id == 7) {
									var link4 = "<a href=\'#\'><img class=\'infowindowimg\' src=\'resources/datafiles/7.jpg\' alt=\'Icon\' style=\"width:300px;height:170px;\"></a>";
									var link1 = "<a href=\'javascript:void(0);\' onclick=\'move(7);\' class=\'button\'>"
											+ " خرائط استخدامات الأراضى "
											+ "</a>";
								}
								if (area_id == 8) {
									var link4 = "<a href=\'#\'><img class=\'infowindowimg\' src=\'resources/datafiles/8.jpg\' alt=\'Icon\' style=\"width:300px;height:170px;\"></a>";
									var link1 = "<a href=\'javascript:void(0);\' onclick=\'move(8);\' class=\'button\'>"
											+ " خرائط استخدامات الأراضى "
											+ "</a>";
								}
								
								var content = "<div style=\"text-align:center; overflow:hidden;\"><h1 style=\"background-color: #396266;\">"
										+ "بيانات قطعة الأرض" + "</h1><br>"
										+ link4
										+ "<br>"
										+ "<table style=\"dir: rtl;\"><tr><td>"
										+ farm_name
										+ "</td><td class=\'rightcolumn\'>اسم المزرعة / الشركة</td></tr><tr><td><table class=\"innertable\"><tr><td>س</td><td>ط</td><td>ف</td></tr><tr><td>"+sahm+"</td><td>"+qirat+"</td><td>"+feddan+"</td></tr></table>"
										+ "</td><td class=\'rightcolumn\'>المساحة</td></tr><tr><td>"
										+ ownership
										+ "</td><td class=\'rightcolumn\'>نوع الحيازة</td></tr><tr><td>"
										+ owner
										+ "</td><td class=\'rightcolumn\'>اسم المالك / واضع اليد</td></tr><tr><td>"
										+ sid
										+ "</td><td class=\'rightcolumn\'>الرقم القومى</td></tr><tr><td>"
										+ phone
										+ "</td><td class=\'rightcolumn\'>التليفون</td></tr></table><br>"
										+ "<br>"
										+ link1
										+ "&nbsp;&nbsp;&nbsp;"
										+ link2
										+ "&nbsp;&nbsp;&nbsp;"
										+ link3
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
				//map.data.revertStyle();
				//infowindow.close();
			});
		}

		function move(id) {
			window.location.href = "<c:url value='arealayers'><c:param name='id' value='idvalue'/></c:url>".replace("idvalue",id);
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