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

	@RequestMapping(value = "/view_beheira", method = RequestMethod.GET)
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
		if (!layerIds.isEmpty()) {
			mav.addObject("shareIds", getQuotedSet(layerIds));
			mav.addObject("shareBbox", bbox);
		} else if (!layers.isEmpty()) {
			mav.addObject("shareIds", getQuotedSet(layers));
			mav.addObject("shareBbox", minx + "," + miny + "," + maxx + "," + maxy);
		} else {
			mav.addObject("shareIds", layerIds);
			mav.addObject("shareBbox", bbox);
		}
		addConfig(mav);
		return mav;

	}

	@RequestMapping(value = "/view_fayoum", method = RequestMethod.GET)
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
		layers.add("NARSS.FAYOUM");
		if (!layerIds.isEmpty()) {
			mav.addObject("shareIds", getQuotedSet(layerIds));
			mav.addObject("shareBbox", bbox);
		} else if (!layers.isEmpty()) {
			minx = "29.75863298227907";
			miny = "28.879101324538016";
			maxx = "31.197188957612415";
			maxy = "29.77685641304137";
			mav.addObject("shareIds", getQuotedSet(layers));
			mav.addObject("shareBbox", minx + "," + miny + "," + maxx + "," + maxy);
		} else {
			mav.addObject("shareIds", layerIds);
			mav.addObject("shareBbox", bbox);
		}
		addConfig(mav);
		return mav;
	}

	@RequestMapping(value = "/view_wadigedeed", method = RequestMethod.GET)
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
		if (!layerIds.isEmpty()) {
			mav.addObject("shareIds", getQuotedSet(layerIds));
			mav.addObject("shareBbox", bbox);
		} else if (!layers.isEmpty()) {
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
