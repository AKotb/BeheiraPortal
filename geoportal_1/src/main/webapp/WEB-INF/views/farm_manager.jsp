<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>المزارع والشركات</title>
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
		<p class='cur_title'>بحث عن قطعة أرض</p>
		<img src="resources/css/css/css/css/images/projectname.png"
			alt="project name" class="projectname">
	</div>
	<div class="extra_noheight">
		<div id="searchForm" class="modal-content" align="center">

			<!-- <h1 class="formheader" align="center">بحث عن قطعة أرض</h1> -->

			<table border="0" style="dir: rtl;">
				<tr>
					<td align="right"><input class="input-box" type="text"
						id="farm_name" value=""></td>
					<td align="right" style="color: #3d6266;">اسم المزرعة / الشركة</td>
				</tr>
				<tr>
					<td align="right"><select id="ownership_status" size="1"
						style="width: 80px;">
							<option value=''>اختر</option>
							<option value='1'>تمليك</option>
							<option value='2'>ايجار</option>
							<option value='3'>وضع اليد</option>
					</select></td>
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

			<h2 align="center">
				<button onclick="searchAction()" class="button btnsearch"
					id="searchBtn">بحث</button>
			</h2>

		</div>

		<div id="editFarm" class="modal-content" align="center">

			<h1 class="formheader" align="center">تعديل بيانات المزرعة</h1>
			<table border="0" align="center">
				<tr>
					<td align="right"><input class="input-box" type="text"
						id="farmid" readonly></td>
					<td align="right" style="color: #396266;">كود المزرعة</td>
				</tr>
				<tr>
					<td align="right"><input class="input-box" type="text"
						id="farmname"></td>
					<td align="right" style="color: #396266;">اسم المزرعة</td>
				</tr>
				<tr>
					<td align="right"><select id="ownership" size="1"
						style="width: 80px;">
							<option value=''>اختر</option>
							<option value='1'>تمليك</option>
							<option value='2'>ايجار</option>
							<option value='3'>وضع اليد</option>
					</select></td>
					<td align="right" style="color: #3d6266;">نوع الحيازة</td>
				</tr>
				<tr>
					<td align="right"><input class="input-box" type="text"
						id="ownername"></td>
					<td align="right" style="color: #396266;">اسم المالك</td>
				</tr>
				<tr>
					<td align="right"><input class="input-box" type="text"
						id="ownerid"></td>
					<td align="right" style="color: #396266;">الرقم القومي</td>
				</tr>
				<tr>
					<td align="right"><input class="input-box" type="text"
						id="ownertel"></td>
					<td align="right" style="color: #396266;">التليفون</td>
				</tr>
			</table>
			<br> <br>
			<h2 align="center">
				<button onclick="cancel()" class="btnsearch" id="cancelBtn">الغاء</button>
				<button onclick="editFarmAction()" class="btnsearch" id="saveBtn">حفظ</button>
			</h2>
		</div>

		<div id="searchResults"></div>
	</div>
	<script>
		window.onload = function() {
			document.getElementById("searchResults").style.display = "block";
			document.getElementById("searchForm").style.display = "block";
			document.getElementById("editFarm").style.display = "none";
			farmsjson = '${farms}';
			var num_of_items = 0;
			var results = "";
			if (farmsjson) {
				var farms = JSON.parse(farmsjson);
				var farmid = "";
				var farmname = "";
				var ownerid = "";
				var ownername = "";
				var ownertel = "";
				var ownership = "";
				var displayedownership = "";
				for ( var i in farms) {
					num_of_items = num_of_items + 1;
					if (farms[i].farmID) {
						farmid = farms[i].farmID;
					} else {
						farmid = "غير متوفر";
					}
					if (farms[i].farmName) {
						farmname = farms[i].farmName;
					} else {
						farmname = "غير متوفر";
					}

					if (farms[i].ownerID) {
						ownerid = farms[i].ownerID;
					} else {
						ownerid = "غير متوفر";
					}

					if (farms[i].ownerName) {
						ownername = farms[i].ownerName;
					} else {
						ownername = "غير متوفر";
					}

					if (farms[i].telephone) {
						ownertel = farms[i].telephone;
					} else {
						ownertel = "غير متوفر";
					}

					if (farms[i].ownership) {
						ownership = farms[i].ownership;
						if(ownership === '1'){
							displayedownership = "تمليك";
						}
						if(ownership === '2'){
							displayedownership = "إيجار";
						}
						if(ownership === '3'){
							displayedownership = "وضع اليد";
						}
						if(ownership === ''){
							displayedownership = "غير متوفر";
						}
						if(ownership === 'غير متوفر'){
							displayedownership = "غير متوفر";
						}
					} else {
						ownership = "غير متوفر";
						displayedownership = "غير متوفر";
					}

					results = results
							+ '<tr class=\"resulttr\">'
							+ '<td align=\"center\" style=\"width:20%;\">'
							+ '<button onclick=\"editfarmdata(\''
							+ farmid
							+ '_'
							+ farmname
							+ '_'
							+ ownername
							+ '_'
							+ ownerid
							+ '_'
							+ ownertel
							+ '_'
							+ ownership
							+ '\')\" class=\"button\" id=\"editselectedfarmBtn\">تعديل</button>'
							+ '<button onclick=\"showSearchResults('
							+ farmid
							+ ')\" class=\"button\" id=\"showSearchResultsBtn\">عرض على الخريطة</button>'
							+ '</td>' + '<td align=\"right\" style=\"width:5%;\">' + displayedownership
							+ '</td>' + '<td align=\"right\" style=\"width:40%;\"><div style=\"word-break:break-all;\">' + ownername
							+ '</div></td>' + '<td align=\"right\" style=\"width:30%;\"><div style=\"word-break:break-all;\">' + farmname
							+ '</div></td>' + '<td style=\"width:5%;\">' + farmid + '</td>' + '</tr>';
				}

			}
			if (num_of_items > 0) {
				var search_header = '<div align=\"center\"><h3 align=\"center\">تم إيجاد '
						+ num_of_items
						+ ' من نتائج البحث </h3><br><table border=\"0\" align=\"center\" style=\"width:90%;\">'
						+ '<tr>'
						+ '<th class=\"resultth\">إعدادات</th>'
						+ '<th class=\"resultth\"> نوع الحيازة </th>'
						+ '<th class=\"resultth\">اسم المالك / واضع اليد</th>'
						+ '<th class=\"resultth\">اسم المزرعة / الشركة</th>'
						+ '<th class=\"resultth\"> كود المزرعة </th>' + '</tr>';

				results = search_header + results
						+ '</table></div><br><br><br><br><br><br><br><br>';
				document.getElementById('searchResults').innerHTML = results;
			} else {
				document.getElementById('searchResults').innerHTML = '<div align=\"center\"><h3>عفوا ، لا توجد نتائج</h3></div>';
			}
		}

		function searchAction() {
			var search_owner = document.getElementById('owner').value;
			var search_farm_name = document.getElementById('farm_name').value;
			var search_sid = document.getElementById('sid').value;
			var search_phone = document.getElementById('phone').value;
			var search_ownership_status = document
					.getElementById('ownership_status').value;
			var params = [ search_farm_name, search_sid, search_owner,
					search_phone, search_ownership_status ];
			var location = "<c:url value='getallfarms'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", params);
			window.location.href = location;

			/* readTextFile(
					'https://raw.githubusercontent.com/AKotb/BeheiraPortal/master/geoportal_1/src/main/resources/json/home/db.json',
					function(text) {
					}); */
		}

		/* function readTextFile(file, callback) {
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

					if (mydata.features[val].properties.Farm_Owner
							&& search_owner.length > 0)
						cond1 = mydata.features[val].properties.Farm_Owner
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
					if (mydata.features[val].properties.Tel
							&& search_phone.length > 0)
						cond5 = mydata.features[val].properties.Tel
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
						
						if (mydata.features[val].properties.Owner_ID) {
							My_Farm_OwnerID = mydata.features[val].properties.Owner_ID;
						} else {
							My_Farm_OwnerID = "غير متوفر";
						}
						
						num_of_items = num_of_items + 1;
						results = results
								+ '<tr class=\"resulttr\">'
								+ '<td align=\"right\">'
								+ '<button onclick=\"editfarmdata(\''+val+'_'+My_Farm_Name+'_'+My_Farm_Owner
								+ '\')\" class=\"button\" id=\"editselectedfarmBtn\">تعديل</button>'
								+ '<button onclick=\"showSearchResults('
								+ val
								+ ')\" class=\"button\" id=\"showSearchResultsBtn\">عرض على الخريطة</button>'
								+ '</td>' + '<td align=\"right\">'
								+ My_Farm_OwnerID
								+ '</td>' + '<td align=\"right\">'
								+ My_Farm_Owner + '</td>'
								+ '<td align=\"right\">' + My_Farm_Name
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
							+ '<th class=\"resultth\"> الرقم القومي </th>'
							+ '<th class=\"resultth\">اسم المالك / واضع اليد</th>'
							+ '<th class=\"resultth\">اسم المزرعة / الشركة</th>'
							+ '<th class=\"resultth\"> كود المزرعة </th>' + '</tr>';
					results = search_header
							+ results
							+ '</table></div><br><br><br><br><br><br><br><br>';
					document.getElementById('searchResults').innerHTML = results;
				} else
					document.getElementById('searchResults').innerHTML = '<div align=\"center\"><h3>عفوا ، لا توجد نتائج</h3></div>';

			}
		}
		rawFile.send(null);
		} */

		function showSearchResults(id) {
			var params = [ id, '30.2519715', '30.2761235' ];
			var location = "<c:url value='showonmap'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", params);
			window.location.href = location;
		}

		function editfarmdata(selectedfarmdata) {
			document.getElementById("editFarm").style.display = "block";
			document.getElementById("searchResults").style.display = "none";
			document.getElementById("searchForm").style.display = "none";
			var res = selectedfarmdata.split("_");
			farmid = res[0];
			if (farmid) {
				document.getElementById("farmid").value = farmid;
			} else {
				document.getElementById("farmid").value = "غير متوفر";
			}
			farmname = res[1];
			if (farmname) {
				document.getElementById("farmname").value = farmname;
			} else {
				document.getElementById("farmname").value = "غير متوفر";
			}
			ownername = res[2];
			if (ownername) {
				document.getElementById("ownername").value = ownername;
			} else {
				document.getElementById("ownername").value = "غير متوفر";
			}
			ownerid = res[3];
			if (ownerid) {
				document.getElementById("ownerid").value = ownerid;
			} else {
				document.getElementById("ownerid").value = "غير متوفر";
			}
			ownertel = res[4];
			if (ownertel) {
				document.getElementById("ownertel").value = ownertel;
			} else {
				document.getElementById("ownertel").value = "غير متوفر";
			}
			ownership = res[5];
			if (ownership) {
				document.getElementById("ownership").value = ownership;
			} else {
				document.getElementById("ownership").value = "غير متوفر";
			}
		}

		function editFarmAction() {
			document.getElementById("searchResults").style.display = "block";
			document.getElementById("searchForm").style.display = "block";
			document.getElementById("editFarm").style.display = "none";
			farmid = document.getElementById("farmid").value;
			farmname = document.getElementById("farmname").value;
			ownername = document.getElementById("ownername").value;
			ownerid = document.getElementById("ownerid").value;
			ownertel = document.getElementById("ownertel").value;
			ownership = document.getElementById("ownership").value;
			var params = [ farmid, farmname, ownername, ownerid, ownertel,
					ownership ];
			var location = "<c:url value='editfarmdata'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", params);
			window.location.href = location;
		}

		function cancel() {
			document.getElementById("searchResults").style.display = "block";
			document.getElementById("searchForm").style.display = "block";
			document.getElementById("editFarm").style.display = "none";
		}
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