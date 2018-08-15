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
public class FarmDAO {

	private static Connection con;

	/**
	 * 
	 */
	public FarmDAO() {
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

	public Farm getByFarmID(int farmID) {
		Farm farm = new Farm();
		PreparedStatement preparedStatement = null;
		try {
			String queryString = "select * from beheiraschema.farms where \"farm_id\"=?";
			preparedStatement = con.prepareStatement(queryString);
			preparedStatement.setInt(1, farmID);
			ResultSet rset = preparedStatement.executeQuery();
			while (rset.next()) {
				farm.setId(rset.getInt(1));
				farm.setFarmID(rset.getInt(2));
				farm.setFarmName(rset.getString(3));
				farm.setOwnerID(rset.getString(4));
				farm.setOwnerName(rset.getString(5));
				farm.setTelephone(rset.getString(6));
				farm.setOwnership(rset.getString(7));
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
			String queryString = "UPDATE beheiraschema.farms SET \"farm_name\"=?, \"owner_id\"=?, \"owner_name\"=?, \"telephone\"=?, \"ownership\"=?  WHERE \"farm_id\"=?";
			preparedStatement = con.prepareStatement(queryString);
			preparedStatement.setString(1, farm.getFarmName());
			preparedStatement.setString(2, farm.getOwnerID());
			preparedStatement.setString(3, farm.getOwnerName());
			preparedStatement.setString(4, farm.getTelephone());
			preparedStatement.setString(5, farm.getOwnership());
			preparedStatement.setInt(6, farm.getFarmID());
			int i = preparedStatement.executeUpdate();
			if (i == 1) {
				updateResult = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return updateResult;
	}
	
	public List<Farm> getAllFarms(String farmName, String ownerId, String ownerName, String telephone, String ownership) {
		PreparedStatement preparedStatement = null;
		List<Farm> farmsList = new ArrayList<Farm>();
		try {
			String queryString = "select * from beheiraschema.farms where \"farm_name\" like ? and \"owner_id\" like ? and \"owner_name\" like ? and \"telephone\" like ? and \"ownership\" like ?";
			preparedStatement = con.prepareStatement(queryString);
			preparedStatement.setString(1, "%"+farmName+"%");
			preparedStatement.setString(2, "%"+ownerId+"%");
			preparedStatement.setString(3, "%"+ownerName+"%");
			preparedStatement.setString(4, "%"+telephone+"%");
			preparedStatement.setString(5, "%"+ownership+"%");
			ResultSet rset = preparedStatement.executeQuery();
			while (rset.next()) {
				Farm farm = new Farm();
				farm.setId(rset.getInt(1));
				farm.setFarmID(rset.getInt(2));
				farm.setFarmName(rset.getString(3));
				farm.setOwnerID(rset.getString(4));
				farm.setOwnerName(rset.getString(5));
				farm.setTelephone(rset.getString(6));
				farm.setOwnership(rset.getString(7));
				farmsList.add(farm);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return farmsList;
	}
}
