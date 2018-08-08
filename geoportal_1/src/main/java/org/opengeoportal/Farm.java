/**
 * 
 */
package org.opengeoportal;

/**
 * @author ahmed.kotb
 *
 */
public class Farm {
	private int id;
	private int farmID;
	private String farmName;
	private String ownerID;
	private String ownerName;
	private String telephone;

	/**
	 * 
	 */
	public Farm() {
		super();
	}

	/**
	 * @param id
	 * @param farmID
	 * @param farmName
	 * @param ownerID
	 * @param ownerName
	 * @param telephone
	 */
	public Farm(int id, int farmID, String farmName, String ownerID, String ownerName, String telephone) {
		super();
		this.id = id;
		this.farmID = farmID;
		this.farmName = farmName;
		this.ownerID = ownerID;
		this.ownerName = ownerName;
		this.telephone = telephone;
	}

	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * @return the farmID
	 */
	public int getFarmID() {
		return farmID;
	}

	/**
	 * @param farmID
	 *            the farmID to set
	 */
	public void setFarmID(int farmID) {
		this.farmID = farmID;
	}

	/**
	 * @return the farmName
	 */
	public String getFarmName() {
		return farmName;
	}

	/**
	 * @param farmName
	 *            the farmName to set
	 */
	public void setFarmName(String farmName) {
		this.farmName = farmName;
	}

	/**
	 * @return the ownerID
	 */
	public String getOwnerID() {
		return ownerID;
	}

	/**
	 * @param ownerID
	 *            the ownerID to set
	 */
	public void setOwnerID(String ownerID) {
		this.ownerID = ownerID;
	}

	/**
	 * @return the ownerName
	 */
	public String getOwnerName() {
		return ownerName;
	}

	/**
	 * @param ownerName
	 *            the ownerName to set
	 */
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}

	/**
	 * @return the telephone
	 */
	public String getTelephone() {
		return telephone;
	}

	/**
	 * @param telephone
	 *            the telephone to set
	 */
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

}
