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
				<a href='javascript:void(0);' onclick='voucher_add(id);' class='btnsearch' id='myvoucher'>إضافة
					إيصال</a>
				<br>
				<br>

				<div align="center" id='voucher_list'></div>

			</div>

			<br> <br> <br>
		</div>
	</div>
	<script>
		window.onload = function() {
			voucherjson = '${vouchers}';
			var num_of_voucher = 0;
			if (voucherjson) {
				var vouchers = JSON.parse(voucherjson);
				var voucher_notes = "";
				var voucher_amount = "";
				var voucher_feesStatus = "";
				var voucher_voucherDate = "";
				var voucher_paymentStatus = "";
				var voucher_issuingDocument = "";
				var voucher_issuingDocumentSection = "";
				var voucher_issuingDocumentNo = "";
				
				
				var voucher_header = '<table border=\"0\" align=\"center\"><tr>'
					+'<th class=\"resultth\">إعدادات</th>'
					+'<th class=\"resultth\">رقم الوثيقة</th>'
					+'<th class=\"resultth\">الفرع</th>'
					+'<th class=\"resultth\">جهة إصدار الوثيقة</th>'
					+'<th class=\"resultth\">تم الدفع</th>'
					+'<th class=\"resultth\">ملاحظات</th>'
					+'<th class=\"resultth\">المبلغ</th>'
					+'<th class=\"resultth\">الرسوم</th>'
					+'<th class=\"resultth\">التاريخ</th>'
					+'</tr>';
				var voucher_list_html = "";
				//alert("Voucher ID: " + voucher.voucherID);
				//alert("Gov: " + voucher.gov);
				
				for ( var i in vouchers) {

					num_of_voucher = num_of_voucher + 1;
					
					if (vouchers[i].voucherID) {
						document.getElementById("vm_voucher_ID").value = vouchers[i].voucherID;
					} else {
						document.getElementById("vm_voucher_ID").value = "غير متوفر";
					}
	
					if (vouchers[i].gov) {
						document.getElementById("vm_gov").value = vouchers[i].gov;
					} else {
						document.getElementById("vm_gov").value = "غير متوفر";
					}
	
					if (vouchers[i].site) {
						document.getElementById("vm_site").value = vouchers[i].site;
					} else {
						document.getElementById("vm_site").value = "غير متوفر";
					}
	
					if (vouchers[i].personID) {
						document.getElementById("vm_person_ID").value = vouchers[i].personID;
					} else {
						document.getElementById("vm_person_ID").value = "غير متوفر";
					}
	
					if (vouchers[i].personName) {
						document.getElementById("vm_Person_Name").value = vouchers[i].personName;
					} else {
						document.getElementById("vm_Person_Name").value = "غير متوفر";
					}
					
					if (vouchers[i].notes) {
						voucher_notes = vouchers[i].notes;
					} else {
						voucher_notes = "غير متوفر";
					}
					
					if (vouchers[i].amount) {
						voucher_amount = vouchers[i].amount;
					} else {
						voucher_amount = "غير متوفر";
					}
					
					if (vouchers[i].feesStatus) {
						voucher_feesStatus = vouchers[i].feesStatus;
					} else {
						voucher_feesStatus = "غير متوفر";
					}
					
					if (vouchers[i].voucherDate) {
						voucher_voucherDate = vouchers[i].voucherDate;
					} else {
						voucher_voucherDate = "غير متوفر";
					}
					
					if (vouchers[i].paymentStatus) {
						voucher_paymentStatus = vouchers[i].paymentStatus;
					} else {
						voucher_paymentStatus = "غير متوفر";
					}
					
					if (vouchers[i].issuingDocument) {
						voucher_issuingDocument = vouchers[i].issuingDocument;
					} else {
						voucher_issuingDocument = "غير متوفر";
					}
					
					if (vouchers[i].issuingDocumentSection) {
						voucher_issuingDocumentSection = vouchers[i].issuingDocumentSection;
					} else {
						voucher_issuingDocumentSection = "غير متوفر";
					}
					
					if (vouchers[i].issuingDocumentNo) {
						voucher_issuingDocumentNo = vouchers[i].issuingDocumentNo;
					} else {
						voucher_issuingDocumentNo = "غير متوفر";
					}
									
					voucher_list_html = voucher_list_html + '<tr class=\"resulttr\">'
						+ '<td align=\"right\">'
						+ '<button onclick=\"voucher_delete('
						+ vouchers[i].voucherID
						+ ')\" class=\"btnsearch\" id=\"voucher_delete\">حذف</button>'
						+ '<button onclick=\"voucher_edit('
						+ vouchers[i].voucherID
						+ ')\" class=\"btnsearch\" id=\"voucher_edit\">تعديل</button>'
						+ '</td>'
						+ '<td>' + voucher_issuingDocumentNo + '</td>'
						+ '<td>' + voucher_issuingDocumentSection + '</td>'
						+ '<td>' + voucher_issuingDocument + '</td>'
						+ '<td>' + voucher_paymentStatus + '</td>'
						+ '<td align=\"right\">' + voucher_notes + '</td>' 
						+ '<td align=\"right\">' + voucher_amount + '</td>' 
						+ '<td align=\"right\">' + voucher_feesStatus + '</td>' 
						+ '<td>' + voucher_voucherDate + '</td>'
						+ '</tr>';
					   
				}
				voucher_list_html = voucher_header + voucher_list_html + "</table>";
				
			}
			if(num_of_voucher > 0)
				{
					document.getElementById('voucher_list').innerHTML = voucher_list_html;
				}
			else
				{
					document.getElementById('voucher_list').innerHTML = '<div align=\"center\"><h3>عفوا ، لا توجد ايصالات</h3></div>';
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