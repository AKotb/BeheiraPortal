/**
 * 
 */
package org.opengeoportal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author ahmed.kotb
 *
 */
public class VoucherDAO {

	private static Connection con;

	public VoucherDAO() {
		super();
		con = DBConPgSQL.establishDBConn();
	}
	
	public void closeDBConn() {
		try {
			con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	public Voucher getByVoucherID(String id) {
		Voucher voucher = new Voucher();
		PreparedStatement preparedStatement = null;
		try {
			//String queryString = "select * from beheiraschema.voucher where \"voucher_ID\"=?";
			String queryString = "select * from beheiraschemafordev.voucher where \"voucher_ID\"=?";
			preparedStatement = con.prepareStatement(queryString);
			preparedStatement.setString(1, id);
			ResultSet rset = preparedStatement.executeQuery();
			while (rset.next()) {
				voucher.setGov(rset.getString(1));
				voucher.setSite(rset.getString(2));
				voucher.setFarmID(rset.getString(3));
				voucher.setPersonName(rset.getString(4));
				voucher.setPersonID(rset.getString(5));
				voucher.setVoucherDate(rset.getDate(6));
				voucher.setAmount(rset.getString(7));
				voucher.setFeesStatus(rset.getString(8));
				voucher.setNotes(rset.getString(9));
				voucher.setPaymentStatus(rset.getString(10));
				voucher.setIssuingDocument(rset.getString(11));
				voucher.setIssuingDocumentSection(rset.getString(12));
				voucher.setIssuingDocumentNo(rset.getString(13));
				voucher.setVoucherID(rset.getInt(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return voucher;

	}

	public List<Voucher> getVouchersByFarmID(String farmid) {
		List<Voucher> vouchersList = new ArrayList<Voucher>();
		PreparedStatement preparedStatement = null;
		try {
			//String queryString = "select * from beheiraschema.voucher where \"Farm_ID\" = ?";
			String queryString = "select * from beheiraschemafordev.voucher where \"Farm_ID\" = ?";
			preparedStatement = con.prepareStatement(queryString);
			preparedStatement.setString(1, farmid);
			ResultSet rset = preparedStatement.executeQuery();
			while (rset.next()) {
				Voucher voucher = new Voucher();
				voucher.setGov(rset.getString(1));
				voucher.setSite(rset.getString(2));
				voucher.setFarmID(rset.getString(3));
				voucher.setPersonName(rset.getString(4));
				voucher.setPersonID(rset.getString(5));
				voucher.setVoucherDate(rset.getDate(6));
				voucher.setAmount(rset.getString(7));
				voucher.setFeesStatus(rset.getString(8));
				voucher.setNotes(rset.getString(9));
				voucher.setPaymentStatus(rset.getString(10));
				voucher.setIssuingDocument(rset.getString(11));
				voucher.setIssuingDocumentSection(rset.getString(12));
				voucher.setIssuingDocumentNo(rset.getString(13));
				voucher.setVoucherID(rset.getInt(14));
				vouchersList.add(voucher);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vouchersList;

	}

	public boolean addVoucher(Voucher voucher) {
		PreparedStatement preparedStatement = null;
		boolean insertResult = false;
		try {
			//String queryString = "INSERT INTO beheiraschema.voucher(\"gov\", \"site\", \"Farm_ID\", \"Person_Name\", \"person_ID\", \"voucher_Date\", \"Amount\", \"Fees_Status\", \"Notes\", \"Payment_Status\", \"Issuing_document\", \"Issuing_document_section\", \"Issuing_document_No\") values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			String queryString = "INSERT INTO beheiraschemafordev.voucher(\"gov\", \"site\", \"Farm_ID\", \"Person_Name\", \"person_ID\", \"voucher_Date\", \"Amount\", \"Fees_Status\", \"Notes\", \"Payment_Status\", \"Issuing_document\", \"Issuing_document_section\", \"Issuing_document_No\") values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			preparedStatement = con.prepareStatement(queryString);
			preparedStatement.setString(1, voucher.getGov());
			preparedStatement.setString(2, voucher.getSite());
			preparedStatement.setString(3, voucher.getFarmID());
			preparedStatement.setString(4, voucher.getPersonName());
			preparedStatement.setString(5, voucher.getPersonID());
			java.sql.Date sqlDate = new java.sql.Date(voucher.getVoucherDate().getTime());
			preparedStatement.setDate(6, sqlDate);
			preparedStatement.setString(7, voucher.getAmount());
			preparedStatement.setString(8, voucher.getFeesStatus());
			preparedStatement.setString(9, voucher.getNotes());
			preparedStatement.setString(10, voucher.getPaymentStatus());
			preparedStatement.setString(11, voucher.getIssuingDocument());
			preparedStatement.setString(12, voucher.getIssuingDocumentSection());
			preparedStatement.setString(13, voucher.getIssuingDocumentNo());
			int i = preparedStatement.executeUpdate();
			if (i == 1) {
				insertResult = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return insertResult;
	}

	public boolean updateVoucher(Voucher voucher) {
		PreparedStatement preparedStatement = null;
		boolean updateResult = false;
		try {
			//String queryString = "UPDATE beheiraschema.voucher SET \"gov\"=?, \"site\"=?, \"Farm_ID\"=?, \"Person_Name\"=?, \"person_ID\"=?, \"voucher_Date\"=?, \"Amount\"=?, \"Fees_Status\"=?, \"Notes\"=?, \"Payment_Status\"=?, \"Issuing_document\"=?, \"Issuing_document_section\"=?, \"Issuing_document_No\"=? WHERE \"voucher_ID\"=?";
			String queryString = "UPDATE beheiraschemafordev.voucher SET \"gov\"=?, \"site\"=?, \"Farm_ID\"=?, \"Person_Name\"=?, \"person_ID\"=?, \"voucher_Date\"=?, \"Amount\"=?, \"Fees_Status\"=?, \"Notes\"=?, \"Payment_Status\"=?, \"Issuing_document\"=?, \"Issuing_document_section\"=?, \"Issuing_document_No\"=? WHERE \"voucher_ID\"=?";
			preparedStatement = con.prepareStatement(queryString);
			preparedStatement.setString(1, voucher.getGov());
			preparedStatement.setString(2, voucher.getSite());
			preparedStatement.setString(3, voucher.getFarmID());
			preparedStatement.setString(4, voucher.getPersonName());
			preparedStatement.setString(5, voucher.getPersonID());
			java.sql.Date sqlDate = new java.sql.Date(voucher.getVoucherDate().getTime());
			preparedStatement.setDate(6, sqlDate);
			preparedStatement.setString(7, voucher.getAmount());
			preparedStatement.setString(8, voucher.getFeesStatus());
			preparedStatement.setString(9, voucher.getNotes());
			preparedStatement.setString(10, voucher.getPaymentStatus());
			preparedStatement.setString(11, voucher.getIssuingDocument());
			preparedStatement.setString(12, voucher.getIssuingDocumentSection());
			preparedStatement.setString(13, voucher.getIssuingDocumentNo());
			preparedStatement.setInt(14, voucher.getVoucherID());
			int i = preparedStatement.executeUpdate();
			if (i == 1) {
				updateResult = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return updateResult;
	}

	public boolean deleteByVoucherID(int voucherID) {
		PreparedStatement preparedStatement = null;
		boolean deleteResult = false;
		try {
			//String queryString = "DELETE FROM beheiraschema.voucher WHERE \"voucher_ID\"=?";
			String queryString = "DELETE FROM beheiraschemafordev.voucher WHERE \"voucher_ID\"=?";
			preparedStatement = con.prepareStatement(queryString);
			preparedStatement.setInt(1, voucherID);
			int i = preparedStatement.executeUpdate();
			if (i == 1) {
				deleteResult = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return deleteResult;
	}

	public static void main(String args[]) {
		/*
		 * Voucher voucher = dbConnection.getByVoucherID("9");
		 * System.out.println("Voucher ID: " + voucher.getVoucherID());
		 * System.out.println("Gov: " + voucher.getGov()); System.out.println("Site: " +
		 * voucher.getSite()); System.out.println("Farm ID: " + voucher.getFarmID());
		 * System.out.println("Person Name: " + voucher.getPersonName());
		 * System.out.println("Person ID: " + voucher.getPersonID());
		 * System.out.println("Voucher Date: " + voucher.getVoucherDate());
		 * System.out.println("Amount: " + voucher.getAmount());
		 * System.out.println("Fees Status: " + voucher.getFeesStatus());
		 * System.out.println("Notes: " + voucher.getNotes());
		 * System.out.println("Payment Status: " + voucher.getPaymentStatus());
		 * System.out.println("Issuing Document: " + voucher.getIssuingDocument());
		 * System.out.println("Issuing Document Section: " +
		 * voucher.getIssuingDocumentSection());
		 * System.out.println("Issuing Document No: " + voucher.getIssuingDocumentNo());
		 */

		/*
		 * List<Voucher> vouchersList = dbConnection.getVouchersByFarmID("12");
		 * System.out.println("Vochers List Size: "+vouchersList.size());
		 */

		/*
		 * boolean deleteResult = dbConnection.deleteByVoucherID("12");
		 * System.out.println("Delete Result: "+deleteResult);
		 */

		/*
		 * Voucher voucher = new Voucher(); voucher.setGov("Cairo");
		 * voucher.setSite("NARSS"); voucher.setFarmID("8");
		 * voucher.setPersonName("AhmedKotb"); voucher.setPersonID("102030405060");
		 * voucher.setVoucherDate(new java.util.Date()); voucher.setAmount("2000");
		 * voucher.setFeesStatus("Done"); voucher.setNotes("Notes");
		 * voucher.setPaymentStatus("Paid"); voucher.setIssuingDocument("10");
		 * voucher.setIssuingDocumentSection("Cairo");
		 * voucher.setIssuingDocumentNo("10"); boolean addResult =
		 * dbConnection.addVoucher(voucher);
		 * System.out.println("Add Result: "+addResult);
		 */

		/*
		 * Voucher voucher = new Voucher(); voucher.setVoucherID("13");
		 * voucher.setGov("Cairo"); voucher.setSite("NARSS"); voucher.setFarmID("12");
		 * voucher.setPersonName("AhmedKotb"); voucher.setPersonID("102030405060");
		 * voucher.setVoucherDate(new java.util.Date()); voucher.setAmount("2000");
		 * voucher.setFeesStatus("Done"); voucher.setNotes("Notes");
		 * voucher.setPaymentStatus("Paid"); voucher.setIssuingDocument("10");
		 * voucher.setIssuingDocumentSection("Cairo");
		 * voucher.setIssuingDocumentNo("10"); boolean updateResult =
		 * dbConnection.updateVoucher(voucher);
		 * System.out.println("Update Result: "+updateResult);
		 */
	}
}
