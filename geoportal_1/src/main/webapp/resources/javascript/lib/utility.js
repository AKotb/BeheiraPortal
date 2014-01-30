/* This javascript module includes utility functions for OpenGeoPortal plus
 * extra functions with no current home. OpenGeoportal.Utility is a
 * namespace rather than an object.  The XML functions might go away when we
 * upgrade to a newer version of jQuery, as it contains functions to parse XML.
 * 
 * author: Chris Barnett
 * 
 */

if (typeof OpenGeoportal === 'undefined') {
	OpenGeoportal = {};
} else if (typeof OpenGeoportal !== "object") {
	throw new Error("OpenGeoportal already exists and is not an object");
}

if (typeof OpenGeoportal.Utility === 'undefined') {
	OpenGeoportal.Utility = {};
} else if (typeof OpenGeoportal.Utility !== "object") {
	throw new Error("OpenGeoportal.Utility already exists and is not an object");
}

OpenGeoportal.Utility.ImageLocation = "resources/media/";
OpenGeoportal.Utility.CssLocation = "resources/css/";
OpenGeoportal.Utility.JspfLocation = "jspf/";

OpenGeoportal.Utility.InitSet = false;

OpenGeoportal.Utility.getImage = function(imageName) {
	return OpenGeoportal.Utility.ImageLocation + imageName;
};

OpenGeoportal.Utility.CurrentTab = 0;
OpenGeoportal.Utility.whichTab = function() {
	var tabInfo = {};
	var tabIndex;
	if (arguments.length > 0) {
		tabIndex = arguments[0];
	} else {
		tabIndex = OpenGeoportal.Utility.CurrentTab;
	}
	tabInfo.index = tabIndex;
	switch (tabIndex) {
	case 0:
		tabInfo.name = 'search';
		tabInfo.tableObject = function() {
			return OpenGeoportal.ogp.resultsTableObj;
		};
		tabInfo.tableDiv = 'resultsTable';
		tabInfo.tableName = 'searchResults';
		break;
	case 1:
		tabInfo.name = 'saved';
		tabInfo.tableObject = function() {
			return OpenGeoportal.ogp.cartTableObj;
		};
		tabInfo.tableDiv = 'savedLayersTable';
		tabInfo.tableName = 'savedLayers';
		break;
	default:
		// throw new Error('No tab is selected.');
	}
	return tabInfo;
};

OpenGeoportal.Utility.whichSearch = function() {
	var activeSearchDiv = null;
	jQuery(".searchBox > div").each(function() {
		if (jQuery(this).css("display") == 'block') {
			activeSearchDiv = jQuery(this).attr("id");
		}
	});
	var searchInfo = {};
	// searchInfo.script = 'solrSearchHandler.jsp';
	switch (activeSearchDiv) {
	case "basicSearchBox":
		searchInfo.type = 'basicSearch';
		break;
	case "advancedSearchBox":
		searchInfo.type = 'advancedSearch';
		break;
	default:
		// throw new Error('No tab is selected.');
	}
	return searchInfo;
};

OpenGeoportal.Utility.rgb2hex = function(rgb) {
	rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
	function hex(x) {
		return ("0" + parseInt(x).toString(16)).slice(-2);
	}
	return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
};

OpenGeoportal.Utility.hexFromRGB = function(r, g, b) {
	var hex = [ r.toString(16), g.toString(16), b.toString(16) ];
	jQuery.each(hex, function(nr, val) {
		if (val.length == 1) {
			hex[nr] = '0' + val;
		}
	});
	return hex.join('').toUpperCase();
};

OpenGeoportal.Utility.idEscape = function(domElementId) {
	return domElementId.replace(/(:|\.)/g, '\\$1');
};

/*
 * OpenGeoportal.Utility.getMetadata = function (layerId){ var params = { url:
 * "getMetadata.jsp?layer=" + layerId, dataType: 'xml', success: function(data){
 * console.log(data); } }; jQuery.ajax(params); };
 */

OpenGeoportal.Utility.escapeQuotes = function(stringOfInterest) {
	return stringOfInterest.replace("'", "\\'").replace('"', '\\"');

};

OpenGeoportal.Utility.stripExtraSpaces = function(stringOfInterest) {
	return stringOfInterest.replace("\n", "").replace(/\s+/g, ' ');
};

OpenGeoportal.Utility.loadIndicatorStatus = [];// {selector: "",
// currentRequests: 0}; keep
// track of how many requests
// there are for this spinner

OpenGeoportal.Utility.getIndicatorStatus = function(selector) {
	var indicators = OpenGeoportal.Utility.loadIndicatorStatus;
	for ( var i in indicators) {
		if (indicators[i].selector === selector) {
			return indicators[i];
		}
	}

	return {};
};

