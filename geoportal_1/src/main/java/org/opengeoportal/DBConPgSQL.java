/**
 * 
 */
package org.opengeoportal;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * @author ahmed.kotb
 *
 */
public class DBConPgSQL {

	private static final String dbDriverName = "org.postgresql.Driver";
	private static String dbName = "vouchers";
	private static String dbUserName = "postgres";
	private static String dbPassword = "postgres";

	/**
	 * 
	 */
	public DBConPgSQL() {
		super();
	}

	public static Connection establishDBConn() {
		Connection con = null;
		try {
			Class.forName(dbDriverName);
			con = DriverManager.getConnection("jdbc:postgresql://192.168.2.236:5432/" + dbName, dbUserName, dbPassword);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return con;
	}

}
