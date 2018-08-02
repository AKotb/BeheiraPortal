/**
 * 
 */
package org.opengeoportal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author ahmed.kotb
 *
 */
public class FarmDAO {

	private static Connection con;

	/**
	 * 
	 */
	public FarmDAO() {
		super();
		con = DBConPgSQL.establishDBConn();
	}

	public Farm getByFarmID(int farmID) {
		Farm farm = new Farm();
		PreparedStatement preparedStatement = null;
		try {
			String queryString = "select * from vouchers.farms where \"farm_id\"=?";
			preparedStatement = con.prepareStatement(queryString);
			preparedStatement.setInt(1, farmID);
			ResultSet rset = preparedStatement.executeQuery();
			while (rset.next()) {
				farm.setId(rset.getInt(1));
				farm.setFarmID(rset.getInt(2));
				farm.setFarmName(rset.getString(3));
				farm.setOwnerID(rset.getInt(4));
				farm.setOwnerName(rset.getString(5));
				farm.setTelephone(rset.getString(6));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return farm;
	}

	public boolean updateFarm(Farm farm) {
		PreparedStatement preparedStatement = null;
		boolean updateResult = false;
		try {
			String queryString = "UPDATE vouchers.farms SET \"farm_name\"=?, \"owner_id\"=?, \"owner_name\"=?, \"telephone\"=? WHERE \"farm_id\"=?";
			preparedStatement = con.prepareStatement(queryString);
			preparedStatement.setString(1, farm.getFarmName());
			preparedStatement.setInt(2, farm.getOwnerID());
			preparedStatement.setString(3, farm.getOwnerName());
			preparedStatement.setString(4, farm.getTelephone());
			preparedStatement.setInt(5, farm.getFarmID());
			int i = preparedStatement.executeUpdate();
			if (i == 1) {
				updateResult = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return updateResult;
	}
}
