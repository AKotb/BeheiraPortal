/**
 * 
 */
package org.opengeoportal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author ahmed.kotb
 *
 */
public class DBConPgSQL {

	private Connection con;
	private String dbDriverName;
	private String dbName;
	private String dbUserName;
	private String dbPassword;

	/**
	 * @param con
	 * @param dbDriverName
	 * @param dbName
	 * @param dbUserName
	 * @param dbPassword
	 */
	public DBConPgSQL(String dbName, String dbUserName, String dbPassword) {
		super();
		this.dbDriverName = "org.postgresql.Driver";
		this.dbName = dbName;
		this.dbUserName = dbUserName;
		this.dbPassword = dbPassword;
		this.establishDBConn(dbDriverName, dbName, dbUserName, dbPassword);
	}

	public void establishDBConn(String dbDriverName, String dbName, String dbUserName, String dbPassword) {
		try {
			Class.forName(dbDriverName);
			con = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/" + dbName, dbUserName, dbPassword);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public Voucher getByVoucherID(String id) {
		Voucher voucher = new Voucher();
		try {
			String queryString = "select * from vouchers.voucher where \"voucher_ID\"='" + id + "'";
			Statement stmt = con.createStatement();
			ResultSet rset = stmt.executeQuery(queryString);
			while (rset.next()) {
				voucher.setVoucherID(rset.getString(1));
				voucher.setGov(rset.getString(2));
				voucher.setSite(rset.getString(3));
				voucher.setFarmID(rset.getString(4));
				voucher.setPersonName(rset.getString(5));
				voucher.setPersonID(rset.getString(6));
				voucher.setVoucherDate(rset.getDate(7));
				voucher.setAmount(rset.getString(8));
				voucher.setFeesStatus(rset.getString(9));
				voucher.setNotes(rset.getString(10));
				voucher.setPaymentStatus(rset.getString(11));
				voucher.setIssuingDocument(rset.getString(12));
				voucher.setIssuingDocumentSection(rset.getString(13));
				voucher.setIssuingDocumentNo(rset.getString(14));
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return voucher;

	}

	public static void main(String args[]) {
		DBConPgSQL dbConnection = new DBConPgSQL("vouchers", "postgres", "postgres");
		Voucher voucher = dbConnection.getByVoucherID("9");
		System.out.println("Voucher ID: " + voucher.getVoucherID());
		System.out.println("Gov: " + voucher.getGov());
		System.out.println("Site: " + voucher.getSite());
		System.out.println("Farm ID: " + voucher.getFarmID());
		System.out.println("Person Name: " + voucher.getPersonName());
		System.out.println("Person ID: " + voucher.getPersonID());
		System.out.println("Voucher Date: " + voucher.getVoucherDate());
		System.out.println("Amount: " + voucher.getAmount());
		System.out.println("Fees Status: " + voucher.getFeesStatus());
		System.out.println("Notes: " + voucher.getNotes());
		System.out.println("Payment Status: " + voucher.getPaymentStatus());
		System.out.println("Issuing Document: " + voucher.getIssuingDocument());
		System.out.println("Issuing Document Section: " + voucher.getIssuingDocumentSection());
		System.out.println("Issuing Document No: " + voucher.getIssuingDocumentNo());
	}

}
