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
	
	@RequestMapping(value = "/searchforfarms", method = RequestMethod.GET)
	public ModelAndView searchForFarms() throws Exception {
		ModelAndView mav = new ModelAndView("farm_manager");
		return mav;
	}
	
	@RequestMapping(value = "/editfarmdata", method = RequestMethod.GET)
	public ModelAndView updateFarmData(@RequestParam(value = "params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("farm_manager");
		Farm farm = new Farm();
		farm.setFarmID(Integer.parseInt(params[0]));
		farm.setFarmName(params[1]);
		farm.setOwnerName(params[2]);
		farm.setOwnerID(params[3]);
		farm.setTelephone(params[4]);
		farm.setOwnership(params[5]);
		List<Farm> farmsList = null;
		try {
			FarmDAO farmdao = new FarmDAO();
			boolean updateResult = farmdao.updateFarm(farm);
			farmsList = farmdao.getAllFarms(params[1], params[3], params[2], params[4], params[5]);
			farmdao.closeDBConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ObjectMapper mapper = new ObjectMapper();
		String farmsInjson = mapper.writeValueAsString(farmsList);
		mav.addObject("farms", farmsInjson);
		return mav;
	}
	
	@RequestMapping(value = "/getallfarms", method = RequestMethod.GET)
	public ModelAndView getAllFarms(@RequestParam(value = "params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("farm_manager");
		List<Farm> farmsList = null;
		try {
			FarmDAO farmdao = new FarmDAO();
			farmsList= farmdao.getAllFarms(params[0], params[1], params[2], params[3], params[4]);
			farmdao.closeDBConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ObjectMapper mapper = new ObjectMapper();
		String farmsInjson = mapper.writeValueAsString(farmsList);
		mav.addObject("farms", farmsInjson);
		return mav;
	}
	
	@RequestMapping(value = "/getallavailablefarms", method = RequestMethod.GET)
	public ModelAndView getAllAvailableFarms() throws Exception {
		ModelAndView mav = new ModelAndView("ogp_home_contractual");
		List<Farm> farmsList = null;
		try {
			FarmDAO farmdao = new FarmDAO();
			farmsList= farmdao.getAllAvailableFarms();
			farmdao.closeDBConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ObjectMapper mapper = new ObjectMapper();
		String farmsInjson = mapper.writeValueAsString(farmsList);
		mav.addObject("farms", farmsInjson);
		return mav;
	}
	
	@RequestMapping(value = "/who_we_are", method = RequestMethod.GET)
	public ModelAndView whoWeAre() throws Exception {
		ModelAndView mav = new ModelAndView("who_we_are");
		return mav;
	}
	
	@RequestMapping(value = "/regulations_and_laws", method = RequestMethod.GET)
	public ModelAndView regulationsAndLaws() throws Exception {
		ModelAndView mav = new ModelAndView("regulations_and_laws");
		return mav;
	}
}
