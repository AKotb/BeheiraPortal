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
	private String ownership;
	private String reclamedArea;
	private String urbanArea;
	private String unusedArea;
	private String fieldCropsArea;
	private String cropsArea;
	private String managBuildings;
	private String poulBuildings;
	private String animBuildings;
	private String agriBuildings;

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
	 * @param ownership
	 * @param reclamedArea
	 * @param urbanArea
	 * @param unusedArea
	 * @param fieldCropsArea
	 * @param cropsArea
	 * @param managBuildings
	 * @param poulBuildings
	 * @param animBuildings
	 * @param agriBuildings
	 */
	public Farm(int id, int farmID, String farmName, String ownerID, String ownerName, String telephone,
			String ownership, String reclamedArea, String urbanArea, String unusedArea, String fieldCropsArea,
			String cropsArea, String managBuildings, String poulBuildings, String animBuildings, String agriBuildings) {
		super();
		this.id = id;
		this.farmID = farmID;
		this.farmName = farmName;
		this.ownerID = ownerID;
		this.ownerName = ownerName;
		this.telephone = telephone;
		this.ownership = ownership;
		this.reclamedArea = reclamedArea;
		this.urbanArea = urbanArea;
		this.unusedArea = unusedArea;
		this.fieldCropsArea = fieldCropsArea;
		this.cropsArea = cropsArea;
		this.managBuildings = managBuildings;
		this.poulBuildings = poulBuildings;
		this.animBuildings = animBuildings;
		this.agriBuildings = agriBuildings;
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

	/**
	 * @return the ownership
	 */
	public String getOwnership() {
		return ownership;
	}

	/**
	 * @param ownership
	 *            the ownership to set
	 */
	public void setOwnership(String ownership) {
		this.ownership = ownership;
	}

	/**
	 * @return the reclamedArea
	 */
	public String getReclamedArea() {
		return reclamedArea;
	}

	/**
	 * @param reclamedArea
	 *            the reclamedArea to set
	 */
	public void setReclamedArea(String reclamedArea) {
		this.reclamedArea = reclamedArea;
	}

	/**
	 * @return the urbanArea
	 */
	public String getUrbanArea() {
		return urbanArea;
	}

	/**
	 * @param urbanArea
	 *            the urbanArea to set
	 */
	public void setUrbanArea(String urbanArea) {
		this.urbanArea = urbanArea;
	}

	/**
	 * @return the unusedArea
	 */
	public String getUnusedArea() {
		return unusedArea;
	}

	/**
	 * @param unusedArea
	 *            the unusedArea to set
	 */
	public void setUnusedArea(String unusedArea) {
		this.unusedArea = unusedArea;
	}

	/**
	 * @return the fieldCropsArea
	 */
	public String getFieldCropsArea() {
		return fieldCropsArea;
	}

	/**
	 * @param fieldCropsArea
	 *            the fieldCropsArea to set
	 */
	public void setFieldCropsArea(String fieldCropsArea) {
		this.fieldCropsArea = fieldCropsArea;
	}

	/**
	 * @return the cropsArea
	 */
	public String getCropsArea() {
		return cropsArea;
	}

	/**
	 * @param cropsArea
	 *            the cropsArea to set
	 */
	public void setCropsArea(String cropsArea) {
		this.cropsArea = cropsArea;
	}

	/**
	 * @return the managBuildings
	 */
	public String getManagBuildings() {
		return managBuildings;
	}

	/**
	 * @param managBuildings
	 *            the managBuildings to set
	 */
	public void setManagBuildings(String managBuildings) {
		this.managBuildings = managBuildings;
	}

	/**
	 * @return the poulBuildings
	 */
	public String getPoulBuildings() {
		return poulBuildings;
	}

	/**
	 * @param poulBuildings
	 *            the poulBuildings to set
	 */
	public void setPoulBuildings(String poulBuildings) {
		this.poulBuildings = poulBuildings;
	}

	/**
	 * @return the animBuildings
	 */
	public String getAnimBuildings() {
		return animBuildings;
	}

	/**
	 * @param animBuildings
	 *            the animBuildings to set
	 */
	public void setAnimBuildings(String animBuildings) {
		this.animBuildings = animBuildings;
	}

	/**
	 * @return the agriBuildings
	 */
	public String getAgriBuildings() {
		return agriBuildings;
	}

	/**
	 * @param agriBuildings
	 *            the agriBuildings to set
	 */
	public void setAgriBuildings(String agriBuildings) {
		this.agriBuildings = agriBuildings;
	}

}
