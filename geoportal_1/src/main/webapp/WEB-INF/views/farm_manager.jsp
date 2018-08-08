<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>تعديل بيانات المزرعة</title>
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

input.readonly-box {
	background-color: #dddddd; /* Green */
	color: #444444;
	font: bold 14px Arial;
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

.formheader {
	background-color: #3d6266;
	color: #fcbb5b;
	font: bold 40px Arial;
}
</style>
</head>

<body>
	<div class="container">
		<ul class="nav">
			<a id="mysearch" href="#"> <img
				src="resources/css/css/css/css/images/SEARCH.png" alt="SEARCH" /></a>
			<a href="#" id="myvoucher"><img
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
	<div id="extra">
		<div class="modal-content">

			<h1 class="formheader" align="center"> تعديل بيانات المزرعة </h1>
			<div align="center">
				<table border="0" align="center">
					<tr>
						<td align="right"><input class="readonly-box" type="text"
							id="farmname" value="" readonly></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;">اسم المزرعة</td>
					</tr>
					<tr>
						<td align="right"><input class="readonly-box" type="text"
							id="ownername" value="" readonly></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;">اسم المالك</td>
					</tr>
					<tr>
						<td align="right"><input class="readonly-box" type="text"
							id="ownerid" value="" readonly></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;">الرقم القومي</td>
					</tr>
					<tr>
						<td align="right"><input class="readonly-box" type="text"
							id="ownertel" value="" readonly></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;">التليفون</td>
					</tr>
				</table>
				<br><br> 
					<h2 align="center">
						<button onclick="cancel()" class="btnsearch" id="cancelBtn">الغاء</button>
						<button onclick="editFarmAction()" class="btnsearch" id="saveBtn">حفظ</button>
					</h2>
			</div>
		</div>
	</div>
	<script>
		farmjson = '${farm}';
		window.onload = function() {
			alert("Farm JSON: "+farmjson);
			if (farmjson) {
					farmname=farmjson.farmName;
					if (farmname) {
						document.getElementById("farmname").value = farmname;
					} else {
						document.getElementById("farmname").value = "غير متوفر";
					}
					ownername = farmjson.ownerName;
					if (ownername) {
						document.getElementById("ownername").value = ownername;
					} else {
						document.getElementById("ownername").value = "غير متوفر";
					}
					ownerid = farmjson.ownerID;
					if (ownerid) {
						document.getElementById("ownerid").value = fownerid;
					} else {
						document.getElementById("ownerid").value = "غير متوفر";
					}
					ownertel = farmjson.telephone;
					if (ownertel) {
						document.getElementById("ownertel").value = ownertel;
					} else {
						document.getElementById("ownertel").value = "غير متوفر";
					}
			}
		}
		
		function editFarmAction() {
			alert("Save Button Pressed");
			//var location = "<c:url value='addnewvoucher'><c:param name='params' value='paramsvalues'/></c:url>";
			//location = location.replace("paramsvalues", params);
			//window.location.href = location;
		}
		
		function cancel() {
			alert("Cancel Button Pressed");
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