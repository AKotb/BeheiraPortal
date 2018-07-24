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

input.input-box {
	background-color: #fdddad; /* Green */
	color: #3d6266;
	padding: 2px;
	text-align: right;
	text-decoration: none;
}

.voucherTA {
	width: 250px;
	background-color: #fdddad; /* Green */
	color: #3d6266;
	padding: 2px;
	text-align: right;
	text-decoration: none;
}

.btnsearch {
	font: bold 24px Arial;
	text-decoration: none;
	background-color: #396266;
	color: white;
	padding: 2px 6px 2px 6px;
	border-top: 1px solid #CCCCCC;
	border-right: 1px solid #333333;
	border-bottom: 1px solid #333333;
	border-left: 1px solid #CCCCCC;
	border-radius: 12%;
}

.btnsearch:hover, .btnsearch:focus {
	background-color: #3d6266;
	color: #fcbb5b;
	text-decoration: none;
	cursor: pointer;
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
.searchClose, .voucherClose {
	color: #aaaaaa;
	float: left;
	font-size: 28px;
	font-weight: bold;
}

.searchClose:hover, .searchClose:focus, .voucherClose:hover,
	.voucherClose:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

.resultth {
	padding: 12px;
	background-color: #3d6266;
	color: #fdddad;
	text-align: center;
	font-size: 20px;
}

.resulttr {
	padding-top: 8px;
	padding-bottom: 8px;
	color: #3d6266;
	text-align: center;
	font-size: 18px;
}

.resulttr:nth-child(odd) {
	background-color: #cfdcdd;
}

.formheader{
	background-color: #3d6266; 
	color: #fcbb5b; 
	font: bold 40px Arial;
}

</style>
</head>

<body>
	<div class="container">
		<ul class="nav">
			<a id="mysearch" href="javascript:searchBox()"> <img
				src="resources/css/css/css/css/images/SEARCH.png" alt="SEARCH" /></a>
			<!-- The Modal -->
			<div id="myModal" class="modal">

				<!-- Modal content -->
				<div class="modal-content">
					<span class="searchClose">&times;</span>

					<h1 class="formheader" align="center">بحث عن قطعة أرض</h1>

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
			<a href="#" ><img
				src="resources/css/css/css/css/images/WHO ARE WE.png"
				alt="WHO ARE WE"></a>
			<div id="voucherModal" class="modal">

				<!-- Modal content -->
				<div class="modal-content">
					<span class="voucherClose">&times;</span>

					<h1 style="color: #3d6266;" align="center">طلب تحصيل</h1>

					<div align="center">

						<table border="0" style="dir: rtl;">
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="voucher_ID" value=""></td>
								<td align="right" style="color: #3d6266;">رقم الطلب</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="gov" value=""></td>
								<td align="right" style="color: #3d6266;">المحافظة</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="site" value=""></td>
								<td align="right" style="color: #3d6266;">الموقع</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="person_ID" value=""></td>
								<td align="right" style="color: #3d6266;">الرقم القومى</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="Person_Name" value=""></td>
								<td align="right" style="color: #3d6266;">مقدم الطلب</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="date"
									id="voucher_Date" value=""></td>
								<td align="right" style="color: #3d6266;">تاريخ الطلب</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="Fees_Status" value=""></td>
								<td align="right" style="color: #3d6266;">نوع الرسوم</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="Amount" value=""></td>
								<td align="right" style="color: #3d6266;">المبلغ</td>
							</tr>
							<tr>
								<td align="right"><input type="checkbox"
									id="Payment_Status" value="no"></td>
								<td align="right" style="color: #3d6266;">تم الدفع</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="Issuing_document" value=""></td>
								<td align="right" style="color: #3d6266;">جهة إصدار الوثيقة</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="Issuing_document_section" value=""></td>
								<td align="right" style="color: #3d6266;">الفرع</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="date"
									id="Issuing_Date" value=""></td>
								<td align="right" style="color: #3d6266;">تاريخ الإصدار</td>
							</tr>
							<tr>
								<td align="right"><input class="input-box" type="text"
									id="Issuing_document_No" value=""></td>
								<td align="right" style="color: #3d6266;">رقم الوثيقة</td>
							</tr>
							<tr>
								<td align="right"><textarea class="voucherTA" rows="5"
										id="Notes" value=""></textarea></td>
								<td align="right" style="color: #3d6266;">ملاحظات</td>
							</tr>
						</table>

					</div>

					<h2 align="center">
						<button onclick="voucherAction()" class="btnsearch"
							id="voucherBtn">تحصيل</button>
						<button onclick="voucherPrint()" class="btnsearch" id="voucherBtn">طباعة</button>
					</h2>
					<div id="voucherResults"></div>
					<br>
					<br>
					<br>
					<br>
					<br>
				</div>

			</div>
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
			map.data.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/db.json');
			/* map.data
					.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/db1.json');
			map.data
					.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/db2.json');
			map.data
					.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/db3.json');
			map.data
					.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/db4.json');
			map.data
					.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/db5.json');
			map.data
					.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/db6.json'); */
			map.data
					.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/165.json');
			//map.data.loadGeoJson('https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/2km_buffer.json');
			var kmbuffer2Layer = new google.maps.KmlLayer(
					{
						url : 'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/2km_buffer.kml',
						map : map
					});
			infowindow = new google.maps.InfoWindow();
			map.data.setStyle(function(feature) {
				var folderpath = feature.getProperty('FolderPath');
				if (folderpath) {
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

			});

			// when the user moves the mouse over the polygons
			map.data
					.addListener(
							'mouseover',
							function(event) {
								var folderpath = event.feature
										.getProperty('FolderPath');
								if (folderpath) {
									folderpath = folderpath;
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
											.getProperty('id');
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

									var link2 = "<a href=\'#\' class=\'button\'>"
											+ " مرئيات فضائية " + "</a>";
									var link3 = "<a href=\'javascript:void(0);\' onclick=\'vouchers("
											+ area_id
											+ ");\' class=\'button\'>"
											+ " طلب إجراءات التقنين_المعاينة/الفحص "
											+ "</a>";
									var link4 = "<a href=\'resources/datafiles/"+area_id+".jpg\' target='_blank'><img class=\'infowindowimg\' src=\'resources/datafiles/"+area_id+".jpg\' alt=\'Icon\' style=\"width:300px;height:170px;\"></a>";
									var link1 = "<a href=\'javascript:void(0);\' onclick=\'move("
											+ area_id
											+ ");\' class=\'button\'> خرائط استخدامات الأراضى </a>";
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
			window.location.href = location;
		}

		function vouchers(id) {
			var location = "<c:url value='vouchers'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", id);
			window.location.href = location;
		}
		
		window.onload = function() {
			voucherjson = '${voucher}';
			if (voucherjson) {
				var voucher = JSON.parse(voucherjson);
				alert("Voucher ID: " + voucher.voucherID);
				alert("Gov: " + voucher.gov);
				alert("Site: " + voucher.site);
			}
		}
		
		function searchBox() {
			// Get the modal
			var modal = document.getElementById('myModal');

			// Get the button that opens the modal
			var btn = document.getElementById("mysearch");

			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("searchClose")[0];

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
					'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/db.json',
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
					
					var My_Farm_Owner = "";
					var My_Ownership = "";
					var My_Farm_Name = "";
					
					for ( var val in mydata.features) {

						cond1 = false;
						cond2 = false;
						cond3 = false;
						cond4 = false;
						cond5 = false;

						if (mydata.features[val].properties.Farm_Owner/*OWNER*/
								&& search_owner.length > 0)
							cond1 = mydata.features[val].properties.Farm_Owner/*OWNER*/
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
						if (mydata.features[val].properties.Tel/*owner_tele*/
								&& search_phone.length > 0)
							cond5 = mydata.features[val].properties.Tel/*owner_tele*/
							.toString().includes(search_phone);

						if (cond1 || cond2 || cond3 || cond4 || cond5) {
							
							if (mydata.features[val].properties.Farm_Owner) {
								My_Farm_Owner = mydata.features[val].properties.Farm_Owner;
							} else {
								My_Farm_Owner = "غير متوفر";
							}
							
							if (mydata.features[val].properties.Ownership) {
								My_Ownership = mydata.features[val].properties.Ownership;
							} else {
								My_Ownership = "غير متوفر";
							}
							
							if (mydata.features[val].properties.Farm_Name) {
								My_Farm_Name = mydata.features[val].properties.Farm_Name;
							} else {
								My_Farm_Name = "غير متوفر";
							}
							
							num_of_items = num_of_items + 1;
							results = results
									+ '<tr class=\"resulttr\">'
									+ '<td align=\"right\">'
									+ '<button onclick=\"showSearchResults('
									+ val
									+ ')\" class=\"button\" id=\"showSearchResultsBtn\">عرض على الخريطة</button>'
									+ '</td>'
									+ '<td align=\"right\">'
									+ My_Farm_Owner/*OWNER*/
									+ '</td>' + '<td align=\"right\">'
									+ My_Ownership
									+ '</td>' + '<td align=\"right\">'
									+ My_Farm_Name
									+ '</td>' + '<td>' + val + '</td>'
									+ '</tr>';
						}
					}

					if (num_of_items > 0) {
						var search_header = '<div align=\"center\"><h3 align=\"center\">تم إيجاد '
								+ num_of_items
								+ ' من نتائج البحث </h3><br><table border=\"0\" align=\"center\">'
								+ '<tr>'
								+ '<th class=\"resultth\">إعدادات</th>'
								+ '<th class=\"resultth\">اسم المالك / واضع اليد</th>'
								+ '<th class=\"resultth\">نوع الحيازة</th>'
								+ '<th class=\"resultth\">اسم المزرعة / الشركة</th>'
								+ '<th class=\"resultth\"> رقم </th>' + '</tr>';
						results = search_header
								+ results
								+ '</table></div><br><br><br><br><br><br><br><br>';
						document.getElementById('searchResults').innerHTML = results;
					} else
						document.getElementById('searchResults').innerHTML = '<div align=\"center\"><h3>عفوا ، لا توجد نتائج</h3></div>';

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
				} else {
					return ({
						fillColor : 'transparent',
						strokeColor : 'blue',
						strokeWeight : 2
					});
				}
			});
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