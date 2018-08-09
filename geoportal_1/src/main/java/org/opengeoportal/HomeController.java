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

	@RequestMapping(value = "/arealayers", method = RequestMethod.GET)
	public ModelAndView getAreaLayers(@RequestParam(value = "params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("arealayers");
		mav.addObject("polygonID", params[0]);
		mav.addObject("lat", params[1]);
		mav.addObject("lng", params[2]);
		return mav;
	}

	@RequestMapping(value = "/rasterlayers", method = RequestMethod.GET)
	public ModelAndView getRasterLayers(@RequestParam(value = "params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("rasterlayers");
		mav.addObject("polygonID", params[0]);
		mav.addObject("lat", params[1]);
		mav.addObject("lng", params[2]);
		return mav;
	}

	@RequestMapping(value = "/vouchers", method = RequestMethod.GET)
	public ModelAndView getVouchers(@RequestParam(value = "params") String param) throws Exception {
		ModelAndView mav = new ModelAndView("vouchers_manager");
		List<Voucher> vouchers = null;
		try {
			VoucherDAO voucherdao = new VoucherDAO();
			vouchers = voucherdao.getVouchersByFarmID(param);
			voucherdao.closeDBConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ObjectMapper mapper = new ObjectMapper();
		String vouchersInjson = mapper.writeValueAsString(vouchers);
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
		List<Voucher> vouchers = null;
		try {
			VoucherDAO voucherdao = new VoucherDAO();
			boolean addresult = voucherdao.addVoucher(voucher);
			vouchers = voucherdao.getVouchersByFarmID(params[2]);
			voucherdao.closeDBConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ObjectMapper mapper = new ObjectMapper();
		String vouchersInjson = mapper.writeValueAsString(vouchers);
		mav.addObject("vouchers", vouchersInjson);
		return mav;
	}

	@RequestMapping(value = "/editvoucher", method = RequestMethod.GET)
	public ModelAndView editVoucher(@RequestParam(value = "params") String[] params) throws Exception {
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
		voucher.setVoucherID(Integer.parseInt(params[13]));
		List<Voucher> vouchers = null;
		try {
			VoucherDAO voucherdao = new VoucherDAO();
			boolean updateResult = voucherdao.updateVoucher(voucher);
			vouchers = voucherdao.getVouchersByFarmID(params[2]);
			voucherdao.closeDBConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ObjectMapper mapper = new ObjectMapper();
		String vouchersInjson = mapper.writeValueAsString(vouchers);
		mav.addObject("vouchers", vouchersInjson);
		return mav;
	}

	@RequestMapping(value = "/deletevoucher", method = RequestMethod.GET)
	public ModelAndView deleteVoucher(@RequestParam(value = "params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("vouchers_manager");
		int voucherID = Integer.parseInt(params[0]);
		String farmID = params[1];
		List<Voucher> vouchers = null;
		try {
			VoucherDAO voucherdao = new VoucherDAO();
			boolean deleteResult = voucherdao.deleteByVoucherID(voucherID);
			vouchers = voucherdao.getVouchersByFarmID(farmID);
			voucherdao.closeDBConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ObjectMapper mapper = new ObjectMapper();
		String vouchersInjson = mapper.writeValueAsString(vouchers);
		mav.addObject("vouchers", vouchersInjson);
		return mav;
	}
	
	@RequestMapping(value = "/editfarminfo", method = RequestMethod.GET)
	public ModelAndView editFarmInfo() throws Exception {
		ModelAndView mav = new ModelAndView("farm_manager");
		/*int farmID = Integer.parseInt(param);
		System.out.println("=============Farm ID: "+farmID);
		Farm farm = null;
		try {
			FarmDAO farmdao = new FarmDAO();
			farm = farmdao.getByFarmID(farmID);
			farmdao.closeDBConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ObjectMapper mapper = new ObjectMapper();
		String farmInjson = mapper.writeValueAsString(farm);
		System.out.println("==============Farm Object: "+farmInjson);
		mav.addObject("farm", farmInjson);*/
		return mav;
	}
}
