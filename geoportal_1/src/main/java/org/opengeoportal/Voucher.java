/**
 * 
 */
package org.opengeoportal;

import java.util.Date;

/**
 * @author ahmed.kotb
 *
 */
public class Voucher {

	private int voucherID;
	private String gov;
	private String site;
	private String farmID;
	private String personName;
	private String personID;
	private Date voucherDate;
	private String amount;
	private String feesStatus;
	private String notes;
	private String paymentStatus;
	private String issuingDocument;
	private String issuingDocumentSection;
	private String issuingDocumentNo;

	/**
	 * 
	 */
	public Voucher() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param voucherID
	 * @param gov
	 * @param site
	 * @param farmID
	 * @param personName
	 * @param personID
	 * @param voucherDate
	 * @param amount
	 * @param feesStatus
	 * @param notes
	 * @param paymentStatus
	 * @param issuingDocument
	 * @param issuingDocumentSection
	 * @param issuingDocumentNo
	 */
	public Voucher(int voucherID, String gov, String site, String farmID, String personName, String personID,
			Date voucherDate, String amount, String feesStatus, String notes, String paymentStatus,
			String issuingDocument, String issuingDocumentSection, String issuingDocumentNo) {
		super();
		this.voucherID = voucherID;
		this.gov = gov;
		this.site = site;
		this.farmID = farmID;
		this.personName = personName;
		this.personID = personID;
		this.voucherDate = voucherDate;
		this.amount = amount;
		this.feesStatus = feesStatus;
		this.notes = notes;
		this.paymentStatus = paymentStatus;
		this.issuingDocument = issuingDocument;
		this.issuingDocumentSection = issuingDocumentSection;
		this.issuingDocumentNo = issuingDocumentNo;
	}

	/**
	 * @return the voucherID
	 */
	public int getVoucherID() {
		return voucherID;
	}

	/**
	 * @param voucherID
	 *            the voucherID to set
	 */
	public void setVoucherID(int voucherID) {
		this.voucherID = voucherID;
	}

	/**
	 * @return the gov
	 */
	public String getGov() {
		return gov;
	}

	/**
	 * @param gov
	 *            the gov to set
	 */
	public void setGov(String gov) {
		this.gov = gov;
	}

	/**
	 * @return the site
	 */
	public String getSite() {
		return site;
	}

	/**
	 * @param site
	 *            the site to set
	 */
	public void setSite(String site) {
		this.site = site;
	}

	/**
	 * @return the farmID
	 */
	public String getFarmID() {
		return farmID;
	}

	/**
	 * @param farmID
	 *            the farmID to set
	 */
	public void setFarmID(String farmID) {
		this.farmID = farmID;
	}

	/**
	 * @return the personName
	 */
	public String getPersonName() {
		return personName;
	}

	/**
	 * @param personName
	 *            the personName to set
	 */
	public void setPersonName(String personName) {
		this.personName = personName;
	}

	/**
	 * @return the personID
	 */
	public String getPersonID() {
		return personID;
	}

	/**
	 * @param personID
	 *            the personID to set
	 */
	public void setPersonID(String personID) {
		this.personID = personID;
	}

	/**
	 * @return the voucherDate
	 */
	public Date getVoucherDate() {
		return voucherDate;
	}

	/**
	 * @param voucherDate
	 *            the voucherDate to set
	 */
	public void setVoucherDate(Date voucherDate) {
		this.voucherDate = voucherDate;
	}

	/**
	 * @return the amount
	 */
	public String getAmount() {
		return amount;
	}

	/**
	 * @param amount
	 *            the amount to set
	 */
	public void setAmount(String amount) {
		this.amount = amount;
	}

	/**
	 * @return the feesStatus
	 */
	public String getFeesStatus() {
		return feesStatus;
	}

	/**
	 * @param feesStatus
	 *            the feesStatus to set
	 */
	public void setFeesStatus(String feesStatus) {
		this.feesStatus = feesStatus;
	}

	/**
	 * @return the notes
	 */
	public String getNotes() {
		return notes;
	}

	/**
	 * @param notes
	 *            the notes to set
	 */
	public void setNotes(String notes) {
		this.notes = notes;
	}

	/**
	 * @return the paymentStatus
	 */
	public String getPaymentStatus() {
		return paymentStatus;
	}

	/**
	 * @param paymentStatus
	 *            the paymentStatus to set
	 */
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	/**
	 * @return the issuingDocument
	 */
	public String getIssuingDocument() {
		return issuingDocument;
	}

	/**
	 * @param issuingDocument
	 *            the issuingDocument to set
	 */
	public void setIssuingDocument(String issuingDocument) {
		this.issuingDocument = issuingDocument;
	}

	/**
	 * @return the issuingDocumentSection
	 */
	public String getIssuingDocumentSection() {
		return issuingDocumentSection;
	}

	/**
	 * @param issuingDocumentSection
	 *            the issuingDocumentSection to set
	 */
	public void setIssuingDocumentSection(String issuingDocumentSection) {
		this.issuingDocumentSection = issuingDocumentSection;
	}

	/**
	 * @return the issuingDocumentNo
	 */
	public String getIssuingDocumentNo() {
		return issuingDocumentNo;
	}

	/**
	 * @param issuingDocumentNo
	 *            the issuingDocumentNo to set
	 */
	public void setIssuingDocumentNo(String issuingDocumentNo) {
		this.issuingDocumentNo = issuingDocumentNo;
	}

}
