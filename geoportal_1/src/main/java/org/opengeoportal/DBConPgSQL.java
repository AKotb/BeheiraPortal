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
	private static String dbName = "postgres";
	private static String dbUserName = "postgres";
	private static String dbPassword = "P@ssw0rd";

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
			con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/" + dbName, dbUserName, dbPassword);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return con;
	}

}
