<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<title>إحصائيات</title>
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
			String username = (String) sessions.getAttribute("UserName");
			if (username == null) {
		%>
		<a href="userlogin" class="loginanchor">تسجيل دخول</a>
		<%
			} else {
		%>

		<div>
			اهلا ب يا<%=username%>
			<a href="userlogout">الخروج</a>
		</div>
		<%
			}
		%>
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
		<p class='cur_title'>إحصائيات</p>
		<img src="resources/css/css/css/css/images/projectname.png"
			alt="project name" class="projectname">
	</div>
	<div class="extra_noheight">
		<div id="searchForm" class="modal-content" align="center">
					<div style="width: 49%; float: left;">
						<div id="chartTitle1" style="width: 100%; height: 50px; text-align: center; background-color: #32a854; color: #0000FF; border-radius: 20px 20px 0px 0px;">
							<h2>
								<p style="padding: 10px">البيانات الإحصائية الخاصة بالمنطقة  - و</p>
							</h2>
						</div>
						<div id="piechart3" style="width: 100%; height: 500px;"></div><br>
						<div id="chartTitleDetails1" style="width: 100%; height: 50px; text-align: center; background-color: #32a854; color: #0000FF; border-radius: 20px 20px 0px 0px;">
							<h2>
								<p style="padding: 10px"><span>البيانات الإحصائية  التفصيلية الخاصة بالمنطقة   - و - </span><span id='details1'></span></p>
							</h2>
						</div>
						<div id="piechart1" style="width: 100%; height: 500px;"></div>
					
						
					</div>
					<div style="width: 49%; float: right;">
						
					<div id="chartTitle2" style="width: 100%; height: 50px; text-align: center; background-color: #32a854; color: #0000FF; border-radius: 20px 20px 0px 0px;">
							<h2>
								<p style="padding: 10px">البيانات الإحصائية الخاصة بالمنطقة  - هـــ</p>
							</h2>
						</div>
						<div id="piechart4" style="width: 100%; height: 500px;"></div><br>
						<div id="chartTitleDetails2" style="width: 100%; height: 50px; text-align: center; background-color: #32a854; color: #0000FF; border-radius: 20px 20px 0px 0px;">
							<h2>
								<p style="padding: 10px"><span>البيانات الإحصائية  التفصيلية الخاصة بالمنطقة   - هــ - </span><span id='details2'></span></p>
							</h2>
						</div>
						<div id="piechart2" style="width: 100%; height: 500px;"></div>
					</div>
		</div>
	</div>

	<script>
		var farms;
		// 0: allReclamedArea1, 1: allUrbanArea1, 2: allUnusedArea1, 3: allFieldCropsArea1, 4: allCropsArea1
		var allOwnershipDetails1 = [0.0, 0.0, 0.0, 0.0, 0.0];
		var allRentDetails1 = [0.0, 0.0, 0.0, 0.0, 0.0];
		var allHandDetails1 = [0.0, 0.0, 0.0, 0.0, 0.0];
		var allOtherDetails1 = [0.0, 0.0, 0.0, 0.0, 0.0];
		
		var allOwnershipDetails2 = [0.0, 0.0, 0.0, 0.0, 0.0];
		var allRentDetails2 = [0.0, 0.0, 0.0, 0.0, 0.0];
		var allHandDetails2 = [0.0, 0.0, 0.0, 0.0, 0.0];
		var allOtherDetails2 = [0.0, 0.0, 0.0, 0.0, 0.0];
		
		var allOwnership1 = 0;
		var allRent1 = 0;
		var allHand1 = 0;
		var allOther1 = 0;
		
		var allOwnership2 = 0;
		var allRent2 = 0;
		var allHand2 = 0;
		var allOther2 = 0;
		
		var options3;
		var options4;
		
		var chart2;
		var options2;
		var data2;
		
		var chart1;
		var options1;
		var data1;
		
		window.onload = function() {
			document.getElementById('details1').textContent = 'تمليك'; 
			document.getElementById('details2').textContent = 'تمليك';
			farmsjson = '${farms}';
			if (farmsjson) {
				farms = JSON.parse(farmsjson);

				var curReclamedArea = 0.0;
				var curUrbanArea = 0.0;
				var curUnusedArea = 0.0;
				var curFieldCropsArea = 0.0;
				var curCropsArea = 0.0;
				var curState = 0;
				
				for ( var i in farms) {

					if (farms[i].reclamedArea) {
						curReclamedArea = parseFloat(farms[i].reclamedArea);
					} else {
						curReclamedArea = 0.0;
					}

					if (farms[i].urbanArea) {
						curUrbanArea = parseFloat(farms[i].urbanArea);
					} else {
						curUrbanArea = 0.0;
					}

					if (farms[i].unusedArea) {
						curUnusedArea = parseFloat(farms[i].unusedArea);
					} else {
						curUnusedArea = 0.0;
					}

					if (farms[i].fieldCropsArea) {
						curFieldCropsArea = parseFloat(farms[i].fieldCropsArea);
					} else {
						curFieldCropsArea = 0.0;
					}

					if (farms[i].cropsArea) {
						curCropsArea = parseFloat(farms[i].cropsArea);
					} else {
						curCropsArea = 0.0;
					}
					
					if(parseInt(farms[i].farmID, 10) <= 264){
						
						if(farms[i].ownership){
							curState = farms[i].ownership;
							if (curState === '1') {
								allOwnership1 = allOwnership1 + 1;
								
								allOwnershipDetails1[0] = allOwnershipDetails1[0] + curReclamedArea;
								allOwnershipDetails1[1] = allOwnershipDetails1[1] + curUrbanArea;
								allOwnershipDetails1[2] = allOwnershipDetails1[2] + curUnusedArea;
								allOwnershipDetails1[3] = allOwnershipDetails1[3] + curFieldCropsArea;
								allOwnershipDetails1[4] = allOwnershipDetails1[4] + curCropsArea;
							}
							if (curState === '2') {
								allRent1 = allRent1 + 1;
								
								allRentDetails1[0] = allRentDetails1[0] + curReclamedArea;
								allRentDetails1[1] = allRentDetails1[1] + curUrbanArea;
								allRentDetails1[2] = allRentDetails1[2] + curUnusedArea;
								allRentDetails1[3] = allRentDetails1[3] + curFieldCropsArea;
								allRentDetails1[4] = allRentDetails1[4] + curCropsArea;
							}
							if (curState === '3') {
								allHand1 = allHand1 + 1;
								
								allHandDetails1[0] = allHandDetails1[0] + curReclamedArea;
								allHandDetails1[1] = allHandDetails1[1] + curUrbanArea;
								allHandDetails1[2] = allHandDetails1[2] + curUnusedArea;
								allHandDetails1[3] = allHandDetails1[3] + curFieldCropsArea;
								allHandDetails1[4] = allHandDetails1[4] + curCropsArea;
							}
							if (curState === '4') {
								allOther1 = allOther1 + 1;
								
								allOtherDetails1[0] = allOtherDetails1[0] + curReclamedArea;
								allOtherDetails1[1] = allOtherDetails1[1] + curUrbanArea;
								allOtherDetails1[2] = allOtherDetails1[2] + curUnusedArea;
								allOtherDetails1[3] = allOtherDetails1[3] + curFieldCropsArea;
								allOtherDetails1[4] = allOtherDetails1[4] + curCropsArea;
							}
						}
					}
					else{
						//alert(i + ' - ' + farms[i].farm_id);
						if(farms[i].ownership){
							curState = farms[i].ownership;
							if (curState === '1') {
								allOwnership2 = allOwnership2 + 1;
								
								allOwnershipDetails2[0] = allOwnershipDetails2[0] + curReclamedArea;
								allOwnershipDetails2[1] = allOwnershipDetails2[1] + curUrbanArea;
								allOwnershipDetails2[2] = allOwnershipDetails2[2] + curUnusedArea;
								allOwnershipDetails2[3] = allOwnershipDetails2[3] + curFieldCropsArea;
								allOwnershipDetails2[4] = allOwnershipDetails2[4] + curCropsArea;
							}
							if (curState === '2') {
								allRent2 = allRent2 + 1;
								
								allRentDetails2[0] = allRentDetails2[0] + curReclamedArea;
								allRentDetails2[1] = allRentDetails2[1] + curUrbanArea;
								allRentDetails2[2] = allRentDetails2[2] + curUnusedArea;
								allRentDetails2[3] = allRentDetails2[3] + curFieldCropsArea;
								allRentDetails2[4] = allRentDetails2[4] + curCropsArea;
							}
							if (curState === '3') {
								allHand2 = allHand2 + 1;
								
								allHandDetails2[0] = allHandDetails2[0] + curReclamedArea;
								allHandDetails2[1] = allHandDetails2[1] + curUrbanArea;
								allHandDetails2[2] = allHandDetails2[2] + curUnusedArea;
								allHandDetails2[3] = allHandDetails2[3] + curFieldCropsArea;
								allHandDetails2[4] = allHandDetails2[4] + curCropsArea;
							}
							if (curState === '4') {
								allOther2 = allOther2 + 1;
								
								allOtherDetails2[0] = allOtherDetails2[0] + curReclamedArea;
								allOtherDetails2[1] = allOtherDetails2[1] + curUrbanArea;
								allOtherDetails2[2] = allOtherDetails2[2] + curUnusedArea;
								allOtherDetails2[3] = allOtherDetails2[3] + curFieldCropsArea;
								allOtherDetails2[4] = allOtherDetails2[4] + curCropsArea;
							}
						}
					}
				}
			}
		}

		//Pie Chart Code
		google.charts.load('current', {
			'packages' : [ 'corechart' ]
		});
		google.charts.setOnLoadCallback(drawChart1);
		google.charts.setOnLoadCallback(drawChart2);
		google.charts.setOnLoadCallback(drawChart3);
		google.charts.setOnLoadCallback(drawChart4);

		function drawChart1() {
			
			data1 = google.visualization.arrayToDataTable([
					[ 'Type', 'Ratio' ],
					[ 'أراضي مستصلحة', allOwnershipDetails1[0] ],
					[ 'مباني', allOwnershipDetails1[1] ],
					[ 'أراضي غير مستغلة', allOwnershipDetails1[2] ],
					[ 'محاصيل حقلية', allOwnershipDetails1[3] ],
					[ 'محاصيل بستانية', allOwnershipDetails1[4] ] ]);

			options1 = {
				titleTextStyle : {
					color : '#0000FF',
					fontName : 'arial',
					fontSize : 50,
					bold : true,
					italic : true,
				},
				tooltip : {
					text : 'both',
					fontName : 'arial',
					fontSize : 50,
					bold : true,
					italic : true,
					isHtml : false
				},
				pieSliceTextStyle: {
					fontName: 'arial', 
					fontSize: 16
				},
				legend : {
					maxLines: 3,
					position : 'top',
					textStyle : {
						color : 'blue',
						fontSize : 16
					},
					alignment : 'center'
				},
				backgroundColor : "#aaffaa",
				//reverseCategories: true,
				pieStartAngle : 0
			};

			chart1 = new google.visualization.PieChart(document
					.getElementById('piechart1'));

			function selectHandler() {
				var selectedItem = chart1.getSelection()[0];
				if (selectedItem) {
					var value1 = data1.getValue(selectedItem.row, 0);
					var value2 = data1.getValue(selectedItem.row, 1);
				}
			}
			google.visualization.events.addListener(chart1, 'select',
					selectHandler);
			chart1.draw(data1, options1);
		}
		
		//================================
		
		function drawChart2() {
			
			data2 = google.visualization.arrayToDataTable([
					[ 'Type', 'Ratio' ],
					[ 'أراضي مستصلحة', allOwnershipDetails2[0] ],
					[ 'مباني', allOwnershipDetails2[1] ],
					[ 'أراضي غير مستغلة', allOwnershipDetails2[2] ],
					[ 'محاصيل حقلية', allOwnershipDetails2[3] ],
					[ 'محاصيل بستانية', allOwnershipDetails2[4] ] ]);

			options2 = {
				titleTextStyle : {
					color : '#0000FF',
					fontName : 'arial',
					fontSize : 50,
					bold : true,
					italic : true,
				},
				tooltip : {
					text : 'both',
					fontName : 'arial',
					fontSize : 50,
					bold : true,
					italic : true,
					isHtml : false
				},
				pieSliceTextStyle: {
					fontName: 'arial', 
					fontSize: 16
				},
				legend : {
					maxLines: 3,
					position : 'top',
					textStyle : {
						color : 'blue',
						fontSize : 16
					},
					alignment : 'center'
				},
				backgroundColor : "#aaffaa",
				//reverseCategories: true,
				pieStartAngle : 0
			};

			chart2 = new google.visualization.PieChart(document
					.getElementById('piechart2'));

			function selectHandler() {
				var selectedItem = chart2.getSelection()[0];
				if (selectedItem) {
					var value1 = data2.getValue(selectedItem.row, 0);
					var value2 = data2.getValue(selectedItem.row, 1);
					//alert(value1 + ' - ' + value2);
				}
			}
			google.visualization.events.addListener(chart2, 'select',
					selectHandler);
			chart2.draw(data2, options2);
		}
		//----------------------------------------------------------------------------------------
		function drawChart3() {
			
			var data3 = google.visualization.arrayToDataTable([
					[ 'Type', 'Ratio' ],
					[ 'تمليك', allOwnership1 ],
					[ 'إيجار', allRent1 ],
					[ 'وضع يد', allHand1 ],
					[ 'أخري', allOther1 ]]);

			options3 = {
				titleTextStyle : {
					color : '#0000FF',
					fontName : 'arial',
					fontSize : 50,
					bold : true,
					italic : true,
				},
				tooltip : {
					text : 'both',
					fontName : 'arial',
					fontSize : 50,
					bold : true,
					italic : true,
					isHtml : false
				},
				pieSliceText: 'label',
				pieSliceTextStyle: {
					fontName: 'arial', 
					fontSize: 16
				},
				legend : {
					maxLines: 3,
					position : 'top',
					textStyle : {
						color : 'blue',
						fontSize : 16
					},
					alignment : 'center'
				},
				backgroundColor : "#aaffaa",
				//reverseCategories: true,
				pieStartAngle : 0
			};

			var chart3 = new google.visualization.PieChart(document
					.getElementById('piechart3'));

			function selectHandler() {
				
				var selectedItem = chart3.getSelection()[0];
				if (selectedItem) {
					var value1 = data3.getValue(selectedItem.row, 0);
					var value2 = data3.getValue(selectedItem.row, 1);
					if(value1 === 'تمليك') {
						document.getElementById('details1').textContent = 'تمليك';
						data1 = google.visualization.arrayToDataTable([
							[ 'Type', 'Ratio' ],
							[ 'أراضي مستصلحة', allOwnershipDetails1[0] ],
							[ 'مباني', allOwnershipDetails1[1] ],
							[ 'أراضي غير مستغلة', allOwnershipDetails1[2] ],
							[ 'محاصيل حقلية', allOwnershipDetails1[3] ],
							[ 'محاصيل بستانية', allOwnershipDetails1[4] ] ]);
					}
					else if(value1 === 'إيجار') {
						document.getElementById('details1').textContent = 'إيجار';
						data1 = google.visualization.arrayToDataTable([
							[ 'Type', 'Ratio' ],
							[ 'أراضي مستصلحة', allRentDetails1[0] ],
							[ 'مباني', allRentDetails1[1] ],
							[ 'أراضي غير مستغلة', allRentDetails1[2] ],
							[ 'محاصيل حقلية', allRentDetails1[3] ],
							[ 'محاصيل بستانية', allRentDetails1[4] ] ]);
					}
					else if(value1 === 'وضع يد') {
						document.getElementById('details1').textContent = 'وضع يد';
						data1 = google.visualization.arrayToDataTable([
							[ 'Type', 'Ratio' ],
							[ 'أراضي مستصلحة', allHandDetails1[0] ],
							[ 'مباني', allHandDetails1[1] ],
							[ 'أراضي غير مستغلة', allHandDetails1[2] ],
							[ 'محاصيل حقلية', allHandDetails1[3] ],
							[ 'محاصيل بستانية', allHandDetails1[4] ] ]);
					}
					else {
						document.getElementById('details1').textContent = 'أخري';
						data1 = google.visualization.arrayToDataTable([
							[ 'Type', 'Ratio' ],
							[ 'أراضي مستصلحة', allOtherDetails1[0] ],
							[ 'مباني', allOtherDetails1[1] ],
							[ 'أراضي غير مستغلة', allOtherDetails1[2] ],
							[ 'محاصيل حقلية', allOtherDetails1[3] ],
							[ 'محاصيل بستانية', allOtherDetails1[4] ] ]);
					}
					
					chart1.draw(data1, options1);
				}
			}
			google.visualization.events.addListener(chart3, 'select',
					selectHandler);
			chart3.draw(data3, options3);
		}
		
		//================================
		
		function drawChart4() {
			
			var data4 = google.visualization.arrayToDataTable([
				[ 'Type', 'Ratio' ],
				[ 'تمليك', allOwnership2 ],
				[ 'إيجار', allRent2 ],
				[ 'وضع يد', allHand2 ],
				[ 'أخري', allOther2 ]]);

			options4 = {
				titleTextStyle : {
					color : '#0000FF',
					fontName : 'arial',
					fontSize : 50,
					bold : true,
					italic : true,
				},
				tooltip : {
					text : 'both',
					fontName : 'arial',
					fontSize : 50,
					bold : true,
					italic : true,
					isHtml : false
				},
				pieSliceText: 'label',
				pieSliceTextStyle: {
					fontName: 'arial', 
					fontSize: 16
				},
				legend : {
					maxLines: 3,
					position : 'top',
					textStyle : {
						color : 'blue',
						fontSize : 16
					},
					alignment : 'center'
				},
				backgroundColor : "#aaffaa",
				//reverseCategories: true,
				pieStartAngle : 0
			};

			var chart4 = new google.visualization.PieChart(document
					.getElementById('piechart4'));

			function selectHandler() {
				var selectedItem = chart4.getSelection()[0];
				if (selectedItem) {
					var value1 = data4.getValue(selectedItem.row, 0);
					var value2 = data4.getValue(selectedItem.row, 1);
					if(value1 === 'تمليك') {
						document.getElementById('details2').textContent = 'تمليك';
						//options4['slices'] = {  1: {offset: 0.2}, 2: {offset: 0.0}, 3: {offset: 0.0}, 4: {offset: 0.0} };
						data2 = google.visualization.arrayToDataTable([
							[ 'Type', 'Ratio' ],
							[ 'أراضي مستصلحة', allOwnershipDetails2[0] ],
							[ 'مباني', allOwnershipDetails2[1] ],
							[ 'أراضي غير مستغلة', allOwnershipDetails2[2] ],
							[ 'محاصيل حقلية', allOwnershipDetails2[3] ],
							[ 'محاصيل بستانية', allOwnershipDetails2[4] ] ]);
					}
					else if(value1 === 'إيجار') {
						document.getElementById('details2').textContent = 'إيجار';
						//options4['slices'] = {  1: {offset: 0.0}, 2: {offset: 0.2}, 3: {offset: 0.0}, 4: {offset: 0.0} };
						data2 = google.visualization.arrayToDataTable([
							[ 'Type', 'Ratio' ],
							[ 'أراضي مستصلحة', allRentDetails2[0] ],
							[ 'مباني', allRentDetails2[1] ],
							[ 'أراضي غير مستغلة', allRentDetails2[2] ],
							[ 'محاصيل حقلية', allRentDetails2[3] ],
							[ 'محاصيل بستانية', allRentDetails2[4] ] ]);
					}
					else if(value1 === 'وضع يد') {
						document.getElementById('details2').textContent = 'وضع يد';
						//options4['slices'] = {  1: {offset: 0.0}, 2: {offset: 0.0}, 3: {offset: 0.2}, 4: {offset: 0.0} };
						data2 = google.visualization.arrayToDataTable([
							[ 'Type', 'Ratio' ],
							[ 'أراضي مستصلحة', allHandDetails2[0] ],
							[ 'مباني', allHandDetails2[1] ],
							[ 'أراضي غير مستغلة', allHandDetails2[2] ],
							[ 'محاصيل حقلية', allHandDetails2[3] ],
							[ 'محاصيل بستانية', allHandDetails2[4] ] ]);
					}
					else {
						document.getElementById('details2').textContent = 'أخري';
						//options4['slices'] = {  1: {offset: 0.0}, 2: {offset: 0.0}, 3: {offset: 0.0}, 4: {offset: 0.2} };
						data2 = google.visualization.arrayToDataTable([
							[ 'Type', 'Ratio' ],
							[ 'أراضي مستصلحة', allOtherDetails2[0] ],
							[ 'مباني', allOtherDetails2[1] ],
							[ 'أراضي غير مستغلة', allOtherDetails2[2] ],
							[ 'محاصيل حقلية', allOtherDetails2[3] ],
							[ 'محاصيل بستانية', allOtherDetails2[4] ] ]);
					}
					
					chart2.draw(data2, options2);
				}
			}
			google.visualization.events.addListener(chart4, 'select',
					selectHandler);
			chart4.draw(data4, options4);
		}
	//----------------------------------------------------------------------------------------
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
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<br><br><br><br><br><br><br>
	<!-- Footer -->
	<div class="copyright">
		<p class="copyrighttext">
			Copyright © 2018, <a href="http://www.narss.sci.eg">NARSS</a>
		</p>
	</div>
</body>
</html>