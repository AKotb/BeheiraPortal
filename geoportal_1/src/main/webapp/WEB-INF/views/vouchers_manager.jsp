<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>الإجراءات</title>
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

			<a href="searchforfarms"><img
				src="resources/css/css/css/css/images/SEARCH.png" alt="SEARCH"></a>
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
							id="vm_farm_ID" value="" readonly></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;">رقم
							المزرعة</td>
					</tr>
					<tr>
						<td align="right"><input class="readonly-box" type="text"
							id="vm_person_ID" value="" readonly></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;">الرقم
							القومى</td>

						<td align="right"><input class="readonly-box" type="text"
							id="vm_site" value="" readonly></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;">الموقع</td>
					</tr>
					<tr>
						<td align="right"><p></p></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;"><p></p></td>
						<td align="right"><input class="readonly-box" type="text"
							id="vm_Person_Name" value="" readonly></td>
						<td align="right" style="color: #396266; font: bold 24px Arial;">مقدم
							الطلب</td>
					</tr>
				</table>
				<br> <br> <a href='javascript:void(0);'
					onclick='voucher_add(id);' class='btnsearch' id='myvoucher'>إضافة
					إيصال</a> <br> <br>

				<div align="center" id='voucher_list'></div>

				<div align="center" id="voucher_edit_form">
					<h1 id='form_header_edit' class="formheader" align="center">تعديل
						إيصال</h1>
					<input type="hidden" id="selectedvoucherid"
						name="selectedvoucherid">
					<table border="0" style="dir: rtl;">
						<tr>
							<td align="right"><input class="input-box" type="date"
								id="edit_voucher_Date" value=""></td>
							<td align="right" style="color: #3d6266;">تاريخ الطلب</td>
						</tr>
						<tr>
							<td align="right"><input class="input-box" type="text"
								id="edit_Fees_Status" value=""></td>
							<td align="right" style="color: #3d6266;">نوع الرسوم</td>
						</tr>
						<tr>
							<td align="right"><input class="input-box" type="text"
								id="edit_Amount" value=""></td>
							<td align="right" style="color: #3d6266;">المبلغ</td>
						</tr>
						<tr>
							<td align="right"><input type="checkbox"
								id="edit_Payment_Status" value="no"></td>
							<td align="right" style="color: #3d6266;">تم الدفع</td>
						</tr>
						<tr>
							<td align="right"><input class="input-box" type="text"
								id="edit_Issuing_document" value=""></td>
							<td align="right" style="color: #3d6266;">جهة إصدار الوثيقة</td>
						</tr>
						<tr>
							<td align="right"><input class="input-box" type="text"
								id="edit_Issuing_document_section" value=""></td>
							<td align="right" style="color: #3d6266;">الفرع</td>
						</tr>
						<tr>
							<td align="right"><input class="input-box" type="text"
								id="edit_Issuing_document_No" value=""></td>
							<td align="right" style="color: #3d6266;">رقم الوثيقة</td>
						</tr>
						<tr>
							<td align="right"><textarea class="voucherTA" rows="5"
									id="edit_Notes" value=""></textarea></td>
							<td align="right" style="color: #3d6266;">ملاحظات</td>
						</tr>
					</table>

					<h2 align="center">
						<button onclick="voucherPrint()" class="btnsearch" id="voucherBtn">طباعة</button>
						<button onclick="voucherAction(1)" class="btnsearch"
							id="voucherBtn">تعديل</button>
					</h2>

				</div>

				<div align="center" id="voucher_add_form">
					<h1 id='form_header_add' class="formheader" align="center">إضافة
						إيصال جديد</h1>

					<table border="0" style="dir: rtl;">
						<tr>
							<td align="right"><input class="input-box" type="date"
								id="add_voucher_Date" value=""></td>
							<td align="right" style="color: #3d6266;">تاريخ الطلب</td>
						</tr>
						<tr>
							<td align="right"><input class="input-box" type="text"
								id="add_Fees_Status" value=""></td>
							<td align="right" style="color: #3d6266;">نوع الرسوم</td>
						</tr>
						<tr>
							<td align="right"><input class="input-box" type="text"
								id="add_Amount" value=""></td>
							<td align="right" style="color: #3d6266;">المبلغ</td>
						</tr>
						<tr>
							<td align="right"><input type="checkbox"
								id="add_Payment_Status" value="no"></td>
							<td align="right" style="color: #3d6266;">تم الدفع</td>
						</tr>
						<tr>
							<td align="right"><input class="input-box" type="text"
								id="add_Issuing_document" value=""></td>
							<td align="right" style="color: #3d6266;">جهة إصدار الوثيقة</td>
						</tr>
						<tr>
							<td align="right"><input class="input-box" type="text"
								id="add_Issuing_document_section" value=""></td>
							<td align="right" style="color: #3d6266;">الفرع</td>
						</tr>
						<tr>
							<td align="right"><input class="input-box" type="text"
								id="add_Issuing_document_No" value=""></td>
							<td align="right" style="color: #3d6266;">رقم الوثيقة</td>
						</tr>
						<tr>
							<td align="right"><textarea class="voucherTA" rows="5"
									id="add_Notes" value=""></textarea></td>
							<td align="right" style="color: #3d6266;">ملاحظات</td>
						</tr>
					</table>

					<h2 align="center">
						<button onclick="voucherPrint()" class="btnsearch" id="voucherBtn">طباعة</button>
						<button onclick="voucherAction(2)" class="btnsearch"
							id="voucherBtn">إضافة</button>
					</h2>
				</div>
			</div>
		</div>
	</div>
	<script>
		window.onload = function() {
			voucherjson = '${vouchers}';
			var farmID;
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
						+ '<th class=\"resultth\">إعدادات</th>'
						+ '<th class=\"resultth\">رقم الوثيقة</th>'
						+ '<th class=\"resultth\">الفرع</th>'
						+ '<th class=\"resultth\">جهة إصدار الوثيقة</th>'
						+ '<th class=\"resultth\">تم الدفع</th>'
						+ '<th class=\"resultth\">ملاحظات</th>'
						+ '<th class=\"resultth\">المبلغ</th>'
						+ '<th class=\"resultth\">الرسوم</th>'
						+ '<th class=\"resultth\">التاريخ</th>' + '</tr>';
				var voucher_list_html = "";

				for ( var i in vouchers) {

					num_of_voucher = num_of_voucher + 1;
					farmID = vouchers[i].farmID;

					if (vouchers[i].farmID) {
						document.getElementById("vm_farm_ID").value = vouchers[i].farmID;
					} else {
						document.getElementById("vm_farm_ID").value = "غير متوفر";
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

					voucher_list_html = voucher_list_html
							+ '<tr class=\"resulttr\">'
							+ '<td align=\"right\">'
							+ '<button onclick=\"voucher_delete('
							+ vouchers[i].voucherID
							+ ')\" class=\"btnsearch\" id=\"voucher_delete\">حذف</button>'
							+ '<button onclick=\"voucher_edit('
							+ vouchers[i].voucherID
							+ ')\" class=\"btnsearch\" id=\"voucher_edit\">تعديل</button>'
							+ '</td>' + '<td>' + voucher_issuingDocumentNo
							+ '</td>' + '<td>' + voucher_issuingDocumentSection
							+ '</td>' + '<td>' + voucher_issuingDocument
							+ '</td>' + '<td>' + voucher_paymentStatus
							+ '</td>' + '<td align=\"right\">' + voucher_notes
							+ '</td>' + '<td align=\"right\">' + voucher_amount
							+ '</td>' + '<td align=\"right\">'
							+ voucher_feesStatus + '</td>' + '<td>'
							+ voucher_voucherDate + '</td>' + '</tr>';

				}
				voucher_list_html = voucher_header + voucher_list_html
						+ "</table>";

			}
			if (num_of_voucher > 0) {
				document.getElementById('voucher_list').innerHTML = voucher_list_html;
			} else {
				document.getElementById('voucher_list').innerHTML = '<div align=\"center\"><h3>عفوا ، لا توجد ايصالات</h3></div>';
			}

			//set visibility options
			document.getElementById("voucher_edit_form").style.visibility = "collapse";
			document.getElementById("voucher_add_form").style.visibility = "collapse";

		}

		function voucherAction(event) {
			if (event == 1) {
				var gov = document.getElementById('vm_gov').value;
				var site = document.getElementById('vm_site').value;
				var farm_ID = document.getElementById("vm_farm_ID").value;
				var person_ID = document.getElementById('vm_person_ID').value;
				var Person_Name = document.getElementById('vm_Person_Name').value;
				var voucher_Date = document.getElementById('edit_voucher_Date').value;
				var Fees_Status = document.getElementById('edit_Fees_Status').value;
				var Amount = document.getElementById('edit_Amount').value;
				var Payment_Status = document
						.getElementById('edit_Payment_Status').value;
				var Issuing_document = document
						.getElementById('edit_Issuing_document').value;
				var Issuing_document_section = document
						.getElementById('edit_Issuing_document_section').value;
				var Issuing_document_No = document
						.getElementById('edit_Issuing_document_No').value;
				var Notes = document.getElementById('edit_Notes').value;
				var voucherID = document.getElementById('selectedvoucherid').value;
				var params = [ gov, site, farm_ID, person_ID, Person_Name,
						voucher_Date, Fees_Status, Amount, Payment_Status,
						Issuing_document, Issuing_document_section,
						Issuing_document_No, Notes, voucherID ];
				var location = "<c:url value='editvoucher'><c:param name='params' value='paramsvalues'/></c:url>";
				location = location.replace("paramsvalues", params);
				window.location.href = location;
			}
			if (event == 2) {
				var gov = document.getElementById('vm_gov').value;
				var site = document.getElementById('vm_site').value;
				var farm_ID = document.getElementById("vm_farm_ID").value;
				var person_ID = document.getElementById('vm_person_ID').value;
				var Person_Name = document.getElementById('vm_Person_Name').value;
				var voucher_Date = document.getElementById('add_voucher_Date').value;
				var Fees_Status = document.getElementById('add_Fees_Status').value;
				var Amount = document.getElementById('add_Amount').value;
				var Payment_Status = document
						.getElementById('add_Payment_Status').value;
				var Issuing_document = document
						.getElementById('add_Issuing_document').value;
				var Issuing_document_section = document
						.getElementById('add_Issuing_document_section').value;
				var Issuing_document_No = document
						.getElementById('add_Issuing_document_No').value;
				var Notes = document.getElementById('add_Notes').value;
				var params = [ gov, site, farm_ID, person_ID, Person_Name,
						voucher_Date, Fees_Status, Amount, Payment_Status,
						Issuing_document, Issuing_document_section,
						Issuing_document_No, Notes ];
				var location = "<c:url value='addnewvoucher'><c:param name='params' value='paramsvalues'/></c:url>";
				location = location.replace("paramsvalues", params);
				window.location.href = location;
			}
		}

		function voucherPrint() {
			window.print();
		}

		function voucher_delete(id) {
			var farm_ID = document.getElementById("vm_farm_ID").value;
			var params = [ id, farm_ID ];
			var location = "<c:url value='deletevoucher'><c:param name='params' value='paramsvalues'/></c:url>";
			location = location.replace("paramsvalues", params);
			window.location.href = location;
		}

		function voucher_edit(id) {
			document.getElementById("selectedvoucherid").value = id;
			voucherjson = '${vouchers}';
			if (voucherjson) {
				var vouchers = JSON.parse(voucherjson);
				for ( var i in vouchers) {
					if (vouchers[i].voucherID == id) {
						var selected_voucher = vouchers[i];
						if (selected_voucher.voucherDate) {
							document.getElementById("edit_voucher_Date").value = selected_voucher.voucherDate;
						} else {
							document.getElementById("edit_voucher_Date").value = "";
						}
						if (selected_voucher.amount) {
							document.getElementById("edit_Amount").value = selected_voucher.amount;
						} else {
							document.getElementById("edit_Amount").value = "";
						}
						if (selected_voucher.feesStatus) {
							document.getElementById("edit_Fees_Status").value = selected_voucher.feesStatus;
						} else {
							document.getElementById("edit_Fees_Status").value = "";
						}
						if (selected_voucher.notes) {
							document.getElementById("edit_Notes").value = selected_voucher.notes;
						} else {
							document.getElementById("edit_Notes").value = "";
						}
						if (selected_voucher.paymentStatus) {
							document.getElementById("edit_Payment_Status").value = selected_voucher.paymentStatus;
						} else {
							document.getElementById("edit_Payment_Status").value = "";
						}
						if (selected_voucher.issuingDocument) {
							document.getElementById("edit_Issuing_document").value = selected_voucher.issuingDocument;
						} else {
							document.getElementById("edit_Issuing_document").value = "";
						}
						if (selected_voucher.issuingDocumentSection) {
							document
									.getElementById("edit_Issuing_document_section").value = selected_voucher.issuingDocumentSection;
						} else {
							document
									.getElementById("edit_Issuing_document_section").value = "";
						}
						if (selected_voucher.issuingDocumentNo) {
							document.getElementById("edit_Issuing_document_No").value = selected_voucher.issuingDocumentNo;
						} else {
							document.getElementById("edit_Issuing_document_No").value = "";
						}
						document.getElementById("voucher_edit_form").style.visibility = "visible";
						document.getElementById("voucher_add_form").style.visibility = "collapse";
					}
				}
			}
		}

		function voucher_add(id) {
			document.getElementById("voucher_add_form").style.visibility = "visible";
			document.getElementById("voucher_edit_form").style.visibility = "collapse";
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