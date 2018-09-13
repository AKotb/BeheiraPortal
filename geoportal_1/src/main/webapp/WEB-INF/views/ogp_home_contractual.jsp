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
	content="width=device-width, initial-scale=1, maximum-scale=1">

<!-- CSS -->
<link rel="stylesheet"
	href="resources/css/css/css/css/tooplate-style.css">
<link rel="stylesheet"
	href="resources/css/beheira.css">
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
		<img src="resources/css/css/css/css/images/projectname.png"
			alt="project name" class="projectname">
	</div>
	<div id="extra"></div>
	<script>
		var map;
		var infowindow;
		var lat;
		var lng;
		var farms;
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
			var distirct_layer = new google.maps.Data({map: map});
			distirct_layer.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/165.json'); 
			var db_layer = new google.maps.Data({map: map});
			db_layer.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/db.json');
			/* var db = (function() {
		        var json = null;
		        $.ajax({
		            'async': false,
		            'global': false,
		            'url': "https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/db.json",
		            'dataType': "json",
		            'success': function (data) {
		                json = data;
		            }
		        });
		        return json;
		    })();
			map.data.addGeoJson(db);
			var distirct = (function() {
		        var json = null;
		        $.ajax({
		            'async': false,
		            'global': false,
		            'url': "https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/165.json",
		            'dataType': "json",
		            'success': function (data) {
		                json = data;
		            }
		        });
		        return json;
		    })();
			map.data.addGeoJson(distirct); */
			
			/* map.data
					.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/db.json'); */
			/* map.data
			.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/165.json'); */
			/*var kmbuffer2Layer = new google.maps.KmlLayer(
					{
						url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/2km_buffer.kml',
						map : map
					});*/
					
			infowindow = new google.maps.InfoWindow();
			distirct_layer.setStyle(function(feature) {
						var folderpath = feature.getProperty('FolderPath');
						if (folderpath) {
							return ({
								fillColor : 'transparent',
								strokeColor : 'black',
								strokeWeight : 2
							});
						}
					});
			db_layer.setStyle(function(feature) {
				var folderpath = feature.getProperty('FolderPath');
				if (folderpath) {
					return ({
						fillColor : 'transparent',
						strokeColor : 'black',
						strokeWeight : 2
					});
				} else {
					var color = '#088da5';
					var color_selected = 'red';
					var showfarm_id = "${showfarm_id}";
					
					if (feature.getProperty('M_ID') == showfarm_id) {
						return ({
							fillColor : color_selected,
							strokeColor : color_selected,
							strokeWeight : 4
						});
					} else {
						return ({
							fillColor : color,
							strokeColor : color,
							strokeWeight : 2
						});
					}
				}
			});

			db_layer
					.addListener(
							'click',
							function(event) {
								var folderpath = event.feature
										.getProperty('FolderPath');
								if (folderpath) {
									folderpath = folderpath;
								} else {
									db_layer.overrideStyle(event.feature, {
										strokeWeight : 4,
										fillColor : 'green'
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
									var owner = event.feature
											.getProperty('Farm_Owner');
									if (owner) {
										owner = owner;
									} else {
										owner = "غير متوفر";
									}
									var farm_name = event.feature
											.getProperty('Farm_Name');
									if (farm_name) {
										farm_name = farm_name;
									} else {
										farm_name = "غير متوفر";
									}
									var sid = event.feature
											.getProperty('Owner_ID');
									if (sid) {
										sid = sid;
									} else {
										sid = "غير متوفر";
									}
									var phone = event.feature
											.getProperty('Tel');
									if (phone) {
										phone = phone;
									} else {
										phone = "غير متوفر";
									}
									var ownership = event.feature
											.getProperty('Ownership');
									if (ownership) {
										ownership = ownership;
									} else {
										ownership = "غير متوفر";
									}
									var area_id = event.feature
											.getProperty('M_ID');
									if (area_id) {
										area_id = area_id;
									} else {
										area_id = "0";
									}
									var farm_area = event.feature
											.getProperty('Farm_Area');
									var feddan;
									var qirat;
									var sahm;
									if (farm_area) {
										var area = farm_area.toString();
										var fedarr = area.split("-");
										feddan = fedarr[0];
										qirat = fedarr[1];
										sahm = fedarr[2];
									} else {
										feddan = "غير متوفر";
										qirat = "غير متوفر";
										sahm = "غير متوفر";
									}
									var db_farmname = "";
									var db_ownerid = "";
									var db_ownername = "";
									var db_ownertel = "";
									var db_ownership = "";
									var db_displayedownership = "";
									for ( var i in farms) {
										if (farms[i].farmID === area_id) {
											if (farms[i].farmName) {
												db_farmname = farms[i].farmName;
											} else {
												db_farmname = "غير متوفر";
											}

											if (farms[i].ownerID) {
												db_ownerid = farms[i].ownerID;
											} else {
												db_ownerid = "غير متوفر";
											}

											if (farms[i].ownerName) {
												db_ownername = farms[i].ownerName;
											} else {
												db_ownername = "غير متوفر";
											}

											if (farms[i].telephone) {
												db_ownertel = farms[i].telephone;
											} else {
												db_ownertel = "غير متوفر";
											}

											if (farms[i].ownership) {
												db_ownership = farms[i].ownership;
												if (db_ownership === '1') {
													db_displayedownership = "تمليك";
												}
												if (db_ownership === '2') {
													db_displayedownership = "إيجار";
												}
												if (db_ownership === '3') {
													db_displayedownership = "وضع اليد";
												}
												if (db_ownership === '') {
													db_displayedownership = "غير متوفر";
												}
												if (db_ownership === 'غير متوفر') {
													db_displayedownership = "غير متوفر";
												}
											} else {
												db_ownership = "غير متوفر";
												db_displayedownership = "غير متوفر";
											}
										} 
										/* else {
											db_farmname = farm_name;
											db_ownerid = sid;
											db_ownername = owner;
											db_ownertel = phone;
											db_displayedownership = ownership;
										} */
									}

									var link2 = "<a href=\'javascript:void(0);\' onclick=\'move_raster("
											+ area_id
											+ ");\' class=\'button\'> مرئيات فضائية </a>";
									var link3 = "<a href=\'javascript:void(0);\' onclick=\'vouchers("
											+ area_id
											+ ");\' class=\'button\'>"
											+ " طلب إجراءات التقنين_المعاينة/الفحص "
											+ "</a>";
									var link4 = "<a href=\'resources/datafiles/"+area_id+".jpg\' target='_blank'><img class=\'infowindowimg\' src=\'resources/datafiles/"+area_id+".jpg\' alt=\'Icon\' style=\"width:300px;height:170px;\"></a>";
									var link1 = "<a href=\'javascript:void(0);\' onclick=\'move("
											+ area_id
											+ ");\' class=\'button\'> خرائط استخدامات الأراضى </a>";
									var content = "<div style=\"text-align:center; overflow:hidden;\"><h1 style=\"background-color: #44a959;\">"
											+ "بيانات قطعة الأرض" + "</h1><br>"
											+ link4
											+ "<br>"
											+ "<table class=\"outertable\" style=\"dir: rtl;\"><tr><td class=\'td\'>"
											+ area_id
											+ "</td><td class=\'rightcolumn\'>كود المزرعة / الشركة</td></tr><tr><td class=\'td\'>"
											+ db_farmname
											+ "</td><td class=\'rightcolumn\'>اسم المزرعة / الشركة</td></tr><tr><td class=\'td\'><table class=\"innertable\"><tr><td class=\'td\'>س</td><td class=\'td\'>ط</td><td class=\'td\'>ف</td></tr><tr><td class=\'td\'>"
											+ sahm
											+ "</td><td class=\'td\'>"
											+ qirat
											+ "</td><td class=\'td\'>"
											+ feddan
											+ "</td></tr></table>"
											+ "</td><td class=\'rightcolumn\'>المساحة</td></tr><tr><td class=\'td\'>"
											+ db_displayedownership
											+ "</td><td class=\'rightcolumn\'>نوع الحيازة</td></tr><tr><td class=\'td\'>"
											+ db_ownername
											+ "</td><td class=\'rightcolumn\'>اسم المالك / واضع اليد</td></tr><tr><td class=\'td\'>"
											+ db_ownerid
											+ "</td><td class=\'rightcolumn\'>الرقم القومى</td></tr><tr><td class=\'td\'>"
											+ db_ownertel
											+ "</td><td class=\'rightcolumn\'>التليفون</td></tr></table><br>"
											+ "<br>"
											+ link1
											+ "&nbsp;&nbsp;&nbsp;"
											+ link2
											+ "&nbsp;&nbsp;&nbsp;"
											+ link3
											+ "<span onclick='colse_infowindow()' class='searchClose'>[&times;]</span></div>";

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

			db_layer.addListener('mouseover', function(event) {
				var folderpath = event.feature.getProperty('FolderPath');
				if (folderpath) {
					folderpath = folderpath;
				} else {
					db_layer.revertStyle();
					db_layer.overrideStyle(event.feature, {
						strokeWeight : 4,
						fillColor : 'yellow'
					});
				}
			});

			db_layer.addListener('mouseout', function(event) {
				db_layer.revertStyle();
			});
		}

		function move(id) {
			var params = [ id, lat, lng ];
			var location = "<c:url value='arealayers'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", params);
			window.location.href = location;
		}

		function move_raster(id) {
			var params = [ id, lat, lng ];
			var location = "<c:url value='rasterlayers'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", params);
			window.location.href = location;
		}

		function vouchers(id) {
			var location = "<c:url value='vouchers'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", id);
			window.location.href = location;
		}
		
		function colse_infowindow() {
			//alert("Closing info window");
			infowindow.close();
		}

		window.onload = function() {
			farmsjson = '${farms}';
			if (farmsjson) {
				farms = JSON.parse(farmsjson);
			} else {
				var location = "<c:url value='getallavailablefarms'><c:param name='params' value='paramsvalues'/></c:url>";
				var params = ["${showfarm_id}", "lat", "lng"];
				location = location.replace("paramsvalues", params);
				window.location.href = location;
			}
		}

		function voucherAction() {
			var voucher_ID = document.getElementById('voucher_ID').value;
			var gov = document.getElementById('gov').value;
			var site = document.getElementById('site').value;
			var person_ID = document.getElementById('person_ID').value;
			var Person_Name = document.getElementById('Person_Name').value;
			var voucher_Date = document.getElementById('voucher_Date').value;
			var Fees_Status = document.getElementById('Fees_Status').value;
			var Amount = document.getElementById('Amount').value;
			var Payment_Status = document.getElementById('Payment_Status').value;
			var Issuing_document = document.getElementById('Issuing_document').value;
			var Issuing_document_section = document
					.getElementById('Issuing_document_section').value;
			var Issuing_Date = document.getElementById('Issuing_Date').value;
			var Issuing_document_No = document
					.getElementById('Issuing_document_No').value;
			var Notes = document.getElementById('Notes').value;

			alert("[voucher_ID:" + voucher_ID + ", gov:" + gov + ", site:"
					+ site + ", person_ID:" + person_ID + ", Person_Name:"
					+ Person_Name + ", voucher_Date:" + voucher_Date
					+ ", Fees_Status:" + Fees_Status + ", Amount:" + Amount
					+ ", Payment_Status:" + Payment_Status
					+ ", Issuing_document:" + Issuing_document
					+ ", Issuing_document_section:" + Issuing_document_section
					+ ", Issuing_Date:" + Issuing_Date
					+ ", Issuing_document_No:" + Issuing_document_No
					+ ", Notes:" + Notes + "]");
		}

		function voucherPrint() {
			window.print();
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