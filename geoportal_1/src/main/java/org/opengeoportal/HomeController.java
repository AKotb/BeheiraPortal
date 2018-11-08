package org.opengeoportal;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.HibernateException;
import org.hibernate.Session;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.apache.log4j.Logger;
import org.apache.log4j.Priority;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.subject.Subject;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.hibernate.exception.ConstraintViolationException;
import org.opengeoportal.config.ogp.OgpConfig;
import org.opengeoportal.config.ogp.OgpConfigRetriever;
import org.opengeoportal.usermanagement.PortalUser;
import org.opengeoportal.usermanagement.PortalUserDao;
import org.opengeoportal.usermanagement.RoleDao;
import org.opengeoportal.utilities.HibernateUtil;

@Controller
public class HomeController {

	@Autowired
	private OgpConfigRetriever ogpConfigRetriever;
	//final Logger logger = LoggerFactory.getLogger(this.getClass());
	private final static Logger LOGGER = Logger.getRootLogger();

	@RequestMapping(value = { "/index", "/" }, method = RequestMethod.GET)
	public ModelAndView getHomePage() throws Exception {
		ModelAndView mav = new ModelAndView("ogp_home_contractual");
		OgpConfig conf = ogpConfigRetriever.getConfig();
		String dataDir = conf.getDataDir();
		ObjectMapper mapper = new ObjectMapper();
		String dataDirInjson = mapper.writeValueAsString(dataDir);
		mav.addObject("dataDir", dataDirInjson);
		System.out.println("========= Data Dir: " + dataDirInjson);
		return mav;
	}

