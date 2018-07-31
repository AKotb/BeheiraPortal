package org.opengeoportal;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class HomeController {

	final Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = { "/index", "/" }, method = RequestMethod.GET)
	public ModelAndView getHomePage() throws Exception {
		ModelAndView mav = new ModelAndView("ogp_home_contractual");
		return mav;
	}

	/*
	 * @RequestMapping(value = "/arealayers", method = RequestMethod.GET) public
	 * ModelAndView getAreaLayers(@RequestParam(value = "id") int
	 * id, @RequestParam(value = "lat") int lat, @RequestParam(value = "lng") int
	 * lng) throws Exception { ModelAndView mav = new ModelAndView("arealayers");
	 * mav.addObject("polygonID", id); mav.addObject("lat", lat);
	 * mav.addObject("lng", lng); return mav; }
	 */

	@RequestMapping(value = "/arealayers", method = RequestMethod.GET)
	public ModelAndView getAreaLayers(@RequestParam(value = "params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("arealayers");
		System.out.println("Array Length: " + params.length);
		System.out.println("ID: " + params[0]);
		System.out.println("Lat: " + params[1]);
		System.out.println("Lng: " + params[2]);
		mav.addObject("polygonID", params[0]);
		mav.addObject("lat", params[1]);
		mav.addObject("lng", params[2]);
		return mav;
	}

	
	@RequestMapping(value = "/vouchers", method = RequestMethod.GET)
	public ModelAndView getVouchers(@RequestParam(value = "params") String param) throws Exception {
		ModelAndView mav = new ModelAndView("vouchers_manager");
		System.out.println("Area ID: " + param);
		DBConPgSQL dbConnection = new DBConPgSQL("vouchers", "postgres", "postgres");
		List<Voucher> vouchers = dbConnection.getVouchersByFarmID(param);
		ObjectMapper mapper = new ObjectMapper();
		String vouchersInjson = mapper.writeValueAsString(vouchers);
		System.out.println("vouchers in JSON: "+vouchersInjson);
		mav.addObject("vouchers", vouchersInjson);
		return mav;
	}
	
	
	@RequestMapping(value = "/addnewvoucher", method = RequestMethod.GET)
	public ModelAndView addNewVoucher(@RequestParam(value = "params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("vouchers_manager");
		Voucher voucher = new Voucher();
		voucher.setGov(params[0]);
		voucher.setSite(params[1]);
		voucher.setFarmID(params[2]);
		voucher.setPersonID(params[3]);
		voucher.setPersonName(params[4]);
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date date = formatter.parse(params[5]);
		voucher.setVoucherDate(date);
		voucher.setFeesStatus(params[6]);
		voucher.setAmount(params[7]);
		voucher.setPaymentStatus(params[8]);
		voucher.setIssuingDocument(params[9]);
		voucher.setIssuingDocumentSection(params[10]);
		voucher.setIssuingDocumentNo(params[11]);
		voucher.setNotes(params[12]);
		DBConPgSQL dbConnection = new DBConPgSQL("vouchers", "postgres", "postgres");
		boolean addresult = dbConnection.addVoucher(voucher);
		DBConPgSQL dbConnection1 = new DBConPgSQL("vouchers", "postgres", "postgres");
		List<Voucher> vouchers = dbConnection1.getVouchersByFarmID(params[2]);
		ObjectMapper mapper = new ObjectMapper();
		String vouchersInjson = mapper.writeValueAsString(vouchers);
		mav.addObject("vouchers", vouchersInjson);
		return mav;
	}
}
