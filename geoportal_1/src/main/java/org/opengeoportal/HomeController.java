package org.opengeoportal;

import java.util.HashSet;
import java.util.Set;

import org.opengeoportal.config.ogp.OgpConfig;
import org.opengeoportal.config.ogp.OgpConfigRetriever;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	@Autowired
	private OgpConfigRetriever ogpConfigRetriever;

	final Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = { "/index", "/" }, method = RequestMethod.GET)
	public ModelAndView getHomePage() throws Exception {
		ModelAndView mav = new ModelAndView("ogp_home_contractual");
		addConfig(mav);
		return mav;
	}
	
	@RequestMapping(value = "/area0layers", method = RequestMethod.GET)
	public ModelAndView getArea0Layers() throws Exception {
		ModelAndView mav = new ModelAndView("area0layers");
		addConfig(mav);
		return mav;
	}
	@RequestMapping(value = "/area1layers", method = RequestMethod.GET)
	public ModelAndView getArea1Layers() throws Exception {
		ModelAndView mav = new ModelAndView("area1layers");
		addConfig(mav);
		return mav;
	}
	@RequestMapping(value = "/area2layers", method = RequestMethod.GET)
	public ModelAndView getArea2Layers() throws Exception {
		ModelAndView mav = new ModelAndView("area2layers");
		addConfig(mav);
		return mav;
	}
	@RequestMapping(value = "/area3layers", method = RequestMethod.GET)
	public ModelAndView getArea3Layers() throws Exception {
		ModelAndView mav = new ModelAndView("area3layers");
		addConfig(mav);
		return mav;
	}
	@RequestMapping(value = "/area4layers", method = RequestMethod.GET)
	public ModelAndView getArea4Layers() throws Exception {
		ModelAndView mav = new ModelAndView("area4layers");
		addConfig(mav);
		return mav;
	}
	@RequestMapping(value = "/area5layers", method = RequestMethod.GET)
	public ModelAndView getArea5Layers() throws Exception {
		ModelAndView mav = new ModelAndView("area5layers");
		addConfig(mav);
		return mav;
	}
	@RequestMapping(value = "/area6layers", method = RequestMethod.GET)
	public ModelAndView getArea6Layers() throws Exception {
		ModelAndView mav = new ModelAndView("area6layers");
		addConfig(mav);
		return mav;
	}
	@RequestMapping(value = "/area7layers", method = RequestMethod.GET)
	public ModelAndView getArea7Layers() throws Exception {
		ModelAndView mav = new ModelAndView("area7layers");
		addConfig(mav);
		return mav;
	}
	@RequestMapping(value = "/area8layers", method = RequestMethod.GET)
	public ModelAndView getArea8Layers() throws Exception {
		ModelAndView mav = new ModelAndView("area8layers");
		addConfig(mav);
		return mav;
	}

	@RequestMapping(value = "/ownership", method = RequestMethod.GET)
	public ModelAndView getBeheiraLayers(@RequestParam(value = "ogpids", defaultValue = "") Set<String> layerIds,
			@RequestParam(value = "bbox", defaultValue = "-180,-90,180,90") String bbox,
			@RequestParam(value = "layer[]", defaultValue = "") Set<String> layers,
			@RequestParam(value = "minX", defaultValue = "-180") String minx,
			@RequestParam(value = "maxX", defaultValue = "180") String maxx,
			@RequestParam(value = "minY", defaultValue = "-90") String miny,
			@RequestParam(value = "maxY", defaultValue = "90") String maxy,
			@RequestParam(value = "dev", defaultValue = "false") Boolean isDev) throws Exception {
		ModelAndView mav = new ModelAndView("ogp_home");
		mav.addObject("dev", isDev);
		OgpConfig conf = ogpConfigRetriever.getConfig();
		String ownershipLayers = conf.getOwnershipLayers();
		try {
			String splittedLayers[]= ownershipLayers.split(",");
		    for (String layer: splittedLayers){
		    	layers.add(layer);
		    }
		}catch (Exception e) {
			layers.add(ownershipLayers);
		}
		if (!layerIds.isEmpty()) {
			mav.addObject("shareIds", getQuotedSet(layerIds));
			mav.addObject("shareBbox", bbox);
		} else if (!layers.isEmpty()) {
			minx = "30.1880640858";
			miny = "30.1877615905";
			maxx = "30.2394800807";
			maxy = "30.2331778966";
			mav.addObject("shareIds", getQuotedSet(layers));
			mav.addObject("shareBbox", minx + "," + miny + "," + maxx + "," + maxy);
		} else {
			mav.addObject("shareIds", layerIds);
			mav.addObject("shareBbox", bbox);
		}
		addConfig(mav);
		return mav;

	}

	@RequestMapping(value = "/rent", method = RequestMethod.GET)
	public ModelAndView getFayoumLayers(@RequestParam(value = "ogpids", defaultValue = "") Set<String> layerIds,
			@RequestParam(value = "bbox", defaultValue = "-180,-90,180,90") String bbox,
			@RequestParam(value = "layer[]", defaultValue = "") Set<String> layers,
			@RequestParam(value = "minX", defaultValue = "-180") String minx,
			@RequestParam(value = "maxX", defaultValue = "180") String maxx,
			@RequestParam(value = "minY", defaultValue = "-90") String miny,
			@RequestParam(value = "maxY", defaultValue = "90") String maxy,
			@RequestParam(value = "dev", defaultValue = "false") Boolean isDev) throws Exception {
		ModelAndView mav = new ModelAndView("ogp_home");
		mav.addObject("dev", isDev);
		OgpConfig conf = ogpConfigRetriever.getConfig();
		String rentLayers = conf.getRentLayers();
	    try {
	    	String splittedLayers[]= rentLayers.split(",");
		    for (String layer: splittedLayers){
		    	layers.add(layer);
		    }
		}catch (Exception e) {
			layers.add(rentLayers);
		}
		if (!layerIds.isEmpty()) {
			mav.addObject("shareIds", getQuotedSet(layerIds));
			mav.addObject("shareBbox", bbox);
		} else if (!layers.isEmpty()) {
			minx = "30.1880640858";
			miny = "30.1877615905";
			maxx = "30.2394800807";
			maxy = "30.2331778966";
			mav.addObject("shareIds", getQuotedSet(layers));
			mav.addObject("shareBbox", minx + "," + miny + "," + maxx + "," + maxy);
		} else {
			mav.addObject("shareIds", layerIds);
			mav.addObject("shareBbox", bbox);
		}
		addConfig(mav);
		return mav;
	}

	@RequestMapping(value = "/byforce", method = RequestMethod.GET)
	public ModelAndView getWadiGedeedLayers(@RequestParam(value = "ogpids", defaultValue = "") Set<String> layerIds,
			@RequestParam(value = "bbox", defaultValue = "-180,-90,180,90") String bbox,
			@RequestParam(value = "layer[]", defaultValue = "") Set<String> layers,
			@RequestParam(value = "minX", defaultValue = "-180") String minx,
			@RequestParam(value = "maxX", defaultValue = "180") String maxx,
			@RequestParam(value = "minY", defaultValue = "-90") String miny,
			@RequestParam(value = "maxY", defaultValue = "90") String maxy,
			@RequestParam(value = "dev", defaultValue = "false") Boolean isDev) throws Exception {
		ModelAndView mav = new ModelAndView("ogp_home");
		mav.addObject("dev", isDev);
		OgpConfig conf = ogpConfigRetriever.getConfig();
		String byforceLayers = conf.getByforceLayers();
	    try {
	    	String splittedLayers[]= byforceLayers.split(",");
		    for (String layer: splittedLayers){
		    	layers.add(layer);
		    }
		}catch (Exception e) {
			layers.add(byforceLayers);
		}
		if (!layerIds.isEmpty()) {
			mav.addObject("shareIds", getQuotedSet(layerIds));
			mav.addObject("shareBbox", bbox);
		} else if (!layers.isEmpty()) {
			minx = "30.1880640858";
			miny = "30.1877615905";
			maxx = "30.2394800807";
			maxy = "30.2331778966";
			mav.addObject("shareIds", getQuotedSet(layers));
			mav.addObject("shareBbox", minx + "," + miny + "," + maxx + "," + maxy);
		} else {
			mav.addObject("shareIds", layerIds);
			mav.addObject("shareBbox", bbox);
		}
		addConfig(mav);
		return mav;

	}
	
	
	@RequestMapping(value = "/otherholdings", method = RequestMethod.GET)
	public ModelAndView getQalyoubiaLayers(@RequestParam(value = "ogpids", defaultValue = "") Set<String> layerIds,
			@RequestParam(value = "bbox", defaultValue = "-180,-90,180,90") String bbox,
			@RequestParam(value = "layer[]", defaultValue = "") Set<String> layers,
			@RequestParam(value = "minX", defaultValue = "-180") String minx,
			@RequestParam(value = "maxX", defaultValue = "180") String maxx,
			@RequestParam(value = "minY", defaultValue = "-90") String miny,
			@RequestParam(value = "maxY", defaultValue = "90") String maxy,
			@RequestParam(value = "dev", defaultValue = "false") Boolean isDev) throws Exception {
		ModelAndView mav = new ModelAndView("ogp_home");
		mav.addObject("dev", isDev);
		OgpConfig conf = ogpConfigRetriever.getConfig();
		String otherholdingsLayers = conf.getOtherholdingsLayers();
	    try {
	    	String splittedLayers[]= otherholdingsLayers.split(",");
		    for (String layer: splittedLayers){
		    	layers.add(layer);
		    }
		}catch (Exception e) {
			layers.add(otherholdingsLayers);
		}
		if (!layerIds.isEmpty()) {
			mav.addObject("shareIds", getQuotedSet(layerIds));
			mav.addObject("shareBbox", bbox);
		} else if (!layers.isEmpty()) {
			minx = "30.1880640858";
			miny = "30.1877615905";
			maxx = "30.2394800807";
			maxy = "30.2331778966";
			mav.addObject("shareIds", getQuotedSet(layers));
			mav.addObject("shareBbox", minx + "," + miny + "," + maxx + "," + maxy);
		} else {
			mav.addObject("shareIds", layerIds);
			mav.addObject("shareBbox", bbox);
		}
		addConfig(mav);
		return mav;

	}

	private Set<String> getQuotedSet(Set<String> uqSet) {
		Set<String> quotedSet = new HashSet<String>();
		for (String item : uqSet) {
			quotedSet.add("\"" + item + "\"");
		}
		return quotedSet;
	}

	private void addConfig(ModelAndView mav) {
		OgpConfig conf = ogpConfigRetriever.getConfig();
		mav.addObject("titlePrimary", conf.getPageTitlePrimary());
		mav.addObject("titleOffset", conf.getPageTitleOffset());
		mav.addObject("extraJs", conf.getJsLocalized());
		mav.addObject("extraCss", conf.getCssLocalized());
		mav.addObject("searchUrl", conf.getSearchUrl().toString());
		mav.addObject("analyticsId", conf.getAnalyticsId());
		mav.addObject("loginRepository", conf.getLoginConfig().getRepositoryId());
		mav.addObject("loginType", conf.getLoginConfig().getType());
		mav.addObject("loginUrl", conf.getLoginConfig().getUrl());
		mav.addObject("secureDomain", conf.getLoginConfig().getSecureDomain());
	}
}