	@RequestMapping(value = "/arealayers", method = RequestMethod.GET)
	public ModelAndView getAreaLayers(@RequestParam(value = "params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("arealayers");
		int farmID = Integer.parseInt(params[0]);
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
		mav.addObject("farmdata", farmInjson);
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
	public ModelAndView getVouchers(@RequestParam(value = "params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("vouchers_manager");
		List<Voucher> vouchers = null;
		try {
			VoucherDAO voucherdao = new VoucherDAO();
			vouchers = voucherdao.getVouchersByFarmID(params[0]);
			voucherdao.closeDBConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (vouchers.size() == 0) {
			vouchers = null;
		}
		ObjectMapper mapper = new ObjectMapper();
		String vouchersInjson = mapper.writeValueAsString(vouchers);
		String selectedfarmid = mapper.writeValueAsString(params[0]);
		mav.addObject("vouchers", vouchersInjson);
		mav.addObject("selectedfarmid", selectedfarmid);
		mav.addObject("lat", params[1]);
		mav.addObject("lng", params[2]);
		return mav;
	}

	@RequestMapping(value = "/addnewvoucher", method = RequestMethod.GET)
	public ModelAndView addNewVoucher(@RequestParam(value = "params") String[] params, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView("vouchers_manager");
		HttpSession httpsession = request.getSession(true);
		String role = null;
		try {
			role = httpsession.getAttribute("UserRole").toString();
			if (role != null) {
				if (role.equals("2") || role.equals("3")) {
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
						//Logging into BeheiraPortal log file
						LOGGER.info("\n========================================================\n"+
								"Request: Add Voucher\n"+
								"Date: " + date+ "\n"+
								"Requested By: " + httpsession.getAttribute("UserName") + "\n"+
								"Role: " + httpsession.getAttribute("UserRole") + "\n"+
								"Result: Succeeded\n"+
								"============================================================");
					} catch (Exception e) {
						LOGGER.info("\n========================================================\n"+
								"\nRequest: Add Voucher\n"+
								"Date: " + date+ "\n"+
								"Requested By: " + httpsession.getAttribute("UserName") + "\n"+
								"Role: " + httpsession.getAttribute("UserRole") + "\n"+
								"Result: Failed\n"+
								"Cause: " + e.getMessage()+
								"\n============================================================");
						e.printStackTrace();
					}
					ObjectMapper mapper = new ObjectMapper();
					String vouchersInjson = mapper.writeValueAsString(vouchers);
					mav.addObject("selectedfarmid", params[2]);
					mav.addObject("vouchers", vouchersInjson);
				}

				else {
					LOGGER.info("\n========================================================\n"+
							"\nRequest: Add Voucher\n"+
							"Requested By: " + httpsession.getAttribute("UserName") + "\n"+
							"Role: " + httpsession.getAttribute("UserRole") + "\n"+
							"Result: Failed\n"+
							"Cause: برجاء المراجعة مع الموظف المختص لتسجيل الايصال"+
							"\n============================================================");
					httpsession.setAttribute("addNewVoucher", "برجاء مراجعة مع موظف لتسجيل ايصال");
				}
			}
		} catch (NullPointerException ne) {
			httpsession.setAttribute("addNewVoucher", "برجاء قم بتسجيل الدخول");
		}
		return mav;
	}

	@RequestMapping(value = "/editvoucher", method = RequestMethod.GET)
	public ModelAndView editVoucher(@RequestParam(value = "params") String[] params, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView("vouchers_manager");
		HttpSession httpsession = request.getSession(true);
		try {
			String role = httpsession.getAttribute("UserRole").toString();
			if (role != null) {
				if (role.equals("2") || role.equals("3")) {
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
						//Logging into BeheiraPortal log file
						LOGGER.info("\n========================================================\n"+
								"Request: Edit Voucher\n"+
								"Date: " + date+ "\n"+
								"Requested By: " + httpsession.getAttribute("UserName") + "\n"+
								"Role: " + httpsession.getAttribute("UserRole") + "\n"+
								"Result: Succeeded\n"+
								"============================================================");
					} catch (Exception e) {
						LOGGER.info("\n========================================================\n"+
								"\nRequest: Edit Voucher\n"+
								"Date: " + date+ "\n"+
								"Requested By: " + httpsession.getAttribute("UserName") + "\n"+
								"Role: " + httpsession.getAttribute("UserRole") + "\n"+
								"Result: Failed\n"+
								"Cause: " + e.getMessage()+
								"\n============================================================");
						e.printStackTrace();
					}
					ObjectMapper mapper = new ObjectMapper();
					String vouchersInjson = mapper.writeValueAsString(vouchers);
					mav.addObject("selectedfarmid", params[2]);
					mav.addObject("vouchers", vouchersInjson);
				} else {
					LOGGER.info("\n========================================================\n"+
							"\nRequest: Edit Voucher\n"+
							"Requested By: " + httpsession.getAttribute("UserName") + "\n"+
							"Role: " + httpsession.getAttribute("UserRole") + "\n"+
							"Result: Failed\n"+
							"Cause: برجاء المراجعة مع الموظف المختص"+
							"\n============================================================");
					httpsession.setAttribute("editVoucher", "برجاء مراجعة مع موظف لتسجيل ايصال");
				}
			}
		} catch (NullPointerException ne) {
			httpsession.setAttribute("editVoucher", "برجاء قم بتسجيل الدخول");
		}
		return mav;
	}

	@RequestMapping(value = "/deletevoucher", method = RequestMethod.GET)
	public ModelAndView deleteVoucher(@RequestParam(value = "params") String[] params, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView("vouchers_manager");
		HttpSession httpsession = request.getSession(true);
		try {
			String role = httpsession.getAttribute("UserRole").toString();
			if (role != null) {
				if (role.equals("2") || role.equals("3")) {
					int voucherID = Integer.parseInt(params[0]);
					String farmID = params[1];
					List<Voucher> vouchers = null;
					try {
						VoucherDAO voucherdao = new VoucherDAO();
						boolean deleteResult = voucherdao.deleteByVoucherID(voucherID);
						vouchers = voucherdao.getVouchersByFarmID(farmID);
						voucherdao.closeDBConn();
						//Logging into BeheiralPortal log file
						LOGGER.info("\n========================================================\n"+
								"Request: Delete Voucher\n"+
								"Requested By: " + httpsession.getAttribute("UserName") + "\n"+
								"Role: " + httpsession.getAttribute("UserRole") + "\n"+
								"Result: Succeeded\n"+
								"============================================================");
					} catch (Exception e) {
						LOGGER.info("\n========================================================\n"+
								"\nRequest: Delete Voucher\n"+
								"Requested By: " + httpsession.getAttribute("UserName") + "\n"+
								"Role: " + httpsession.getAttribute("UserRole") + "\n"+
								"Result: Failed\n"+
								"Cause: " + e.getMessage()+
								"\n============================================================");
						e.printStackTrace();
					}
					ObjectMapper mapper = new ObjectMapper();
					String vouchersInjson = mapper.writeValueAsString(vouchers);
					mav.addObject("vouchers", vouchersInjson);
					mav.addObject("selectedfarmid", params[1]);
				} else {
					LOGGER.info("\n========================================================\n"+
							"\nRequest: Delete Voucher\n"+
							"Requested By: " + httpsession.getAttribute("UserName") + "\n"+
							"Role: " + httpsession.getAttribute("UserRole") + "\n"+
							"Result: Failed\n"+
							"Cause: برجاء المراجعة مع الموظف المختص"+
							"\n============================================================");
					httpsession.setAttribute("deletevoucher", "برجاء مراجعة مع موظف لتسجيل ايصال");
				}
			}
		} catch (NullPointerException ne) {
			httpsession.setAttribute("deletevoucher", "برجاء قم بتسجيل الدخول");
		}
		return mav;
	}

	@RequestMapping(value = "/searchforfarms", method = RequestMethod.GET)
	public ModelAndView searchForFarms() throws Exception {
		ModelAndView mav = new ModelAndView("farm_manager");
		return mav;
	}

	@RequestMapping(value = "/editfarmdata", method = RequestMethod.GET)
	public ModelAndView updateFarmData(@RequestParam(value = "params") String[] params, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView("farm_manager");
		HttpSession httpsession = request.getSession(true);
		String role = httpsession.getAttribute("UserRole").toString();
		if (role != null) {
			if (role.equals("2") || role.equals("3")) {
				Farm farm = new Farm();
				farm.setFarmID(Integer.parseInt(params[0]));
				farm.setFarmName(params[1]);
				farm.setOwnerName(params[2]);
				farm.setOwnerID(params[3]);
				farm.setTelephone(params[4]);
				if (params[5].equals("")) {
					params[5] = "غير متوفر";
				}
				farm.setOwnership(params[5]);
				List<Farm> farmsList = null;
				try {
					FarmDAO farmdao = new FarmDAO();
					boolean updateResult = farmdao.updateFarm(farm);
					farmsList = farmdao.getAllFarms(params[1], params[3], params[2], params[4], params[5]);
					farmdao.closeDBConn();
					//Logging into BeheiraPortal log file
					LOGGER.info("\n========================================================\n"+
							"Request: Update Farm Data\n"+
							"Requested By: " + httpsession.getAttribute("UserName") + "\n"+
							"Role: " + httpsession.getAttribute("UserRole") + "\n"+
							"Farm ID: " + Integer.parseInt(params[0]) + "\n"+
							"Farm Name: " + params[1] + "\n"+
							"Farm Owner: " + params[2] + "\n"+
							"Result: Succeeded\n"+
							"============================================================");
				} catch (Exception e) {
					LOGGER.info("\n========================================================\n"+
							"Request: Update Farm Data\n"+
							"Requested By: " + httpsession.getAttribute("UserName") + "\n"+
							"Role: " + httpsession.getAttribute("UserRole") + "\n"+
							"Farm ID: " + Integer.parseInt(params[0]) + "\n"+
							"Farm Name: " + params[1] + "\n"+
							"Farm Owner: " + params[2] + "\n"+
							"Result: Failed\n"+
							"Cause: " + e.getMessage()+
							"\n============================================================");
					e.printStackTrace();
				}
				ObjectMapper mapper = new ObjectMapper();
				String farmsInjson = mapper.writeValueAsString(farmsList);
				mav.addObject("farms", farmsInjson);
			} else {
				LOGGER.info("\n========================================================\n"+
						"\nRequest: Update Farm Data\n"+
						"Requested By: " + httpsession.getAttribute("UserName") + "\n"+
						"Role: " + httpsession.getAttribute("UserRole") + "\n"+
						"Result: Failed\n"+
						"Cause: برجاء المراجعة مع الموظف المختص"+
						"\n============================================================");
				httpsession.setAttribute("updateFarmData", "برجاء مراجعة مع موظف المختص");
			}
		} else {
			httpsession.setAttribute("updateFarmData", "برجاء قم بتسجيل الدخول");
		}
		return mav;
	}

	@RequestMapping(value = "/getallfarms", method = RequestMethod.GET)
	public ModelAndView getAllFarms(@RequestParam(value = "params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("farm_manager");
		List<Farm> farmsList = null;
		try {
			FarmDAO farmdao = new FarmDAO();
			farmsList = farmdao.getAllFarms(params[0], params[1], params[2], params[3], params[4]);
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
	public ModelAndView getAllAvailableFarms(@RequestParam(value = "params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("ogp_home_contractual");
		List<Farm> farmsList = null;
		try {
			FarmDAO farmdao = new FarmDAO();
			farmsList = farmdao.getAllAvailableFarms();
			farmdao.closeDBConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ObjectMapper mapper = new ObjectMapper();
		String farmsInjson = mapper.writeValueAsString(farmsList);
		mav.addObject("farms", farmsInjson);
		mav.addObject("showfarm_id", params[0]);
		mav.addObject("selectedlat", params[1]);
		mav.addObject("selectedlng", params[2]);
		return mav;
	}

	@RequestMapping(value = "/showonmap", method = RequestMethod.GET)
	public ModelAndView showFarmOnMap(@RequestParam(value = "params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("ogp_home_contractual");
		mav.addObject("showfarm_id", params[0]);
		mav.addObject("selectedlat", params[1]);
		mav.addObject("selectedlng", params[2]);
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

	/////////// user managment//////////
	@RequestMapping(value = "/userlogin", method = RequestMethod.GET)
	public ModelAndView getLogin() throws Exception {
		ModelAndView mav = new ModelAndView("userlogin");
		return mav;
	}

	@RequestMapping(value = { "/user_login" }, method = RequestMethod.GET)
	public String validUser(@RequestParam(value = "params") String[] params, HttpServletRequest request)
			throws Exception {

		ModelAndView mav = new ModelAndView("register_form");
		HttpSession httpsession = request.getSession(true);
		PortalUser user = new PortalUser();
		String path;
		int role;
		String username = params[0];
		String pwd = params[1];
		if (username == null || pwd == null) {
			httpsession.setAttribute("loginmessage", "تحقق من اسم المستخدم أو كلمة المرور");
			path = "redirect:/userlogin";
		} else {
			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();
			boolean exist = tryLogin(username, pwd);
			if (exist) {
				try {
					// request.setAttribute(
					// "message",
					// "Login successful. Welcome. Open <a href='hello'>hello Servlet</a> to check
					// if you are logged in.");
					PortalUserDao userdao = new PortalUserDao(session);
					user = userdao.getUserByName(username);
					httpsession.setAttribute("UserName", params[0]);
					httpsession.setAttribute("UserRole", user.getRoleid());
					String rolel = httpsession.getAttribute("UserRole").toString();
					if (user.getRoleid() == 2) {
						path = "redirect:/adminManage";

					} else {
						path = "redirect:/index";
					}
				}

				finally {
					session.getTransaction().commit();
					if (session.isOpen())
						session.close();
				}
			} else {
				httpsession.setAttribute("loginmessage", "تحقق من اسم المستخدم أو كلمة المرور");
				path = "redirect:/userlogin";
			}
		}
		return path;
	}

	@RequestMapping(value = { "/userlogout" }, method = RequestMethod.GET)
	public String getuserLogout(HttpServletRequest request) {
		//Logging into BeheiraPortal
		LOGGER.info("\n========================================================\n"+
				"Request: Log Out\n"+
				"Requested By: " + request.getSession().getAttribute("UserName") + "\n"+
				"Result: Logged out successfully"+
				"\n============================================================");
		request.getSession().removeAttribute("UserName");
		org.apache.shiro.subject.Subject currentUser = SecurityUtils.getSubject();
		currentUser.logout();
		return "redirect:/index";
	}

	@RequestMapping(value = "/register_form", method = RequestMethod.GET)
	public ModelAndView getRegisterForm() throws Exception {
		ModelAndView mav = new ModelAndView("register_form");
		return mav;
	}

	@RequestMapping(value = "/registerForm", method = RequestMethod.GET)
	public ModelAndView addUserRegisterForm(@RequestParam(value = "params") String[] params, HttpServletRequest request)
			throws Exception {

		ModelAndView mav = new ModelAndView("register_form");
		PortalUser user = new PortalUser();

		// HttpSession session = request.getSession(true);
		int added;
		String name = params[0];
		String Email = params[1];
		String Password = params[2];
		String IdentificationID = params[3];
		String Phone = params[4];
		boolean exist;
		if (name.isEmpty() || Email.isEmpty() || Password.isEmpty() || Phone.isEmpty() || IdentificationID.isEmpty()) {
			request.setAttribute("message", "برجاء ملاء كل بيانات");
		} else {
			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();
			try {
				PortalUserDao userdao = new PortalUserDao(session);
				exist = userdao.SelectSpecificUser(name);
				if (!exist) {
					registrate(session, name, Password, Email, Phone, IdentificationID);
					request.setAttribute("message", "تم اضافة المستخدم بنجاح");
				} else {
					request.setAttribute("message", "تم اضافةاسم المستخدم سابقا");
				}
			}
			
			finally {
                           
				try
                                {
                                    session.getTransaction().commit();
                                   
				if (session.isOpen())
					session.close();
                                }
                           
                            catch(HibernateException ex )
			{
                            request.setAttribute("message", "حدث خطا اثناء الحفظ برجاء محاولة لاحقا ");
				
			}
			}
                         
			mav = new ModelAndView("userlogin");
		}

		return mav;
	}

	private void generatePassword(PortalUser user, String plainTextPassword) {
		RandomNumberGenerator rng = new SecureRandomNumberGenerator();
		Object salt = rng.nextBytes();
		// Now hash the plain-text password with the random salt and multiple
		// iterations and then Base64-encode the value (requires less space than
		// Hex):
		String hashedPasswordBase64 = new Sha256Hash(plainTextPassword, salt, 1024).toBase64();

		user.setPassword(hashedPasswordBase64);
		user.setSalt(salt.toString());
	}

	private void registrate(Session session, String name, String plainTextPassword, String mail, String phone,
			String identificationID) {
		PortalUser user = new PortalUser();
               // user.setId(1);

		user.setName(name);
		user.setPassword(plainTextPassword);
		user.setEmail(mail);
		user.setPhoneNumber(phone);
		user.setRoleid(1);
		user.setIdentificationID(identificationID);
		Date date = new Date();
		//DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		
		generatePassword(user, plainTextPassword);
		// user.getPassword();
             
		session.save(user);
        try {
        	//date = formatter.parse(date.toString());
			//Logging into BeheiraPortal     
			LOGGER.info("\n========================================================\n"+
					"Request: User Registeration\n"+
					"Date: " + date + "\n"+
					"Requested By: " + user.getName() + "\n"+
					"Result: Succeeded\n"+
					"============================================================");  
        } catch(Exception e)
        {
        	LOGGER.info("\n========================================================\n"+
					"Request: User Registeration\n"+
					"Date: " + date + "\n"+
					"Requested By: " + user.getName() + "\n"+
					"Result: Faild\n"+
					"Cause: " + e.getMessage()+ 
					"\n============================================================");  
        	System.err.println("User with email:" + user.getEmail() + " hashedPassword:" + user.getPassword() + " salt:"
    				+ user.getSalt());
        }
		/*System.err.println("User with email:" + user.getEmail() + " hashedPassword:" + user.getPassword() + " salt:"
				+ user.getSalt());*/

		// create role
		/*
		 * if (isAdmin) { UserRole role = new UserRole(); role.setEmail(email);
		 * role.setRoleName("admin"); session.save(role); }
		 */

	}

	// login
	public boolean tryLogin(String username, String password) {
		// get the currently executing user:
		Subject currentUser = SecurityUtils.getSubject();

		if (!currentUser.isAuthenticated()) {

			UsernamePasswordToken token = new UsernamePasswordToken(username, password);
			try {
				currentUser.login(token);
				// currentUser.isPermitted("admin:access");
				//Logging into BeheiraPortal
				LOGGER.info("\n========================================================\n"+
						"Request: Log In\n"+
						"Requested By: " + currentUser.getPrincipal().toString() + "\n"+
						"Date: " + currentUser.getSession().getLastAccessTime()+ "\n"+
						"Result: Logged in successfully"+
						"\n============================================================");
				//System.out.println("User [" + currentUser.getPrincipal().toString() + "] logged in successfully.");

				currentUser.getSession().setAttribute("username", username);

				return true;
			} catch (UnknownAccountException uae) {
				//Logging into BeheiraPortal
				LOGGER.info("\n========================================================\n"+
						"Request: Log In\n"+
						"Requested By: " + currentUser.getPrincipal().toString() + "\n"+
						"Date: " + currentUser.getSession().getLastAccessTime()+ "\n"+
						"Result: Fail\n"+
						"Cause: There is no user with username of " + token.getPrincipal() +
						"\n============================================================");
				//System.out.println("There is no user with username of " + token.getPrincipal());
			} catch (IncorrectCredentialsException ice) {
				//Logging into BeheiraPortal
				LOGGER.info("\n========================================================\n"+
						"Request: Log In\n"+
						"Requested By: " + currentUser.getPrincipal().toString() + "\n"+
						"Date: " + currentUser.getSession().getLastAccessTime()+
						"Result: Fail\n"+
						"Cause: Password for account " + token.getPrincipal() + " was incorrect!"+
						"\n============================================================");
				//System.out.println("Password for account" + token.getPrincipal() + " was incorrect!");
			} catch (LockedAccountException lae) {
				//Logging into BeheiraPortal
				LOGGER.info("\n========================================================\n"+
						"Request: Log In\n"+
						"Requested By: " + currentUser.getPrincipal().toString() + "\n"+
						"Date: " + currentUser.getSession().getLastAccessTime()+ "\n"+
						"Result: Fail\n"+
						"Cause: The account for username " + token.getPrincipal() + " is locked. Please contact your administrator to unlock it."+
						"\n============================================================");
				/*System.out.println("The account for username " + token.getPrincipal() + " is locked.  "
						+ "Please contact your administrator to unlock it.");*/
			} catch (AuthenticationException ae) {

			}
		} else {
			return true; // already logged in
		}

		return false;
	}

	@RequestMapping(value = "/adminManage", method = RequestMethod.GET)
	public ModelAndView getUsers(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("adminManage");
		List<PortalUser> users = null;
		Session session = HibernateUtil.getSessionFactory().openSession();
		session.beginTransaction();
		HttpSession httpsession = request.getSession(true);
		try {
			String role = httpsession.getAttribute("UserRole").toString();
			if (role != null) {
				if (role.equals("2")) {
					try {

						PortalUserDao userdao = new PortalUserDao(session);
						users = userdao.getAllUsers();

					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						session.getTransaction().commit();
						if (session.isOpen())
							session.close();
					}
					if (users.size() == 0) {
						users = null;
					}
					ObjectMapper mapper = new ObjectMapper();
					String usersInjson = mapper.writeValueAsString(users);
					mav.addObject("users", usersInjson);
				} else {
					request.setAttribute("adminmessage", "غير مسموح بدخول هذه الصفحة");
				}
			}
		} catch (NullPointerException ne) {
			request.setAttribute("adminmessage", "غير مسموح بدخول هذه الصفحة");
		}
		return mav;
	}

	@RequestMapping(value = { "/edituserrole" }, method = RequestMethod.GET)
	public ModelAndView editUserRole(@RequestParam(value = "params") String[] params, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView("adminManage");
		boolean updated = false;
		PortalUser user = new PortalUser();
		List<PortalUser> users = null;
		String userrole = params[0];
		String userName = params[1];
		Date date = new Date();
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Session session = HibernateUtil.getSessionFactory().openSession();
		HttpSession httpSession = request.getSession(true);
		session.beginTransaction();
		try {

			PortalUserDao userdao = new PortalUserDao(session);
			RoleDao roledao = new RoleDao();
			roledao.getRoleid(userrole);
			users = userdao.getAllUsers();
			updated = userdao.editUserRole(roledao.getRoleid(userrole), userName);
			date = formatter.parse(date.toString());
			//Logging into BeheiraPortal
			LOGGER.info("\n========================================================\n"+
					"Request: Edit User Role\n"+
					"Requested By: " + httpSession.getAttribute("UserName") + "\n"+
					"Role: Administrator\n"+
					"Date: " + date + "\n" +
					"Result: User Role Updated Successfully"+
					"\n============================================================");

		} catch (Exception e) {
			LOGGER.info("\n========================================================\n"+
					"Request: Edit User Role\n"+
					"Requested By: " + httpSession.getAttribute("UserName") + "\n"+
					"Role: Administrator\n"+
					"Date: " + date + "\n" +
					"Result: Failed"+
					"Cause: "+ e.getMessage() +
					"\n============================================================");
			e.printStackTrace();
		} finally {
			session.getTransaction().commit();
			if (session.isOpen())
				session.close();
		}
		if (updated) {
			request.setAttribute("adminmessage", "تم الحفظ بنجاح");

		} else {
			request.setAttribute("adminmessage", "حدث خطأ اثناء الحفظ");
		}
		ObjectMapper mapper = new ObjectMapper();
		String usersInjson = mapper.writeValueAsString(users);
		mav.addObject("users", usersInjson);

		return mav;
	}

}
