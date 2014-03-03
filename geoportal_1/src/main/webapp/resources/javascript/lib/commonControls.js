/**
 * 
 * @author Chris Barnett
 * 
 */

if (typeof OpenGeoportal === 'undefined') {
	OpenGeoportal = {};
} else if (typeof OpenGeoportal !== "object") {
	throw new Error("OpenGeoportal already exists and is not an object");
}

/**
 * CommonControls constructor this object determines how to render controls
 * common across the application
 * 
 */
OpenGeoportal.CommonControls = function CommonControls() {
	// dependencies; revamp with require.js?
	var template = OpenGeoportal.ogp.appState.get("template");
	this.cart = OpenGeoportal.ogp.appState.get("cart");
	this.previewed = OpenGeoportal.ogp.appState.get("previewed");

	/***************************************************************************
	 * 
	 * Render table columns
	 **************************************************************************/

	// maps returned data type to appropriate image
	this.renderTypeIcon = function(dataType) {
		var typeIcon = OpenGeoportal.Config.DataTypes;
		var params = {};
		params.controlClass = "typeIcon";

		if ((typeof dataType == "undefined") || (dataType === null)) {
			params.displayClass = "undefinedType";
			params.tooltip = "Unspecified";
			params.text = "?";
		} else {
			// dataType = dataType.toLowerCase();
			if (dataType == "Paper Map") {
				dataType = "Paper+Map";
			}
			var iconModel = typeIcon.findWhere({
				value : dataType
			});
			if (typeof iconModel == 'undefined') {
				params.displayClass = "undefinedType";
				params.tooltip = "Unspecified";
				params.text = "?";
			} else {
				params.displayClass = iconModel.get("uiClass");
				params.tooltip = iconModel.get("displayName");
				params.text = "";
			}
		}
		var icon = template.genericIcon(params);

		return icon;
	};

	this.renderExpandControl = function(layerExpanded) {
		var params = {};
		params.text = "";
		params.controlClass = "expandControl";
		if (layerExpanded) {
			params.displayClass = "expanded";
			params.tooltip = "Hide preview controls";
		} else {
			params.displayClass = "notExpanded";
			params.tooltip = "Show preview controls";
		}
		return template.genericControl(params);
	};

	this.renderPreviewControl = function(layerId, access, institution,
			previewState) {
		access = access.toLowerCase();
		institution = institution.toLowerCase();
		var loginModel = OpenGeoportal.ogp.appState.get("login").model;
		var hasAccess = loginModel.hasAccessLogic(access, institution);
		if (hasAccess) {
			return this.renderCheckboxPreviewControl(layerId, previewState);
		} else {
			var canLogin = loginModel.canLoginLogic(institution);
			if (canLogin) {
				return this.renderLoginPreviewControl();
			} else {
				return this.renderLinkControl(layerId);
			}
		}
	};

	// TODO: fix this

	this.renderLinkControl = function(layerId) {
		var params = {};
		params.controlClass = "previewLink";
		params.text = "";
		params.tooltip = "Preview layer at external site.";
		params.displayClass = "";

		return template.genericControl(params);
	};

	this.renderLoginPreviewControl = function() {
		var params = {};
		params.controlClass = "loginButton";
		params.text = "";
		params.tooltip = "Login to access this layer";
		params.displayClass = "login";

		return template.genericControl(params);

	};

	this.renderCheckboxPreviewControl = function(layerId, previewState) {
		var stateVal = null;
		if (typeof previewState !== "undefined") {
			stateValue = previewState;
		} else {
			var currModel = this.previewed.findWhere({
				LayerId : layerId
			});
			stateVal = "off";
			if (typeof currModel !== "undefined") {
				stateVal = currModel.get("preview");
				if (typeof stateVal === "undefined") {
					stateVal = "off";
				}
			}
		}
		var params = {};
		params.controlClass = "previewControl";
		params.text = "";
		switch (stateVal) {
		case "off":
			params.tooltip = "Preview layer on the map";
			params.displayClass = "checkOff";
			break;
		case "on":
			params.tooltip = "Turn off layer preview on the map";
			params.displayClass = "checkOn";
			break;
		default:
			break;
		}

		return template.genericControl(params);
	};

	this.renderDate = function(date) {
		if (typeof date === "undefined") {
			return "";
		}
		if (date.length > 4) {
			date = date.substr(0, 4);
		}
		if (date === "0001") {
			date = "?";
		}
		return date;
	};

	// maps returned source type to appropriate image
	this.renderRepositoryIcon = function(repository) {

		if ((typeof repository === "undefined") || (repository === null)) {
			return "";
		}
		if (repository.length === 0) {
			return "";
		}
		repository = repository.toLowerCase();
		var params = {};
		params.tooltip = "";
		params.displayClass = "undefinedInstitution";
		params.controlClass = "repositoryIcon";
		params.text = "?";
		var repositoryModel = OpenGeoportal.Config.Repositories.get(repository);
		if (typeof repositoryModel === 'undefined') {
			//
		} else {
			params.tooltip = repositoryModel.get("fullName");
			params.displayClass = repositoryModel.get("iconClass");
			params.text = "";
		}
		return template.genericIcon(params);
	};

	this.renderSaveControl = function(layerId) {
		var stateVal = false;
		var selModel = this.cart.findWhere({
			LayerId : layerId
		});
		if (typeof selModel !== 'undefined') {
			stateVal = true;
		}
		var params = {};
		params.controlClass = "saveControl";
		params.text = "";

		if (stateVal === true) {
			params.tooltip = "Remove this layer from your cart.";
			params.displayClass = "inCart";
		} else {
			params.tooltip = "Add this layer to your cart for download.";
			params.displayClass = "notInCart";
		}
		return template.genericControl(params);
	};

	this.renderMetadataControl = function() {

		var params = {};
		params.controlClass = "infoControl";
		params.text = "";

		params.displayClass = "viewMetadataControl";
		params.tooltip = "Show metadata";

		return template.genericControl(params);
	};

	this.renderDownloadControl = function() {
		return template.defaultDownloadCheckbox();
	};

	/*
	 * Metadata control
	 * 
	 */

	this.viewMetadata = function(model) {
		var location = jQuery.parseJSON(model.get("Location"));
		var layerId = model.get("LayerId");
		// should store this somewhere else; some sort of
		// config
		var values = [ "metadataLink", "purl", "libRecord" ];
		if (OpenGeoportal.Utility.hasLocationValue(location, values)) {
			// display external metadata in an iframe
			var url = OpenGeoportal.Utility.getLocationValue(location, values);
			this.viewExternalMetadata(layerId, url);
		} else {
			this.viewMetadataFromSolr(layerId);
		}
	};
	// obtain layer's metadata via jsonp call
	this.viewMetadataFromSolr = function(layerId) {
		// make an ajax call to retrieve metadata
		var solr = new OpenGeoportal.Solr();
		var url = solr.getServerName() + "?"
				+ jQuery.param(solr.getMetadataParams(layerId));
		var query = solr.sendToSolr(url, this.viewMetadataJsonpSuccess,
				this.viewMetadataJsonpError, this);

		// this.analytics.track("Metadata", "Display Metadata", layerId);
	};

	this.viewExternalMetadata = function(layerId, url) {
		var document = template.genericIframe({
			iframeSrc : url,
			iframeClass : "metadataIframe"
		});
		var dialog$ = this.renderMetadataDialog(layerId, document);
		dialog$.dialog("open");
	};

	this.processMetadataSolrResponse = function(data) {
		var solrResponse = data.response;
		var totalResults = solrResponse.numFound;
		if (totalResults != 1) {
			throw new Error("Request for Metadata returned " + totalResults
					+ ".  Exactly 1 was expected.");
			return;
		}
		var doc = solrResponse.docs[0]; // get the first layer object
		return doc;
	};
	// handles jsonp response from request for metadata call
	this.viewMetadataJsonpSuccess = function(data) {
		try {
			var doc = this.processMetadataSolrResponse(data);
			var metadataRawText = doc.FgdcText;
			var layerId = doc.LayerId;

			var xmlDocument = null;
			try {
				xmlDocument = jQuery.parseXML(metadataRawText);
			} catch (e) {
				throw new Error(
						"Error parsing returned XML: the document may be invalid.");
			}
			var document = null;
			try {
				document = this.renderXmlMetadata(xmlDocument);
			} catch (e) {
				throw new Error(
						"Error transforming XML document: the document may be of the wrong type.");
			}
			var dialog$ = this.renderMetadataDialog(layerId, document);
			this.addMetadataDownloadButton(dialog$, layerId);
			this.addScrollMetadataToTop();

			dialog$.dialog("open");
		} catch (e) {
			console.log(e);
			throw new Error("Error opening the metadata dialog.");
		}

	};

	this.renderMetadataDialog = function(layerId, document) {
		var dialogId = "metadataDialog";
		if (typeof jQuery('#' + dialogId)[0] == 'undefined') {
			jQuery('#dialogs').append(template.genericDialogShell({
				id : dialogId
			}));
		}

		var metadataDialog$ = jQuery("#" + dialogId);
		// should remove any handlers w/in #metadataDialog
		// can't pass the document directly into the template; it just evaluates
		// as a string
		metadataDialog$.html(template.metadataContent({
			layerId : layerId
		})).find("#metadataContent").append(document);
		try {
			metadataDialog$.dialog("destroy");
		} catch (e) {
		}

		var dialogHeight = 400;
		metadataDialog$.dialog({
			zIndex : 9999,
			width : 630,
			height : dialogHeight,
			title : "Metadata",
			autoOpen : false
		});

		return metadataDialog$;
	};

	this.addScrollMetadataToTop = function() {
		var content$ = jQuery("#metadataContent");
		content$.prepend(template.toMetadataTop());
		content$[0].scrollTop = 0;

		// event handlers
		content$.find("a").click(function(event) {
			var toId = jQuery(this).attr("href");
			if (toId.indexOf("#") == 0) {
				event.preventDefault();
				// parse the hrefs for the anchors in this DOM element into toId
				// current xsl uses names instead of ids; yuck
				toId = toId.substring(1);
				content$.scrollTo(jQuery('[name="' + toId + '"]'));
			}
		});

		jQuery("#toMetadataTop").on("click", function() {
			jQuery("#metadataContent")[0].scrollTop = 0;
		});
	};

	this.addMetadataDownloadButton = function(metadataDialog$, layerId) {
		var buttonId = "metadataDownloadButton";
		if (jQuery("#" + buttonId).length == 0) {
			var params = {};
			params.displayClass = "ui-titlebar-button";
			params.buttonId = buttonId;
			params.buttonLabel = "Download Metadata (XML)";
			metadataDialog$.parent().find(".ui-dialog-titlebar").first()
					.prepend(template.dialogHeaderButton(params));
			jQuery("#" + buttonId).button();
		}

		jQuery("#" + buttonId).off();
		var that = this;
		jQuery("#" + buttonId).on("click", function() {
			that.downloadMetadata(layerId);
		});
	};

	this.renderXmlMetadata = function(xmlMetadataDocument) {
		var url = this.chooseStyleSheet(xmlMetadataDocument);
		var xslDocument = this.retrieveStyleSheet(url);
		return this.transformXml(xmlMetadataDocument, xslDocument);
	};

	this.chooseStyleSheet = function(metadataDocument) {
		var stylesheetPath = "resources/xml/";
		var ISO_19139_styleSheet = "isoBasic.xsl";
		var FGDC_styleSheet = "FGDC_V2_a.xsl";
		var xslUrl = null;

		if (metadataDocument.firstChild.localName == "MD_Metadata") {
			// ISO 19139 stylesheet
			xslUrl = ISO_19139_styleSheet;
		} else {
			// FGDC stylesheet
			xslUrl = FGDC_styleSheet;
		}
		xslUrl = stylesheetPath + xslUrl;

		return xslUrl;
	};

	this.retrieveStyleSheet = function(url) {
		var styleSheet = null;

		var params = {
			url : url,
			async : false,
			dataType : 'xml',
			success : function(data) {
				styleSheet = data;
			}
		};
		jQuery.ajax(params);
		return styleSheet;
	};

	this.transformXml = function(xmlDocument, styleSheet) {
		var resultDocument = null;
		if (styleSheet !== null) {
			if (window.ActiveXObject) {
				// IE
				resultDocument = xmlDocument.transformNode(styleSheet);
			} else {
				var xsltProcessor = new XSLTProcessor();
				xsltProcessor.importStylesheet(styleSheet);
				resultDocument = xsltProcessor.transformToFragment(xmlDocument,
						window.document);
			}
		}
		return resultDocument;
	};

	this.downloadMetadata = function downloadMetadata(layerId) {
		var iframeSource = "getMetadata/download?id=" + layerId;
		this.iframeDownload("metadataDownloadIframe", iframeSource);

		// this.analytics.track("Metadata", "Download Metadata", layerId);
	};

	this.iframeDownload = function(iframeClass, iframeSrc) {
		var newIframe = template.iframeDownload({
			iframeClass : iframeClass,
			iframeSrc : iframeSrc
		});
		var iframe$ = jQuery(newIframe).appendTo('#iframes');
		var timeout = 1 * 120 * 1000;// allow 2 minute for download before
		// iframe
		// is removed
		jQuery(document).on("iframeload", iframe$, function() {
			setTimeout(function() {
				iframe$.remove();
			}, timeout);
		});
	};

	// handles jsonp response from request for metadata call
	this.viewMetadataJsonpError = function() {
		throw new Error(
				"The attempt to retrieve metadata for this layer failed.");
	};

	this.goToExternal = function(url) {
		window.open(url);

	};

	this.solrAutocomplete = function(textField$, solrField) {
		textField$.autocomplete({
			source : function(request, response) {
				var solr = new OpenGeoportal.Solr();
				var facetSuccess = function(data) {
					var labelArr = [];
					var dataArr = data.terms[solrField];
					for ( var i in dataArr) {
						if (i % 2 != 0) {
							continue;
						}
						var temp = {
							"label" : dataArr[i],
							"value" : '"' + dataArr[i] + '"'
						};
						labelArr.push(temp);
						i++;
						i++;
					}
					response(labelArr);
				};
				var facetError = function() {
				};
				solr.termQuery(solrField, request.term, facetSuccess,
						facetError, this);

			},
			minLength : 2,
			select : function(event, ui) {

			},
			open : function() {
				jQuery(this).removeClass("ui-corner-all").addClass(
						"ui-corner-top");
			},
			close : function() {
				jQuery(this).removeClass("ui-corner-top").addClass(
						"ui-corner-all");
			}
		});
	};

	this.geocodeAutocomplete = function(geocodeField$) {
		var geocodeResponse = {};
		var that = this;
		geocodeField$.autocomplete({
			source : function(request, response) {
				geocodePromise = that.getGeocodePromise(request.term);
				jQuery.when(geocodePromise).then(function(message) {
					geocodeResponse = message;
					response(geocodeResponse.labels);
				});

			},
			minLength : 3,
			delay : 200,
			select : function(event, ui) {
				for ( var i in geocodeResponse.values) {
					if (geocodeResponse.values[i].name === ui.item.value) {
						geocodeField$.data({
							"geocode" : geocodeResponse.values[i]
						});
						return;
					}
				}
			},

			open : function() {
				jQuery(this).removeClass("ui-corner-all").addClass(
						"ui-corner-top");
			},
			close : function() {
				jQuery(this).removeClass("ui-corner-top").addClass(
						"ui-corner-all");
			}
		});
	};

	this.geocoder = new google.maps.Geocoder();
	/**
	 * geocodes the value typed into the geocoder text input using the Google
	 * maps geocoder,
	 */
	this.getGeocodePromise = function(locationTerm) {
		var dfd = new jQuery.Deferred();
		this.geocoder.geocode({
			'address' : locationTerm
		}, function(results, status) {
			/*
			 * 
			 * "OK" indicates that no errors occurred; the address was
			 * successfully parsed and at least one geocode was returned.
			 * "ZERO_RESULTS" indicates that the geocode was successful but
			 * returned no results. This may occur if the geocode was passed a
			 * non-existent address or a latlng in a remote location.
			 * "OVER_QUERY_LIMIT" indicates that you are over your quota.
			 * "REQUEST_DENIED" indicates that your request was denied,
			 * generally because of lack of a sensor parameter.
			 * "INVALID_REQUEST" generally indicates that the query (address or
			 * latlng) is missing. UNKNOWN_ERROR indicates that the request
			 * could not be processed due to a server error. The request may
			 * succeed if you try again
			 */
			var geocodeResponse = {
				labels : [],
				values : []
			};
			// var labelArr = [];

			if (status === "OK") {

				for ( var i in results) {
					var viewPort = results[i].geometry.viewport;
					var extent = [];
					extent.push(viewPort.getSouthWest().lng());
					extent.push(viewPort.getSouthWest().lat());
					extent.push(viewPort.getNorthEast().lng());
					extent.push(viewPort.getNorthEast().lat());

					var bbox = extent.join();
					var currentAddress = results[i].formatted_address;
					var currentResponse = {};
					currentResponse.name = currentAddress;
					currentResponse.bbox = bbox;
					currentResponse.fullResponse = results[i];
					geocodeResponse.values.push(currentResponse);
					geocodeResponse.labels.push(currentAddress);

				}
			} else if (status === "ZERO_RESULTS") {
				geocodeResponse.labels.push("No results found.");
			} else {
				geocodeResponse.labels.push("Error retrieving results.");
			}
			dfd.resolve(geocodeResponse);
		});

		return dfd.promise();
	};

	this.getShortenLinkPromise = function(longLink) {
		var dfd = new jQuery.Deferred();

		var request = {
			"link" : longLink
		};
		var url = "shortenLink";
		var ajaxArgs = {
			url : url,
			data : jQuery.param(request),
			type : "GET",
			dataType : "json",
			success : function(data) {
				// var shortLink = data["shortLink"];
				dfd.resolve(data);
			}
		};

		jQuery.ajax(ajaxArgs);
		return dfd.promise();
	};

	this.appendButton = function(parent$, buttonId, buttonLabel, clickHandler) {
		// var that = this;
		var html = template.genericButton({
			buttonId : buttonId,
			buttonLabel : buttonLabel
		});
		jQuery(html).appendTo(parent$).hide();
		var button$ = jQuery("#" + buttonId);
		button$.button({
			create : function(event, ui) {
				jQuery(this).show();
			}
		}).on("click", clickHandler);
		return button$;
	};

	this.prependButton = function(parent$, buttonId, buttonLabel, clickHandler) {
		// var that = this;
		var html = template.genericButton({
			buttonId : buttonId,
			buttonLabel : buttonLabel
		});
		jQuery(html).prependTo(parent$).hide();
		var button$ = jQuery("#" + buttonId);
		button$.button({
			create : function(event, ui) {
				jQuery(this).show();
			}
		}).on("click", clickHandler);
		return button$;
	};

	this.genericModalDialog = function(customMessage, dialogTitle) {

		var divId = "genericModalDialog" + jQuery('.genericModalDialog').size();
		var div = '<div id="' + divId + '" class="dialog genericModalDialog">';
		div += customMessage;
		div += '</div>';
		jQuery('#dialogs').append(div);

		jQuery('#' + divId).dialog({
			zIndex : 2999,
			title : dialogTitle,
			resizable : true,
			modal : true,
			minWidth : 415,
			autoOpen : false
		});

		jQuery('#' + divId).dialog('open');
		return divId;
	};

	// used in geoCommonsExport.js...anywhere else?
	this.dialogTemplate = function dialogTemplate(dialogDivId, dialogContent,
			dialogTitle, buttonsObj) {
		if (typeof jQuery('#' + dialogDivId)[0] === 'undefined') {
			var dialogDiv = '<div id="' + dialogDivId + '" class="dialog"> \n';
			dialogDiv += dialogContent;
			dialogDiv += '</div>\n';
			jQuery('#dialogs').append(dialogDiv);
			jQuery("#" + dialogDivId).dialog({
				zIndex : 3000,
				autoOpen : false,
				width : 'auto',
				title : dialogTitle,
				resizable : true,
				buttons : buttonsObj
			});
		} else {
			// replace dialog text/controls & open the instance of 'dialog' that
			// already exists
			jQuery("#" + dialogDivId).html(dialogContent);
			jQuery("#" + dialogDivId).dialog("option", "buttons", buttonsObj);
		}
		jQuery("#" + dialogDivId).dialog('open');
	};

	this.minimizeDialog = function(dialogId) {
		// 1. collect current state of dialog before minimizing.
		// 2. attach that info to the dialog element (jQuery.data)
		// 3. also attach a flag that indicates minimized or not
		// 4. minimize the dialog. (header bar only)
		// 5. change position to lower right corner (fixed to bottom of window)
		// 6. animate the movement
		// can I just toggle a class?
		// 7. animated message in toolbar that describes what's being done
		if (!this.isDialogMinimized(dialogId)) {
			jQuery("#" + dialogId).data({
				"minimized" : true
			});
			var position = jQuery("#" + dialogId).dialog("option", "position");
			jQuery("#" + dialogId).data({
				"maxPosition" : position
			});
			jQuery("#" + dialogId).parent().children().each(function() {
				if (!jQuery(this).hasClass("ui-dialog-titlebar")) {
					jQuery(this).hide();
				}
			});
			jQuery("#" + dialogId).dialog("option", "position",
					[ "right", "bottom" ]);
			jQuery("#" + dialogId).parent().css("position", "fixed");
		}
	};

	this.isDialogMinimized = function(dialogId) {
		var result;
		if (jQuery("#" + dialogId).data().minimized) {
			result = true;
		} else {
			result = false;
		}
		return result;
	};

	this.maximizeDialog = function(dialogId) {
		// 1. check minimized flag
		// 2. read stored state values
		// 3. apply stored state values
		// 4. animate the movement
		// 5. turn off animated message (?)
		if (this.isDialogMinimized(dialogId)) {
			jQuery("#" + dialogId).parent().children().each(function() {
				if (!jQuery(this).hasClass("ui-dialog-titlebar")) {
					jQuery(this).show();
				}
			});
			jQuery("#" + dialogId).data({
				"minimized" : false
			});
			var position = jQuery("#" + dialogId).data().maxPosition;
			jQuery("#" + dialogId).dialog("option", "position", position);
			jQuery("#" + dialogId).parent().css("position", "absolute");
		}
	};

	this.infoBubble = function(bubbleId, infoHtml, optionsObj) {

		var arrowDirection = "top-arrow";// default value
		if (optionsObj.arrow == 'top') {
			arrowDirection = "top-arrow";
		} else if (optionsObj.arrow == "left") {
			arrowDirection = "left-arrow";
		}
		var closeBubble = '<button class="closeBubble button"></button>';
		var doNotShow = '<label><input type="checkbox"/>Do not show this screen again</label>';
		var infoBubble = '<div class="infoBubbleText triangle-isosceles '
				+ arrowDirection + '">' + closeBubble + infoHtml + doNotShow
				+ '</div>';
		var infoBubbleMain = '<div id="' + bubbleId
				+ '" class="infoBubbleBackground triangle-isoscelesBackground '
				+ arrowDirection + 'Background">' + infoBubble + '</div>';

		jQuery("#infoBubbles").append(infoBubbleMain);
		jQuery("#" + bubbleId).height(optionsObj.height + 4).width(
				optionsObj.width + 4).css("top", optionsObj.top - 2).css(
				"left", optionsObj.left - 2);
		jQuery("#" + bubbleId + " > .infoBubbleText").height(optionsObj.height)
				.width(optionsObj.width);
		var infoBubble$ = jQuery("#" + bubbleId);
		infoBubble$.on("click", ".closeBubble", function() {
			infoBubble$.fadeOut("slow");
		}).fadeIn("slow");

		return infoBubble$;
	};

};