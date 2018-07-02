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

.divider {
	width: 5px;
	height: auto;
	display: inline-block;
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
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
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

.button:hover, .button:focus {
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

.btnsearch {
	border-radius: 12%;
}

/* Modal Content */
.modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 60%;
}

/* The Close Button */
.close {
	color: #aaaaaa;
	float: left;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}
</style>
</head>

<body>
	<div class="container">
		<ul class="nav">
			<a href="javascript:searchBox()" id="mysearch"><img
				src="resources/css/css/css/css/images/SEARCH.png" alt="SEARCH"></a>
			<!-- The Modal -->
			<div id="myModal" class="modal">

				<!-- Modal content -->
				<div class="modal-content">
					<span class="close">&times;</span>

					<h1 style="color: #3d6266;" align="center">بحث عن قطعة أرض</h1>

					<div align="center">

						<table border="0" style="dir: rtl;">
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="farm_name" value=""></td>
								<td align="right" style="color: #3d6266;">اسم المزرعة /
									الشركة</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="ownership" value=""></td>
								<td align="right" style="color: #3d6266;">نوع الحيازة</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="owner" value=""></td>
								<td align="right" style="color: #3d6266;">اسم المالك / واضع
									اليد</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="sid" value=""></td>
								<td align="right" style="color: #3d6266;">الرقم القومى</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="phone" value=""></td>
								<td align="right" style="color: #3d6266;">التليفون</td>
							</tr>
						</table>

					</div>

					<h2 align="center">
						<button onclick="searchAction()" class="button btnsearch"
							id="searchBtn">بحث</button>
					</h2>
					<div id="searchResults"></div>
				</div>

			</div>
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
		var lat;
		var lng;
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
									var coord0 = event.feature.getGeometry()
											.getAt(0).getAt(0);
									coord0 = String(coord0);
									coord0 = coord0.slice(1, -1);
									var coord0arr = coord0.split(",");
									var coord1 = event.feature.getGeometry()
											.getAt(0).getAt(1);
									coord1 = String(coord1);
									coord1 = coord1.slice(1, -1);
									var coord1arr = coord1.split(",");
									var coord2 = event.feature.getGeometry()
											.getAt(0).getAt(2);
									coord2 = String(coord2);
									coord2 = coord2.slice(1, -1);
									var coord2arr = coord2.split(",");
									var coord3 = event.feature.getGeometry()
											.getAt(0).getAt(3);
									coord3 = String(coord3);
									coord3 = coord3.slice(1, -1);
									var coord3arr = coord3.split(",");
									var coordinates = [];
									coordinates.push([ coord0arr[0],
											coord0arr[1] ]);
									coordinates.push([ coord1arr[0],
											coord1arr[1] ]);
									coordinates.push([ coord2arr[0],
											coord2arr[1] ]);
									coordinates.push([ coord3arr[0],
											coord3arr[1] ]);
									var bounds = new google.maps.LatLngBounds();
									for (var i = 0; i < coordinates.length; i++) {
										bounds.extend(new google.maps.LatLng(
												coordinates[i][0],
												coordinates[i][1]));
									}
									mapcenter = bounds.getCenter();
									lat = mapcenter.lat();
									lng = mapcenter.lng();
									//map.setZoom(15);
									//map.setCenter(new google.maps.LatLng(lat, lng));

									var owner = event.feature
											.getProperty('OWNER');
									var farm_name = event.feature
											.getProperty('Farm_Name');
									var sid = event.feature
											.getProperty('Owner_ID');
									var phone = event.feature
											.getProperty('Mang_Tel');
									var ownership = event.feature
											.getProperty('Ownership');
									var area_id = event.feature
											.getProperty('id');
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
											+ "<table class=\"outertable\" style=\"dir: rtl;\"><tr><td class=\'td\'>"
											+ farm_name
											+ "</td><td class=\'rightcolumn\'>اسم المزرعة / الشركة</td></tr><tr><td class=\'td\'><table class=\"innertable\"><tr><td class=\'td\'>س</td><td class=\'td\'>ط</td><td class=\'td\'>ف</td></tr><tr><td class=\'td\'>"
											+ sahm
											+ "</td><td class=\'td\'>"
											+ qirat
											+ "</td><td class=\'td\'>"
											+ feddan
											+ "</td></tr></table>"
											+ "</td><td class=\'rightcolumn\'>المساحة</td></tr><tr><td class=\'td\'>"
											+ ownership
											+ "</td><td class=\'rightcolumn\'>نوع الحيازة</td></tr><tr><td class=\'td\'>"
											+ owner
											+ "</td><td class=\'rightcolumn\'>اسم المالك / واضع اليد</td></tr><tr><td class=\'td\'>"
											+ sid
											+ "</td><td class=\'rightcolumn\'>الرقم القومى</td></tr><tr><td class=\'td\'>"
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
										pixelOffset : new google.maps.Size(0,
												-30)
									});
									infowindow.open(map);
								}
							});

			map.data.addListener('mouseout', function(event) {
				map.data.revertStyle();
				//infowindow.close();
			});
		}

		function move(id) {
			var params = [ id, lat, lng ];
			var location = "<c:url value='arealayers'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", params);
			/* var location = "<c:url value='arealayers'><c:param name='id' value='idvalue'/><c:param name='lat' value='latvalue'/><c:param name='lng' value='lngvalue'/></c:url>";
			location = location.replace("idvalue",id);
			location = location.replace("latvalue",lat);
			location = location.replace("lngvalue",lng); */
			window.location.href = location;
		}

		function searchBox() {
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
			readTextFile(
					'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/db.json',
					function(text) {
					});
		}

		function readTextFile(file, callback) {

			var rawFile = new XMLHttpRequest();
			rawFile.overrideMimeType("application/json");
			rawFile.open("GET", file, true);
			rawFile.onreadystatechange = function() {

				if (rawFile.readyState === 4 && rawFile.status == "200") {

					var mydata = JSON.parse(rawFile.responseText);
					var results = "";
					var num_of_items = 0;
					var search_owner = document.getElementById('owner').value;
					var search_ownership = document.getElementById('ownership').value;
					var search_farm_name = document.getElementById('farm_name').value;
					var search_sid = document.getElementById('sid').value;
					var search_phone = document.getElementById('phone').value;
					var cond1, cond2, cond3, cond4, cond5;

					for ( var val in mydata.features) {

						cond1 = false;
						cond2 = false;
						cond3 = false;
						cond4 = false;
						cond5 = false;

						if (mydata.features[val].properties.OWNER
								&& search_owner.length > 0)
							cond1 = mydata.features[val].properties.OWNER
									.includes(search_owner);
						if (mydata.features[val].properties.Ownership
								&& search_ownership.length > 0)
							cond2 = mydata.features[val].properties.Ownership
									.includes(search_ownership);
						if (mydata.features[val].properties.Farm_Name
								&& search_farm_name.length > 0)
							cond3 = mydata.features[val].properties.Farm_Name
									.includes(search_farm_name);
						if (mydata.features[val].properties.Owner_ID
								&& search_sid.length > 0)
							cond4 = mydata.features[val].properties.Owner_ID
									.toString().includes(search_sid);
						if (mydata.features[val].properties.owner_tele
								&& search_phone.length > 0)
							cond5 = mydata.features[val].properties.owner_tele
									.toString().includes(search_phone);

						if (cond1 || cond2 || cond3 || cond4 || cond5) {

							num_of_items = num_of_items + 1;
							results = results
									+ '<tr>'
									+ '<td align=\"right\">'
									+ '<button onclick=\"showSearchResults('
									+ val
									+ ')\" class=\"button btnsearch\" id=\"showSearchResultsBtn\">عرض على الخريطة</button>'
									+ '</td>' + '<td align=\"right\">'
									+ mydata.features[val].properties.OWNER
									+ '</td>' + '<td align=\"right\">'
									+ mydata.features[val].properties.Ownership
									+ '</td>' + '<td align=\"right\">'
									+ mydata.features[val].properties.Farm_Name
									+ '</td>' + '<td align=\"right\">' + val
									+ '</td>' + '</tr>';
						}
					}

					if (num_of_items > 0) {
						var search_header = '<div style=\"dir:rtl;\"><h3>تم إيجاد '
								+ num_of_items
								+ ' من نتائج البحث </h3></div><br><table border=\"0\" style=\"dir:rtl;\">'
								+ '<tr>'
								+ '<th align=\"right\">إعدادات</th>'
								+ '<th align=\"right\">اسم المالك / واضع اليد</th>'
								+ '<th align=\"right\">نوع الحيازة</th>'
								+ '<th align=\"right\">اسم المزرعة / الشركة</th>'
								+ '<th align=\"right\">م</th>' + '</tr>';
						results = search_header + results
								+ '</table><br><br><br><br><br><br><br><br>';
						document.getElementById('searchResults').innerHTML = results;
					} else
						document.getElementById('searchResults').innerHTML = '<div style=\"dir:rtl;\"><h3>عفوا ، لا توجد نتائج</h3></div>';

				}
			}
			rawFile.send(null);
		}

		function showSearchResults(id) {
			//alert("shown on the map [ id = "+id+" ]");
			var modal = document.getElementById('myModal');
			modal.style.display = "none";
			map.setZoom(13);
			map.setCenter(new google.maps.LatLng(30.22, 30.22));
			map.data.setStyle(function(event) {
				if (event.getProperty('id') === id) {
					var color = 'green';
					return ({
						fillColor : color,
						strokeColor : color,
						strokeWeight : 3
					});
				}
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