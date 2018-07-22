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

			<h1 class="formheader" align="center">طلب إجراءات
				التقنين_المعاينة/الفحص</h1>
			<div align="center">

				<table border="0" align="center">
					<tr>
						<td align="right"><input class="readonly-box" type="text"
							id="vm_gov" value="" readonly></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;">المحافظة</td>

						<td align="right"><input class="readonly-box" type="text"
							id="vm_voucher_ID" value="" readonly></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;">رقم الطلب</td>

					</tr>
					<tr>
						<td align="right"><input class="readonly-box" type="text"
							id="vm_person_ID" value="" readonly></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;">الرقم القومى</td>

						<td align="right"><input class="readonly-box" type="text"
							id="vm_site" value="" readonly></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;">الموقع</td>
					</tr>
					<tr>
						<td align="right"><p></p></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;"><p></p></td>
						<td align="right"><input class="readonly-box" type="text"
							id="vm_Person_Name" value="" readonly></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;">مقدم الطلب</td>

					</tr>

				</table>
				<br>
				<br>
				<button onclick="voucher_add(id)" class="btnsearch" id="voucher_add">إضافة
					إيصال</button>
				<br>
				<br>

				<div align="center">
					<table border="0" align="center">
						<tr>
							<th class="resultth">إعدادات</th>
							<th class="resultth">ملاحظات</th>
							<th class="resultth">المبلغ</th>
							<th class="resultth">الرسوم</th>
							<th class="resultth">التاريخ</th>
						</tr>
						<tr class="resulttr">
							<td align="right">
								<button onclick="voucher_delete(id)" class="btnsearch"
									id="voucher_remove">حذف</button>
								<button onclick="voucher_edit(id)" class="btnsearch"
									id="voucher_modify">تعديل</button>
							</td>
							<td align="right">Notes</td>
							<td align="right">Fees Value</td>
							<td align="right">Fees Type</td>
							<td>Date</td>
						</tr>
						<tr class="resulttr">
							<td align="right">
								<button onclick="voucher_delete(id)" class="btnsearch"
									id="voucher_remove">حذف</button>
								<button onclick="voucher_edit(id)" class="btnsearch"
									id="voucher_modify">تعديل</button>
							</td>
							<td align="right">Notes2</td>
							<td align="right">Fees Value2</td>
							<td align="right">Fees Type2</td>
							<td>Date2</td>
						</tr>
					</table>
				</div>


			</div>

			<div align="center" style="visibility: hidden">
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


			<div id="voucherResults"></div>
			<br> <br> <br>
		</div>
	</div>
	<script>
		window.onload = function() {
			voucherjson = '${voucher}';
			if (voucherjson) {
				var voucher = JSON.parse(voucherjson);
				//alert("Voucher ID: " + voucher.voucherID);
				//alert("Gov: " + voucher.gov);

				if (voucher.voucherID) {
					document.getElementById("vm_voucher_ID").value = voucher.voucherID;
				} else {
					document.getElementById("vm_voucher_ID").value = "غير متوفر";
				}

				if (voucher.gov) {
					document.getElementById("vm_gov").value = voucher.gov;
				} else {
					document.getElementById("vm_gov").value = "غير متوفر";
				}

				if (voucher.site) {
					document.getElementById("vm_site").value = voucher.site;
				} else {
					document.getElementById("vm_site").value = "غير متوفر";
				}

				if (voucher.personID) {
					document.getElementById("vm_person_ID").value = voucher.personID;
				} else {
					document.getElementById("vm_person_ID").value = "غير متوفر";
				}

				if (voucher.personName) {
					document.getElementById("vm_person_Name").value = voucher.personName;
				} else {
					document.getElementById("vm_person_Name").value = "غير متوفر";
				}

			}
		}

		function voucherBox() {
			alert("I am in voucherBox function");
			// Get the modal
			var modal = document.getElementById('voucherModal');

			// Get the button that opens the modal
			var btn = document.getElementById("myvoucher");

			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("voucherClose")[0];

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

		function voucher_delete(id) {
			//voucher.voucherID;
			alert("inside voucher delete process");
		}

		function voucher_edit(id) {
			//voucher.voucherID;
			alert("inside voucher edit process");
		}

		function voucher_add(id) {
			//voucher.voucherID;
			alert("inside voucher add process");
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