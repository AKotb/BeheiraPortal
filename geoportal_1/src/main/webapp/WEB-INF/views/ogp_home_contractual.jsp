
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
<link rel="stylesheet" href="resources/css/beheira.css">
</head>

<body>
	<div class="container">
	<% 
               HttpSession sessions = request.getSession(true);
               String username = (String)sessions.getAttribute("UserName");
               if(username==null){
               
                   %>
           <a class ="loginanchor" href="userlogin">تسجيل دخول</a>
           <%} else {%>
           
           <div>اهلا ب يا<%=username%> <a href="userlogout">الخروج</a></div> 
           <%}%>
		<ul class="nav">
			<a href="searchforfarms"> <img
				src="resources/css/css/css/css/images/SEARCH.png" alt="SEARCH" /></a>
			<a href="who_we_are"><img
				src="resources/css/css/css/css/images/WHO ARE WE.png"
				alt="WHO ARE WE"></a>
			<a href="regulations_and_laws"><img
				src="resources/css/css/css/css/images/REGULATIONS AND LAWS.png"
				alt="REGULATIONS AND LAWS"></a>
			<a href="statistics"><img
				src="resources/css/css/css/css/images/STATISTICS.png"
				alt="STATISTICS"></a>
			<a href="index"><img
				src="resources/css/css/css/css/images/HOME.png" alt="HOME"></a>
		</ul>
		<p class='cur_title'>تنمية أراضي محافظة البحيرة</p>
		<img src="resources/css/css/css/css/images/projectname.png"
			alt="project name" class="projectname">
	</div>
               
	<div id="extra"></div>
	<script>
		var map;
		var infowindow;
		var farmlat;
		var farmlng;
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
			farmtozoomto = '${showfarm_id}';
			if (farmtozoomto) {
				selectedfarmlat = parseFloat('${selectedlat}');
				selectedfarmlng = parseFloat('${selectedlng}');
				map.setCenter({
					lat : selectedfarmlat,
					lng : selectedfarmlng
				});
				map.setZoom(map.getZoom() + 3);
			}
			
			var distirct_layer = new google.maps.Data({
				map : map
			});
			distirct_layer.loadGeoJson('http://wn.narss.sci.eg:8080/JSON/165.json'); // for production
			//distirct_layer.loadGeoJson('http://localhost:8080/JSON/165.json'); //localhost for development
			
			var db_layer = new google.maps.Data({
				map : map
			});
			db_layer.loadGeoJson('http://wn.narss.sci.eg:8080/JSON/db.json'); // for Production
			//db_layer.loadGeoJson('http://localhost:8080/JSON/db.json'); //localhost for development
			
			var db2_layer = new google.maps.Data({
				map : map
			});
			db2_layer.loadGeoJson('http://wn.narss.sci.eg:8080/JSON/db_2.json'); // for production
			//db2_layer.loadGeoJson('http://localhost:8080/JSON/db_2.json'); //localhost for development
			
			infowindow = new google.maps.InfoWindow();
			
			distirct_layer.setStyle(function(feature) {
				var folderpath = feature.getProperty('FolderPath');
				if (folderpath) {
					return ({
						fillColor : 'transparent',
						strokeColor : 'black',
						strokeWeight : 4
					});
				}
			});
			
			db_layer.setStyle(function(feature) {
				var folderpath = feature.getProperty('FolderPath');
				if (folderpath) {
					return ({
						fillColor : 'transparent',
						strokeColor : 'black',
						strokeWeight : 4
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
			
			db2_layer.setStyle(function(feature) {
				var folderpath = feature.getProperty('FolderPath');
				if (folderpath) {
					return ({
						fillColor : 'transparent',
						strokeColor : 'black',
						strokeWeight : 4
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
									db_layer.revertStyle();
									db_layer.overrideStyle(event.feature, {
										strokeWeight : 4,
										strokeColor : 'red',
										fillColor : 'green'
									});
									farmlat = event.latLng.lat();
									farmlng = event.latLng.lng();
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
									}
									var link0 = "<a href=\'datafiles/mahader/0.png\' target='_blank' class=\'button\'> محضر معاينة </a>";
									if (200 == urlExists('datafiles/mahader/'
											+ area_id + '.png')) {
										link0 = "<a href=\'datafiles/mahader/"+area_id+".png\' target='_blank' class=\'button\'> محضر معاينة </a>";
									}
									var link2 = "<a href=\'javascript:void(0);\' onclick=\'move_raster("
											+ area_id
											+ ");\' class=\'button\'> مرئيات فضائية </a>";
									var link3 = "<a href=\'javascript:void(0);\' onclick=\'vouchers("
											+ area_id
											+ ");\' class=\'button\'>"
											+ "طلب إجراءات التقنين" + "</a>";
									var link4 = "<a href=\'datafiles/sketch/"+area_id+".jpg\' target='_blank'><img class=\'infowindowimg\' src=\'datafiles/sketch/"+area_id+".jpg\' alt=\'Icon\' style=\"width:300px;height:170px;\"></a>";
									var link1 = "<a href=\'javascript:void(0);\' onclick=\'move("
											+ area_id
											+ ");\' class=\'button\'> استخدامات الأراضى </a>";
									var content = "<div style=\"text-align:center; overflow:hidden;\"><h1 style=\"background-color: #44a959;\">"
											+ "بيانات قطعة الأرض" + "</h1>"
											+ link4
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
                                                                                        +"<div id=\"errormsg\"></div>"
											+ "<table><tr><td class=\'td-button\'>"
											+ link0
											+ "</td><td class=\'td-button\'>"
											+ link3
											+ "</td><td class=\'td-button\'>"
											+ link2
											+ "</td><td class=\'td-button\'>"
											+ link1
											+ "</td></tr></table>"
											+ "<span onclick='close_infowindow()' class='searchClose'>[&times;]</span></div>";
									infowindow.setContent(content);
									infowindow.setPosition(event.latLng);
									infowindow.open(map);
								}
							});

			db2_layer
					.addListener(
							'click',
							function(event) {
								var folderpath = event.feature
										.getProperty('FolderPath');
								if (folderpath) {
									folderpath = folderpath;
								} else {
									db2_layer.revertStyle();
									db2_layer.overrideStyle(event.feature, {
										strokeWeight : 4,
										strokeColor : 'red',
										fillColor : 'green'
									});
									farmlat = event.latLng.lat();
									farmlng = event.latLng.lng();
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
									}
									var link0 = "<a href=\'datafiles/mahader/0.png\' target='_blank' class=\'button\'> محضر معاينة </a>";
									if (200 == urlExists('datafiles/mahader/'
											+ area_id + '.png')) {
										link0 = "<a href=\'datafiles/mahader/"+area_id+".png\' target='_blank' class=\'button\'> محضر معاينة </a>";
									}
									var link2 = "<a href=\'javascript:void(0);\' onclick=\'move_raster("
											+ area_id
											+ ");\' class=\'button\'> مرئيات فضائية </a>";
									var link3 = "<a href=\'javascript:void(0);\' onclick=\'vouchers("
											+ area_id
											+ ");\' class=\'button\'>"
											+ "طلب إجراءات التقنين" + "</a>";
									var link4 = "<a href=\'datafiles/sketch/"+area_id+".jpg\' target='_blank'><img class=\'infowindowimg\' src=\'datafiles/sketch/"+area_id+".jpg\' alt=\'Icon\' style=\"width:300px;height:170px;\"></a>";
									var link1 = "<a href=\'javascript:void(0);\' onclick=\'move("
											+ area_id
											+ ");\' class=\'button\'> استخدامات الأراضى </a>";
									var content = "<div style=\"text-align:center; overflow:hidden;\"><h1 style=\"background-color: #44a959;\">"
											+ "بيانات قطعة الأرض" + "</h1>"
											+ link4
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
                                                                                 +"<div id=\"errormsg\"></div>"
											+ "<table><tr><td class=\'td-button\'>"
											+ link0
											+ "</td><td class=\'td-button\'>"
											+ link3
											+ "</td><td class=\'td-button\'>"
											+ link2
											+ "</td><td class=\'td-button\'>"
											+ link1
											+ "</td></tr></table>"
											+ "<span onclick='close_infowindow()' class='searchClose'>[&times;]</span></div>";
									infowindow.setContent(content);
									infowindow.setPosition(event.latLng);
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

			db2_layer.addListener('mouseover', function(event) {
				var folderpath = event.feature.getProperty('FolderPath');
				if (folderpath) {
					folderpath = folderpath;
				} else {
					db2_layer.revertStyle();
					db2_layer.overrideStyle(event.feature, {
						strokeWeight : 4,
						fillColor : 'yellow'
					});
				}
			});

			db2_layer.addListener('mouseout', function(event) {
				db2_layer.revertStyle();
			});
		}

		function move(id) {
               var errordiv=document.getElementById("errormsg");
               errordiv.style.color ="red";
                var UserRole="<%=session.getAttribute("UserRole")%>";
                if (UserRole!="null"){
                    if(UserRole=="2"||UserRole=="3"){
			var params = [ id, farmlat, farmlng ];
			var location = "<c:url value='arealayers'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", params);
			window.location.href = location;}
                    else
                    {
                        
                        errordiv.innerHTML = "غير مسموح بدخول هذا الصفحة";
                        
                    }
		}
                else
                {
                errordiv.innerHTML = "برجاء قم بتسجيل الدخول";
                
                }
                }

		function move_raster(id) 
                {
                    var errordiv=document.getElementById("errormsg");
                    errordiv.style.color ="red";
                 var UserRole="<%=session.getAttribute("UserRole")%>";
                if (UserRole!="null"){
                    if(UserRole=="2"||UserRole=="3"){
			var params = [ id, farmlat, farmlng ];
			var location = "<c:url value='rasterlayers'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", params);
			window.location.href = location;}
                    else
                    {
                        
                        errordiv.innerHTML = "غير مسموح بدخول هذا الصفحة";
                        
                    }
		}
                else
                {
                errordiv.innerHTML = "برجاء قم بتسجيل الدخول";
                
                }
		}

		function vouchers(id) {
                var errordiv=document.getElementById("errormsg");
                errordiv.style.color ="red";
                 var UserRole="<%=session.getAttribute("UserRole")%>";
                if (UserRole!="null"){
                    if(UserRole=="2"||UserRole=="3"){
			var params = [ id, farmlat, farmlng ];
			var location = "<c:url value='vouchers'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", params);
			window.location.href = location;
                        }
                    else
                    {
                        
                        errordiv.innerHTML = "غير مسموح بدخول هذا الصفحة";
                        
                    }
		}
                else
                {
                errordiv.innerHTML = "برجاء قم بتسجيل الدخول";
                
                }
		}

		function close_infowindow() {
			infowindow.close();
		}

		window.onload = function() {
			farmsjson = '${farms}';
			if (farmsjson) {
				farms = JSON.parse(farmsjson);
			} else {
				var location = "<c:url value='getallavailablefarms'><c:param name='params' value='paramsvalues'/></c:url>";
				if ("${showfarm_id}") {
					farmlat = '${selectedlat}';
					farmlng = '${selectedlng}';
				}
				var params = [ "${showfarm_id}", farmlat, farmlng ];
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
		}

		function voucherPrint() {
			window.print();
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