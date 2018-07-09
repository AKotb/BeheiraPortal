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
public class DBConnection {

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
	public DBConnection(Connection con, String dbDriverName, String dbName, String dbUserName, String dbPassword) {
		super();
		this.con = con;
		this.dbDriverName = dbDriverName;
		this.dbName = dbName;
		this.dbUserName = dbUserName;
		this.dbPassword = dbPassword;
		this.establishDBConn(con, dbDriverName, dbName, dbUserName, dbPassword);
	}

	public void establishDBConn(Connection con, String dbDriverName, String dbName, String dbUserName,
			String dbPassword) {
		try {
			String jdbcUrl = "jdbc:mysql://192.168..2.103:33060/vouchers?user=root&password=root1234";
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(jdbcUrl);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public Voucher getByVoucherID(String id) {
		Voucher voucher = new Voucher();
		try {
			String queryString = "select * from voucher where voucher_ID='" + id + "'";
			Statement stmt = con.createStatement();
			ResultSet rset = stmt.executeQuery(queryString);
			while (rset.next()) {
				voucher.setVoucherID(rset.getString(1));
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return voucher;

	}

}
