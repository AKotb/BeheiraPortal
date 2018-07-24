package org.opengeoportal;

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
}