OpenGeoportal.Utility.showLoadIndicator = function(selector, options) {
	/*
	 * 
	 * 
	 * Spinners.create('.loading').play(); Spinners.get('.loading').pause();
	 * Spinners.get('.loading').stop(); Spinners.get('.loading').remove();
	 * Spinners.get(document.getElementById('mySpinner')).toggle();
	 * 
	 * 
	 */
	// jQuery(selector).hide();
	var spinner = Spinners.get(selector);
	if (spinner.items().length === 0) {
		// create new spinner
		var params = {
			height : 5,
			width : 5,
			dashes : 8,
			color : '#ffffff'
		};

		if (typeof options != "undefined") {
			params = jQuery.extend(params, options);
		}
		spinner = Spinners.create(selector, params);
	}

	spinner.play();

	var status = OpenGeoportal.Utility.getIndicatorStatus(selector);
	if (typeof status.currentRequests == "undefined") {
		OpenGeoportal.Utility.loadIndicatorStatus.push({
			selector : selector,
			currentRequests : 1
		});
	} else {
		status.currentRequests++;
	}

	jQuery(selector).fadeIn();
};

OpenGeoportal.Utility.hideLoadIndicator = function(selector) {
	var status = OpenGeoportal.Utility.getIndicatorStatus(selector);
	if (typeof status.currentRequests != "undefined") {
		if (status.currentRequests > 0) {
			status.currentRequests--;
		}
	}

	if (typeof status.currentRequests == "undefined"
			|| status.currentRequests === 0) {
		jQuery(selector).fadeOut();

		var spinner = Spinners.get(selector);
		if (spinner.items().length !== 0) {
			spinner.stop();
		}
	}

};

OpenGeoportal.Utility.checkAddress = function(emailAddress) {
	var stringArray = emailAddress.split("@");
	if (stringArray.length < 2) {
		return false;
	} else {
		var domainArray = stringArray[1].split(".");
		var userString = stringArray[0];
		if (domainArray.length < 2) {
			return false;
		} else if ((domainArray[0].length + domainArray[1].length + userString.length) < 3) {
			return false;
		}
	}
	return true;

};

OpenGeoportal.Utility.pluralSuffix = function(totalNumber) {
	var plural;
	if (totalNumber > 1) {
		plural = "s";
	} else {
		plural = "";
	}
	return plural;
};

OpenGeoportal.Utility.doPrint = function() {
	window.print();
	// jQuery('head > link[href="css/print.css"]').remove();
};

OpenGeoportal.Utility.elementFlash = function(el$, offsetColor) {
	if (typeof offsetColor === "undefined") {
		offsetColor = "#0755AC";
	}
	var color = el$.css("color");
	el$.animate({
		color : offsetColor
	}, 125).animate({
		color : color
	}, 125).animate({
		color : offsetColor
	}, 125).animate({
		color : color
	}, 125);
};

OpenGeoportal.Utility.getScrollbarWidth = function() {
	if (!OpenGeoportal.Utility.requiresScrollbarAdjustment()) {
		return 0;
	}
	var outer, outerStyle, scrollbarWidth;
	outer = document.createElement('div');
	outerStyle = outer.style;
	outerStyle.position = 'absolute';
	outerStyle.width = '100px';
	outerStyle.height = '100px';
	outerStyle.overflow = "scroll";
	outerStyle.top = '-9999px';
	document.body.appendChild(outer);
	scrollbarWidth = outer.offsetWidth - outer.clientWidth;
	document.body.removeChild(outer);
	return scrollbarWidth;
};

OpenGeoportal.Utility.requiresScrollbarAdjustment = function() {
	var userAgent = window.navigator.userAgent;
	if (userAgent.indexOf("Macintosh") > 0) {
		return false;
	}
	if (userAgent.indexOf("Chrome") > 0) {
		return false;
	}

	return true;
};

OpenGeoportal.Utility.removeParams = function(url, paramArray) {
	var urlArray = url.split("?");
	var query = urlArray[1];
	var queryArr = query.split("&");
	for ( var i in queryArr) {
		for ( var j in paramArray) {

			if (queryArr[i].indexOf(paramArray[j]) === 0) {
				queryArr[i] = "";
			}
		}
	}

	return urlArray[0] + "?" + queryArr.join("&");
};

OpenGeoportal.Utility.compareUrls = function(url1, url2, ignoreParams) {
	var compareurl1 = OpenGeoportal.Utility.removeParams(url1, ignoreParams);

	var compareurl2 = OpenGeoportal.Utility.removeParams(url2, ignoreParams);
	if (compareurl1 === compareurl2) {
		return true;
	}
	return false;
};
