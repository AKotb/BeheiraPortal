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

			<div align="center">
				<h1 class="formheader" align="center">طلب تحصيل</h1>

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
						<td align="right"><input type="checkbox" id="Payment_Status"
							value="no"></td>
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

				<h2 align="center">
					<button onclick="voucherPrint()" class="btnsearch" id="voucherBtn">طباعة</button>
					<button onclick="voucherAction()" class="btnsearch" id="voucherBtn">تحصيل</button>
				</h2>

			</div>

			<br> <br> <br>
		</div>
	</div>
	<script>
		window.onload = function() {
			voucherjson = '${voucher}';
			if (voucherjson) {
				var voucher = JSON.parse(voucherjson);

				if (voucher.voucherID) {
					document.getElementById("voucher_ID").value = voucher.voucherID;
				} else {
					document.getElementById("voucher_ID").value = "غير متوفر";
				}

				if (voucher.gov) {
					document.getElementById("gov").value = voucher.gov;
				} else {
					document.getElementById("gov").value = "غير متوفر";
				}

				if (voucher.site) {
					document.getElementById("site").value = voucher.site;
				} else {
					document.getElementById("site").value = "غير متوفر";
				}

				if (voucher.personID) {
					document.getElementById("person_ID").value = voucher.personID;
				} else {
					document.getElementById("person_ID").value = "غير متوفر";
				}

				if (voucher.personName) {
					document.getElementById("person_Name").value = voucher.personName;
				} else {
					document.getElementById("person_Name").value = "غير متوفر";
				}
				
				if (voucher.voucherID) {
					document.getElementById("voucher_Date").value = voucher.voucherID;
				} else {
					document.getElementById("voucher_Date").value = "غير متوفر";
				}

				if (voucher.personID) {
					document.getElementById("Fees_Status").value = voucher.personID;
				} else {
					document.getElementById("Fees_Status").value = "غير متوفر";
				}
				
				if (voucher.gov) {
					document.getElementById("Amount").value = voucher.gov;
				} else {
					document.getElementById("Amount").value = "غير متوفر";
				}

				if (voucher.site) {
					document.getElementById("Payment_Status").value = voucher.site;
				} else {
					document.getElementById("Payment_Status").value = "غير متوفر";
				}

				if (voucher.personID) {
					document.getElementById("Issuing_document").value = voucher.personID;
				} else {
					document.getElementById("Issuing_document").value = "غير متوفر";
				}

				if (voucher.personName) {
					document.getElementById("Issuing_document_section").value = voucher.personName;
				} else {
					document.getElementById("Issuing_document_section").value = "غير متوفر";
				}
				
				if (voucher.voucherID) {
					document.getElementById("Issuing_Date").value = voucher.voucherID;
				} else {
					document.getElementById("Issuing_Date").value = "غير متوفر";
				}

				if (voucher.gov) {
					document.getElementById("Issuing_document_No").value = voucher.gov;
				} else {
					document.getElementById("Issuing_document_No").value = "غير متوفر";
				}

				if (voucher.site) {
					document.getElementById("Notes").value = voucher.site;
				} else {
					document.getElementById("Notes").value = "غير متوفر";
				}

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