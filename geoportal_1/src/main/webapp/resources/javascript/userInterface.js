/** 
 * This javascript module includes functions for dealing with the user interface.
 * 
 * @author Chris Barnett
 * 
 */

/**
 * create the namespace objects if they don't already exist
 */
if (typeof OpenGeoportal == 'undefined'){
	OpenGeoportal = {};
} else if (typeof OpenGeoportal != "object"){
	throw new Error("OpenGeoportal already exists and is not an object");
}

OpenGeoportal.UserInterface = function(){
	//default text for the geocoder input box
	this.geocodeText = "Find Place (Example: Boston, MA)";
	//default text for the search input box
	this.searchText = "(Example: Buildings)";

	this.ogp = OpenGeoportal.ogp;
	this.mapObject = this.ogp.map;
	this.resultsTableObject = this.ogp.resultsTableObj;
	this.cartTableObject = this.ogp.cartTableObj;
	this.layerStateObject = this.ogp.layerState;
	this.utility = OpenGeoportal.Utility;
	this.config = OpenGeoportal.InstitutionInfo;
	this.jspfDir = OpenGeoportal.Utility.JspfLocation;
	this.login = new OpenGeoportal.LogIn(this.config.getHomeInstitution());
	this.login.checkLoginStatus();
	var analytics = new OpenGeoportal.Analytics();
	var that = this;

	/**
	 * init function
	 */

	this.initializeTabs = function(){
		jQuery("#tabs").tabs({
			active: 0,
			activate: function( event, ui ) {
				that.utility.CurrentTab = jQuery(this).tabs("option", "active");
				var label,
				idx = ui.index;

				label = (idx == 1) && "Cart Tab" ||
				(idx == 0) && "Search Tab" ||
				"Getting Started Tab";
				analytics.track("Interface", "Change Tab", label);
				var tabObj = that.utility.whichTab();
				switch(tabObj.name){
				case 'search':
					that.filterResults();
					break;
				case 'saved':
					jQuery('#savedLayers').dataTable().fnDraw();
					break;
				}
			}	

		});
	};

	this.tabShowHandler = function(){
		jQuery(document).bind('tabsshow', function(event, ui) {
			var tabObj = that.utility.whichTab();
			switch(tabObj.name){
			case 'search':
				that.filterResults();
				break;
			case 'saved':
				jQuery('#savedLayers').dataTable().fnDraw();
				break;
			}
		});

		jQuery('#tabs a').bind("mousedown", function(){
			//console.log(jQuery(this));
			var tabImage = jQuery(this).find("img");
			if (tabImage.length > 0){
				tabImage.attr("src", that.utility.getImage("shoppingcart_on.png"));
			} else {
				jQuery('#tabs a img').attr("src", that.utility.getImage("shoppingcart.png"));
			};
		});
	};

	this.searchBoxKeypressHandler = function(){
		jQuery('.searchBox').keypress(function(event){
			var type, search, keyword;

			if (event.keyCode == '13') {
				event.preventDefault();
				that.searchSubmit();
				type = OpenGeoportal.Utility.whichSearch().type;
				if (type == "basicSearch") {
					search = "Basic";
					keyword = jQuery("#basicSearchTextField").val();
				} else if (type == "advancedSearch") {
					search = "Advanced";
					keyword = jQuery("#advancedKeywordText").val();
				}
				analytics.track("Search", search, keyword);
			} 
		});
	};

	this.whereHandler = function(){
		jQuery("#geosearch").keypress(function(event){
			if (event.keyCode == '13') {
				var location = jQuery("#geosearch").val();
				that.geocodeLocation();
				analytics.track("Go To Box", location);
			} else if (jQuery(this).val().trim() == that.geocodeText){
				that.clearInput('geosearchDiv');
			}
		});

		//needs to check if the input has focus 
		jQuery("input#geosearch").val(this.geocodeText);
		/*jQuery("input#geosearch").hover(function(){
		    				jQuery(this).css("opacity", "1"); 
		    				jQuery(this).data("mouseOverInput", true); 
		    			}, 
		    			function(){
		    				jQuery(this).data("mouseOverInput", false); 
		    				if(!jQuery(this).is(":focus")){
		    					jQuery(this).css("opacity", ".7");
		    				} 
		    			});
		    jQuery("input#geosearch").focusin(function(){
		    	jQuery(this).css("opacity", "1");});
		    jQuery("input#geosearch").focusout(function(){
		    	if(jQuery(this).data("mouseOverInput") !== true){
		    		jQuery(this).css("opacity", ".5");
		    	}});*/
		jQuery("input#geosearch").click(function(){that.clearInput("geosearchDiv");});
		jQuery("#goButton").click(
				function(){
					var location = jQuery("#geosearch").val();
					that.geocodeLocation();
					analytics.track("Go To Box", location);
				}
		);
	};

	this.searchSubmitHandler = function(){
		jQuery("#advancedSearchSubmit").click(function(){that.searchSubmit()});

		jQuery("#basicSearchTextField").val(this.searchText);
		jQuery("#basicSearchTextField").focusin(function(){
			var current = jQuery(this);
			if (current.val().indexOf(that.searchText) != -1){
				current.val("");
			}
		});
		jQuery("#basicSearchTextField").click(function(){
			var current = jQuery(this);
			if (current.val().indexOf(that.searchText) != -1){
				current.val("");
			}
		});
		jQuery("#basicSearchTextField").keypress(function(){
			var current = jQuery(this);
			if (current.val().indexOf(that.searchText) != -1){
				current.val("");
			}
		});
	};

	this.aboutHandler = function(){
		jQuery('#about').dialog({
			zIndex: 2999,
			title: "ABOUT",
			resizable: false,
			minHeight: 382,
			minWidth: 473,
			autoOpen: false		
		});
		jQuery("#aboutLink").click(function(){
			jQuery('#about').dialog("open");
			analytics.track("Help", "Show About");
		});
	};

	this.contactHandler = function(){
		jQuery('#contact').dialog({
			zIndex: 2999,
			title: "CONTACT INFORMATION",
			resizable: false,
			minHeight: 222,
			minWidth: 405,
			autoOpen: false		
		});
		jQuery("#contactLink").click(function(){
			jQuery('#contact').dialog("open");
		});
	};

	this.userHelpHandler = function(){
		jQuery('#userGuide').dialog({
			zIndex: 2999,
			title: "USER GUIDE",
			resizable: true,
			height: 425,
			width: 745,
			autoOpen: false		
		});
		jQuery("#userGuideLink").click(function(){
			if (jQuery("#userGuide").length == 0){
				jQuery.get(that.jspfDir + "userGuide.jspf", function(data){
					jQuery("body").append(data);
					jQuery("#userGuide").dialog({
						zIndex: 2999,
						title: "USER GUIDE",
						resizable: true,
						height: 425,
						width: 745,
						autoOpen: false	
					});
					that.anchorsToNiceScroll("userGuide", {top: -10, left: -30});
					jQuery('#userGuide').dialog("open");
				});
			} else {
				jQuery('#userGuide').dialog("open");
			}
			analytics.track("Help", "Show User Guide");
		});
	};

	this.mapFilterHandler = function(){
		jQuery("input[name='mapFilterCheck'],input[name='mapFilterCheck2']").on(
				"change", function(ev) {
					var value = this.checked ? "Checked" : "Unchecked";
					analytics.track("Limit Results to Visible Map", value);
				}
		);	
	};

	this.loadIndicatorHandler = function(){
		var loadIndicator = "#mapLoadIndicator";
		jQuery(document).bind("showLoadIndicator",function(e){
			that.utility.showLoadIndicator("mapLoadIndicator");
		});

		jQuery(document).bind("hideLoadIndicator", function(e){
			that.utility.hideLoadIndicator("mapLoadIndicator");
		});
	};

	this.resizeWindowHandler = function(){
		var containerHeight = jQuery(window).height() - jQuery("#header").height() - jQuery("#footer").height() - 2;
		containerHeight = Math.max(containerHeight, 680);
		var containerWidth = jQuery(window).width();//Math.max((Math.floor(jQuery(window).width() * .9)), 1002);
		jQuery('#main').width(containerWidth);
		jQuery('#container').height(containerHeight);
		jQuery('#left_tabs').height(containerHeight);
		jQuery("#left_col").outerWidth(this.getSearchPanelWidth());
		jQuery('#map').width(jQuery("#container").width() - this.getSearchPanelWidth());
		if (parseInt(jQuery("#map").width()) >= 1024) {
			if (this.mapObject.zoom == 0){
				this.mapObject.zoomTo(1);
			}
		}
		jQuery('#container').resize(function() {
			//OpenGeoportal.map.events.triggerEvent('zoomend');
			that.mapObject.events.triggerEvent('zoomend');
		});

		jQuery(window).resize(function(){
			var containerHeight = Math.max((jQuery(window).height() - jQuery("#header").outerHeight() - jQuery("#footer").outerHeight()), 680);
			jQuery('#container').height(containerHeight);
			jQuery('#left_tabs').height(containerHeight);
			var containerWidth = jQuery(window).width();
			jQuery('#main').width(containerWidth);
			if (jQuery("#left_col").css("display") == "none"){
				jQuery('#map').outerWidth(jQuery("#container").width() - jQuery("#roll_right").outerWidth());
			} else if (jQuery("#map").css("display") != "none"){
				//jQuery("#left_col").width(OpenGeoportal.ui.searchPanelWidth);
				var mapWidth = jQuery("#container").width() - jQuery("#left_col").outerWidth();
				var mapZoom = that.mapObject.getZoom();
				var minMapWidth;
				if (mapZoom == 0){
					minMapWidth = 512;
				} else {
					minMapWidth = 1024;
				}
				var containerWidth = jQuery("#container").width();
				//console.log("spw: " + that.getSearchPanelWidth());
				var searchPanelWidth = that.getSearchPanelWidth() || (containerWidth - minMapWidth);
				if ((containerWidth - searchPanelWidth) < minMapWidth){
					searchPanelWidth = containerWidth - minMapWidth;
				}

				jQuery("#left_col").outerWidth(searchPanelWidth);
				jQuery('#map').width(containerWidth - searchPanelWidth);
				that.setSearchPanelWidth(searchPanelWidth);


			} else {
				jQuery("#left_col").outerWidth(jQuery("#container").width());
			}

		});
	};

	this.loginStatusHandler = function(){
		jQuery(document).bind("loginSucceeded", function(){
			jQuery(document).trigger("loginSuccess.addToCart");
			that.applyLoginActions();
			analytics.track("Login", "Login Success");
		});
		jQuery(document).on("loginFailed", function() {
			analytics.track("Login", "Login Failure");
		});	
	};

	//this should probably move
	this.mapControlUIHandler = function(){
		//'hover' for graphics that are not background graphics
		var zoomPlusSelector = '.olControlModPanZoomBar img[id*="zoomin"]';
		jQuery(document).on("mouseenter", zoomPlusSelector, function(){
			jQuery(this).attr("src", that.utility.getImage("slider_plus_hover.png"));
			//jQuery(this).css("cursor", "pointer");
		});

		jQuery(document).on("mouseleave", zoomPlusSelector, function(){
			jQuery(this).attr("src", that.utility.getImage("zoom-plus-mini.png"));
		});

		jQuery(document).on("click", zoomPlusSelector, function(){
			that.mapObject.zoomIn();
		});

		var zoomMinusSelector = '.olControlModPanZoomBar img[id*="zoomout"]';
		jQuery(document).on("mouseenter", zoomMinusSelector, function(){
			jQuery(this).attr("src", that.utility.getImage("slider_minus_hover.png"));
			//jQuery(this).css("cursor", "pointer");
		});

		jQuery(document).on("mouseleave", zoomMinusSelector, function(){
			jQuery(this).attr("src", that.utility.getImage("zoom-minus-mini.png"));
		});

		jQuery(document).on("click", zoomMinusSelector, function(){
			that.mapObject.zoomOut();
		});	

	};

	this.init = function(){
		this.initializeTabs();
		this.tabShowHandler();

		this.togglePanels();
		this.resizePanels();
		this.searchToggleHandler();
		this.updateSortMenuHandler();
		this.colorDialogHandler();

		this.loginHandler();
		this.loginStatusHandler();
		this.logoutResponse();

		this.cartOptionText();
		//set mouse cursor behavior
		this.mouseCursor();

		this.searchBoxKeypressHandler();
		this.whereHandler();
		this.searchSubmitHandler();
		this.mapFilterHandler();

		this.aboutHandler();
		this.contactHandler();
		this.userHelpHandler();

		jQuery("#top_menu > a").on("click", function() {
			analytics.track("Interface", "Reset Page");
		});

		//buttons
		this.createBasemapMenu();
		this.createDataTypesMenu();
		this.createInstitutionsMenu();
		this.createTopicsMenu();
		this.createSortMenu();
		this.createColumnsMenu();

		this.loadIndicatorHandler();

		this.mapControlUIHandler();

		this.autocomplete();

		this.previewViewHandler();

		//need to test if user has done anything before binding this event
		jQuery(document).bind("eventMoveEnd", function(){
			if (that.utility.whichTab().name == 'search'){
				that.filterResults();
			}
		});

		jQuery(document).on('click', '#downloadHeaderCheck', that.toggleChecksSaved);



		jQuery("#searchResultsNavigation").on("click", "a", function() {
			var direction,
			label = jQuery(this).text();

			direction = (label.indexOf("Next") > -1 && "Next") || "Previous";

			analytics.track("Results Pagination", direction + " Results Page");
		});
		jQuery("#main").fadeTo('fast', 1);
	};

	/**
	 * creates the basemap menu from the backgroundMaps object in OpenGeoportal.MapController
	 */
	this.createBasemapMenu = function() {
		//var backgroundMapsConfig = OpenGeoportal.map.backgroundMaps("all");
		var backgroundMapsConfig = this.mapObject.backgroundMaps("all");
		var radioHtml = "";
		for (var mapType in backgroundMapsConfig){
			var isDefault = "";
			//if (mapType == OpenGeoportal.map.getCurrentBackgroundMap()){
			if (mapType == this.mapObject.getCurrentBackgroundMap()){
				isDefault = ' checked="checked"';
			} 
			radioHtml += '<input type="radio" id="basemapRadio' + mapType + '" name="basemapRadio" value="' + mapType + '"' + isDefault + ' onchange="OpenGeoportal.ui.baseMapChanged()" />';
			radioHtml += '<label for="basemapRadio' + mapType + '">' + backgroundMapsConfig[mapType].name + '</label>';
		}
		jQuery("#basemapMenu").html(radioHtml);
		jQuery("[name=basemapRadio]").attr("checked", false);
		//jQuery("[name=basemapRadio]").filter("[value=" + OpenGeoportal.map.getCurrentBackgroundMap() + "]").attr("checked", "checked");
		jQuery("[name=basemapRadio]").filter("[value=" + this.mapObject.getCurrentBackgroundMap() + "]").attr("checked", "checked");
		jQuery("#basemapSelect").button();
		jQuery("#basemapMenu").buttonset();
		jQuery("#basemapDropdown").hover(function(){jQuery("#basemapMenu").show();}, function(){jQuery("#basemapMenu").hide();});
	};

	/**
	 * creates html and behaviours for a css styled dropdown 
	 * 
	 * @param divId the id of the div element to turn into a styled dropdown
	 * @param paramObj .text is the displayed text, .menuHtml is the Html for the dropdown menu
	 */
	this.styledSelect = function(divId, paramObj) {
		var selectElement = jQuery('#' + divId);
		selectElement.addClass("styledDropdown");

		var selectHtml = '<button id="' + divId + 'Select" class="styledButton styledSelect" title="' + paramObj.text + '">';
		selectHtml += '<span class="styledSelectText">' + paramObj.text;
		selectHtml += '</span><div class="styledSelectArrow"></div>';
		selectHtml += '</button>';
		selectHtml += '<div id="' + divId + 'Menu" class="styledSelectMenu">';
		selectHtml += paramObj.menuHtml;
		selectHtml += '</div>';

		selectElement.html(selectHtml);

		jQuery("#" + divId + "Select").button();
		jQuery("#" + divId + "Select .styledSelectText").width(jQuery("#" + divId).width() - jQuery("#" + divId + "Select .styledSelectArrow").width() - 39);
		jQuery("#" + divId + "Menu").buttonset().addClass("raised").hide();
		//jQuery("#sourceCheckMenu").hide();

		selectElement.mouseleave(function(){
			jQuery("#" + divId + "Menu").hide();
		});
		jQuery("#" + divId + "Select").click(function(event){
			var menu = jQuery("#" + divId + "Menu");
			if (menu.css("display") == "none"){
				menu.show();
			} else {
				menu.hide();
			}
		});
	};

	/**
	 * uses styledSelect to create the menu that allows a user to sort the results table by column name; dynamically created from the table object
	 */
	this.createSortMenu = function() {
		var tableObj = this.utility.whichTab().tableObject();
		var fields = tableObj.tableHeadingsObj.getTableHeadings();
		var defaultField = "Relevancy";
		var menuHtml = "";
		for (var sortIndex in fields){
			if (fields[sortIndex].organize){
				var currentField = fields[sortIndex];
				menuHtml += '<label for="sortDropdownRadio' + currentField.columnConfig.sName + '">';
				menuHtml += currentField.displayName;
				menuHtml += '</label>';
				var checked = "";
				if (currentField.displayName.toLowerCase().trim() == defaultField.toLowerCase()){
					checked += " checked=true";
				}
				menuHtml += '<input type="radio" class="sortDropdownRadio" name="sortDropdownRadio" id="sortDropdownRadio' + currentField.columnConfig.sName + '" value="' + currentField.columnConfig.sName + '"' + checked + ' />';
			}
		}
		var params = {
				"menuHtml": menuHtml,
				"text": defaultField
		};
		this.styledSelect("sortDropdown", params);
		jQuery('.sortDropdownRadio').hide();

		var buttonHtml = defaultField; 
		jQuery(".sortDropdownSelect > span > span").html(buttonHtml);
		var that = this;
		jQuery("#sortDropdownMenu span.ui-button-text").bind("click", function(){
			var selectedField = jQuery(this).closest("label").next().val();
			var buttonHtml = fields[selectedField].displayName;
			jQuery("#sortDropdownSelect > span > span").html(buttonHtml);
			that.chooseSort(selectedField);
		});
		jQuery("#sortDropdownSelect").addClass("subHeaderDropdownSelect");
	};

	/**
	 * uses styledSelect to create the menu in advanced search that allows a user to select which institutions to search; dynamically created
	 * from info in OpenGeoportal.InstitutionInfo
	 */
	this.createInstitutionsMenu = function() {
		var institutionConfig = OpenGeoportal.InstitutionInfo.getInstitutionInfo();
		var menuHtml = "";
		for (var institution in institutionConfig){
			menuHtml += '<div>';
			menuHtml += '<label for="sourceCheck' + institution + '">';
			var institutionIcon = institutionConfig[institution]["graphics"]["sourceIcon"];
			menuHtml += '<img src="' + institutionIcon["resourceLocation"] + '" alt="' + institutionIcon["altDisplay"]; 
			menuHtml += ' title="' + institutionIcon["tooltipText"] + '"/>';
			menuHtml += institution;
			menuHtml += '</label>';
			menuHtml += '<input type="checkbox" class="sourceCheck" id="sourceCheck' + institution + '" value="' + institution + '" checked=true />';
			menuHtml += '</div>';
		}
		var params = {
				"menuHtml": menuHtml,
				"text": "Select repositories"
		};
		this.styledSelect("sourceDropdown", params);
		//jQuery("#sourceDropdown .styledSelectMenu").addClass("formCheckbox");
	};

	/**
	 * uses styledSelect to create the menu in advanced search that allows a user to select which data types to search; dynamically created
	 * from info in OpenGeoportal.InstitutionInfo
	 */
	this.createDataTypesMenu = function() {
		var dataTypes = OpenGeoportal.InstitutionInfo.getIcons().dataTypes;
		var menuHtml = "";
		for (var dataTypeIndex in dataTypes){
			menuHtml += '<div>';
			menuHtml += '<label for="dataTypeCheck' + dataTypeIndex + '">';
			menuHtml += '<div class="' + dataTypes[dataTypeIndex]["uiClass"] + '"'; 
			menuHtml += ' title="' + dataTypes[dataTypeIndex]["displayName"] + '"/>';
			menuHtml += dataTypes[dataTypeIndex]["displayName"] + '</label>';
			menuHtml += '<input type="checkbox" class="dataTypeCheck" id="dataTypeCheck' + dataTypeIndex + '" value="' + dataTypeIndex + '" checked=true/>';
			menuHtml += '</div>';
		}
		var params = {
				"menuHtml": menuHtml,
				"text": "Select data types"
		};
		this.styledSelect("dataTypeDropdown", params);
		//jQuery("#dataTypeDropdown .styledSelectMenu").addClass("formCheckbox");

	};

	/**
	 * uses styledSelect to create the menu in advanced search that allows a user to select an ISO topic to search
	 */
	this.createTopicsMenu = function() {
		var topicCategories = [{"topic":"", "label":"None"},
		                       {"topic":"farming", "label":"Agriculture and Farming"},
		                       {"topic":"biota", "label":"Biology and Ecology"},
		                       {"topic":"boundaries", "label":"Administrative and Political Boundaries"},
		                       {"topic":"climatologyMeteorologyAtmosphere", "label":"Atmospheric and Climatic"},
		                       {"topic":"economy", "label":"Business and Economic"},
		                       {"topic":"elevation", "label":"Elevation and Derived Products"},
		                       {"topic":"environment", "label":"Environment and Conservation"},
		                       {"topic":"geoscientificinformation", "label":"Geological and Geophysical"},
		                       {"topic":"health", "label":"Human Health and Disease"},
		                       {"topic":"imageryBaseMapsEarthCover", "label":"Imagery and Base Maps"},
		                       {"topic":"intelligenceMilitary", "label":"Military"},
		                       {"topic":"inlandWaters", "label":"Inland Water Resources"},
		                       {"topic":"location", "label":"Locations and Geodetic Networks"},
		                       {"topic":"oceans", "label":"Oceans and Estuaries"},
		                       {"topic":"planningCadastre", "label":"Cadastral"},
		                       {"topic":"society", "label":"Cultural, Society, and Demographics"},
		                       {"topic":"structure", "label":"Facilities and Structure"},
		                       {"topic":"transportation", "label":"Transportation Networks"},
		                       {"topic":"utilitiesCommunication", "label":"Utilities and Communication"}
		                       ];
		var menuHtml = "";
		for (var topicIndex in topicCategories){
			var currentTopic = topicCategories[topicIndex];
			menuHtml += '<div>';
			menuHtml += '<label for="topicRadio' + currentTopic.topic + '">';
			menuHtml += currentTopic.label;
			menuHtml += '</label>';
			menuHtml += '<input type="radio" class="topicRadio" name="topicRadio" id="topicRadio' + currentTopic.topic + '" value="' + currentTopic.topic + '"/>';
			menuHtml += '</div>';
		}
		var params = {
				"menuHtml": menuHtml,
				"text": "Select a topic"
		};
		this.styledSelect("topicDropdown", params);
		jQuery('.topicRadio').hide();
		jQuery("#topicDropdownSelect > span > span");
		jQuery("#topicDropdownMenu input[type=radio]").first().attr("checked", true);
		jQuery("#topicDropdownMenu span.ui-button-text").bind("click", function(){
			var selectedField = jQuery(this).closest("label").find("span").text();
			jQuery('.topicRadio').attr("checked", false);
			jQuery(this).closest("label").next().attr("checked", true);
			if (selectedField == "None"){
				selectedField = "Select a topic";
			}

			jQuery("#topicDropdownSelect > span > span").html(selectedField);
		});
	};

	/**
	 * uses styledSelect to create the menu above the results table that allows the user to select which columns to display; dynamically created
	 * from the table object
	 */
	this.createColumnsMenu = function() {
		var menuHtml = "";
		var tableObj = this.utility.whichTab().tableObject();
		var fields = tableObj.tableHeadingsObj.getTableHeadings();			
		for (var i in fields){
			if (fields[i].organize){
				if(i == "score"){
					continue;
				}
				menuHtml += '<div>';
				menuHtml += '<label for="columnCheck' + i + '">';
				menuHtml += fields[i].displayName + '</label>';
				var checked = "";
				if (fields[i].columnConfig.bVisible){
					checked = ' checked="checked"';
				}
				menuHtml += '<input type="checkbox" class="columnCheck columnVisibility" id="columnCheck' + i + '" value="' + i + '"' + checked + ' />';
				menuHtml += '</div>';
			}
		}
		var params = {
				"menuHtml": menuHtml,
				"text": "Columns"
		};
		this.styledSelect("columnDropdown", params);
		var that = this;
		jQuery("#columnDropdownMenu input.columnCheck").bind("change", function(){
			//alert("changed");
			that.toggleColumn(this);
		});
		/*jQuery("#columnDropdownMenu").bind("mousedown", function(event){
		//IE workaround
		//make the checked attribute match the highlight state
		//if (typeof event.target == 'undefined'){
			var highlightedLabel = jQuery(event.srcElement).parent();
			//var labelId = highlightedLabel.length;
			//jQuery(event.srcElement);
			var thisCheckBox = highlightedLabel.next();
			alert("before:  " + thisCheckBox.attr("checked"));
			//if (highlightedLabel.hasClass("ui-state-active")){
				if (typeof thisCheckBox.attr("checked") != "undefined"){
					thisCheckBox.filter("input").attr("checked", false);
					alert(thisCheckBox.filter("input").attr("checked"));
				//} else {}
			} else {
				//if (typeof thisCheckBox.attr("checked") == "undefined"){
					thisCheckBox.attr("checked", "checked");
				}
				//thisCheckBox.trigger("change");

			//}
		//}
	});*/
		//this.updateOrganize();
		jQuery("#columnDropdownSelect").addClass("subHeaderDropdownSelect");
	};

	/**
	 * function that removes the welcome message from the search tab and shows the search results table
	 */
	this.showSearchResults = function(){
		jQuery("#resultsSubHeader > span").css("display", "inline");
		jQuery("#resultsSubHeader > div").css("display", "inline-block");

		jQuery("#resultsTable").css("display", "block");
		jQuery("#searchResultsNavigation").css("display", "block");
	};

	/**
	 * checks the state of the map filter
	 * 
	 * @returns a boolean that is true if the map filter is on
	 */
	this.filterState = function(){
		//return jQuery('#basicSearchMapFilter').is(":checked");
		return true;
	};

	/**
	 * submits a search if the map extent has changed
	 */
//	also call when switching tabs to a search tab, onchange of mapfilter select boxes
	this.filterResults = function(){
		//check if extent has changed
		if (this.mapObject.userMapAction){
			if (this.mapObject.extentChanged()){
				if ((this.filterState())&&(jQuery("#map").css("display") != "none")&&(jQuery("#left_col").css("display") != "none")){
					this.searchSubmit();
				}
			}
		}
	};

	this.userInputFlag = false;

	/*OpenGeoportal.UserInterface.prototype.checkUserInput = function(){
	var that = this;
	var setUserInputFlag = function(){that.mapObject.userMapAction = true;alert("userInputflag set");};
	//jQuery("#map").one("dblclick", setUserInputFlag);
	//jQuery(document).mousedown(setUserInputFlag);

	jQuery("#map").one("mousedown", setUserInputFlag);

};*/

	/**
	 * sets the background map to the value in the background map dropdown menu.  called by onchange for the basemap radio button set
	 */
	this.baseMapChanged = function(){
		var value = jQuery('input:radio[name=basemapRadio]:checked').val();
		//OpenGeoportal.map.setBackgroundMap(value);
		this.mapObject.setBackgroundMap(value);
	};

	/**
	 * geocodes the value typed into the geocoder text input using the Google maps geocoder,
	 * then zooms to the returned extent.  also animates the response
	 */
	this.geocodeLocation = function(){
		var value = jQuery("#geosearch").val();
		geocoder = new google.maps.Geocoder();
		var that = this;
		geocoder.geocode( { 'address': value}, function(results, status) {
			if (status != 'OK'){
				jQuery("#geosearch").val("Place name not found");
			} else {
				jQuery("#geosearch").val(results[0].formatted_address);
				var	maxY = results[0].geometry.viewport.getNorthEast().lat();
				var	maxX = results[0].geometry.viewport.getNorthEast().lng();
				var	minY = results[0].geometry.viewport.getSouthWest().lat();
				var	minX = results[0].geometry.viewport.getSouthWest().lng();
				var extent = minX + "," + minY + "," + maxX + "," + maxY;
				//zooms to actual extent, rather than a latitude delta
				that.mapObject.zoomToLayerExtent(extent);

			}
			var currentFontSize = jQuery("#geosearch").css("font-size");
			var currentOpacity = jQuery("#geosearch").css("opacity");
			jQuery("#geosearch").animate({"opacity": 1, "font-size": parseInt(currentFontSize) + 2}, 500).delay(1500)
			.animate({ "font-size": 0 }, 300, function(){jQuery("#geosearch").val(that.geocodeText).css({"font-size": currentFontSize, "opacity": currentOpacity});} );
		});
	};

	this.clearInput = function(divName){
		jQuery('#' + divName + ' :input').each(function(){
			var type = this.type;
			var tag = this.tagName.toLowerCase();
			if (type == 'text' || type == 'password' || tag == 'textarea'){
				this.value = '';
			} else if (type == 'checkbox' || type == 'radio'){
				this.checked = false;
			} else if (tag == 'select'){
				this.selectedIndex = 0;
			}
		});
	};

	this.clearDefault = function(inputFieldName){
		var searchTextElement = document.getElementById(inputFieldName);
		if (searchTextElement == null)
			return;
		var currentValue = searchTextElement.value;
		if (currentValue.indexOf("Search") == 0)
			searchTextElement.value = "";
	};

	this.searchSubmit = function(){
		//console.log("searchSubmit");
		this.resultsTableObject.searchRequest(0);
		this.userInputFlag = true;
	};

	this.getCheckboxValue = function(id){
		var query = "#" + id + ":checked";
		var value = jQuery(query).val();
		if (value)
			value = "on";
		else
			value = "off";
		return value;
	};

//	really, this should probably go elsewhere
	this.adjustTableLength = function(tableID){
		var tableID = 'searchResults';
		if (tableID == 'searchResults'){
			this.resultsTableObject.setTableLength();
		} else {
			throw new Error("The specified table is not applicable.");
		}
	};

	this.searchToggleHandler = function(){
		var that = this;
		jQuery(".searchToggle").on("click", function(){that.toggleSearch(this);});
	};

	this.toggleSearch = function(thisObj){
		var thisID = jQuery(thisObj).attr('id');
		if (thisID == 'moreSearchOptions'){
			jQuery("#searchForm .basicSearch").hide();
			jQuery("#geosearchDiv").removeClass("basicSearch").addClass("advancedSearch");
			jQuery("#searchForm .advancedSearch.searchRow1").show();
			jQuery('#header').animate(
					{height: "+=25"},
					{queue: false, duration: 100, complete: function(){
						jQuery("#searchForm .advancedSearch.searchRow2").show();
						jQuery('#header').animate(
								{height: "+=25"},
								{queue: false, duration: 100, complete: function(){
									jQuery("#searchForm .advancedSearch.searchRow3").show();
									jQuery('#header').animate(
											{height: "+=28"},
											{queue: false, duration: 100, complete: function(){
												jQuery("#searchForm .advancedSearch.searchRow4").show();
											}
											});
								}});
					}});



		} else if (thisID == 'lessSearchOptions'){
			//jQuery("#searchForm .advancedSearch").hide();
			jQuery("#searchForm .advancedSearch.searchRow4").hide();
			jQuery('#header').animate(
					{height: "-=28"},
					{queue: false, duration: 100, complete: function(){
						jQuery("#searchForm .advancedSearch.searchRow3").hide();
						jQuery('#header').animate(
								{height: "-=25"},
								{queue: false, duration: 100, complete: function(){
									jQuery("#searchForm .advancedSearch.searchRow2").hide();
									jQuery('#header').animate(
											{height: "-=25"},
											{queue: false, duration: 100, complete: function(){
												jQuery("#geosearchDiv").removeClass("advancedSearch").addClass("basicSearch");
												jQuery("#searchForm .advancedSearch.searchRow1").hide();
												jQuery("#searchForm .basicSearch").show();		
											}
											});
								}});
					}});
		}
	};

	this.searchPanelWidth = 450;

	this.getSearchPanelWidth = function(){
		return this.searchPanelWidth;
	};

	this.setSearchPanelWidth = function(newValue){
		this.searchPanelWidth = newValue;
	};


	this.rollRightHandler = function(){
		var that = this;
		jQuery('.arrow_right').click( function () {
			analytics.track("Interface", "Expand/Collapse Buttons", "Expand Right");

			var panelSelector = jQuery("#left_col");
			var mapSelector = jQuery("#map");
			if (panelSelector.css("display") == "none"){
				//map is full width; go back to combo display
				jQuery("#roll_right").css('display', 'none');
				jQuery(".ui-resizable-handle").css("display", "block");
				var panelWidth = that.getSearchPanelWidth()
				panelSelector.outerWidth(panelWidth);
				var panelOffset = panelWidth - jQuery("#roll_right").width();
				panelSelector.css("margin-left", -1 * panelOffset);
				panelSelector.css('display', 'block');
				mapSelector.animate({'width': '-=' + panelOffset}, { queue: false, duration: 500 });
				panelSelector.animate({'margin-left':'+=' + panelOffset}, { queue: false, duration: 500 }, function(){    		  
					that.filterResults();});

			} else if (mapSelector.css("display") == "none"){
				//don't do anything; search panel is already full width
			} else {
				//go to full width search panel
				that.setSearchPanelWidth(panelSelector.outerWidth());
				mapSelector.animate({'width': '0'}, { queue: false, duration: 500 }, function(){
					mapSelector.css("display", "none");
				});

				panelSelector.animate({'width': jQuery('#container').width() -2}, { queue: false, duration: 500 }, function(){    		  
					that.resultsTableObject.showCol('ContentDate');
				});        	 
			}
		});
	};

	this.rollLeftHandler = function(){
		var that = this;
		jQuery('.arrow_left').click( function () {
			analytics.track("Interface", "Expand/Collapse Buttons", "Collapse Left");
			//logic to expand map to full size
			var panelSelector = jQuery("#left_col");
			var mapSelector = jQuery("#map");
			if (panelSelector.css("display") == "none"){
				//don't do anything; map is already full width
			} else if (mapSelector.css("display") == "none"){
				//go back to previous left column width; search panels are full width
				panelSelector.outerWidth(that.getSearchPanelWidth());
				panelSelector.css("display", "block");
				that.resultsTableObject.hideCol('ContentDate');
				mapSelector.width(jQuery('#container').width() - panelSelector.outerWidth());
				mapSelector.add("#menu").css("display", "inline-block");
			} else {
				//display full width map
				panelSelector.css("display", "none");
				jQuery("#roll_right").css("display", "block");
				jQuery(".ui-resizable-handle").css("display", "none");
				mapSelector.width(jQuery('#container').outerWidth() - jQuery("#roll_right").outerWidth());
			}
		});
	};


	this.togglePanels = function(){
		this.rollRightHandler();
		this.rollLeftHandler();
	};
	/*var that = this;
    	jQuery('.arrow_buttons > div').click( function () {
          //var rollUp = that.getImage("button_arrow_up.png");
          //var rollDown = that.getImage("button_arrow_down.png");
          var rollLeft = jQuery(this).hasClass("arrow_left");
          var rollRight = jQuery(this).hasClass("arrow_right");
          var tabDiv = jQuery(this).parents('.ui-tabs-panel').last();
          var userDiv = tabDiv.find('.searchBox')[0];

			var button;
			//	src = jQuery(this).attr("src");

			/*button = (src == rollUp) && "Collapse Up" ||
					(src == rollDown) && "Expand Down" ||*/
	/*button = rollLeft && "Collapse Left" ||
					rollRight && "Expand Right";

			analytics.track("Interface", "Expand/Collapse Buttons", button);*/

	/* switch (jQuery(this).attr('src')){
          case rollUp: 
        	  jQuery(userDiv).toggle("blind",{},250, function(){that.resultsTableObject.setTableLength();});
        	  jQuery(this).attr('src', rollDown);
          break;
          case rollDown:
				var searchHeight = jQuery(userDiv).height() + parseFloat(jQuery(userDiv).css("padding-top")) + parseFloat(jQuery(userDiv).css("padding-bottom"));
				var searchRowHeight = tabDiv.find('table.display > tbody > tr').first().height() || 23;
				var adjRows = Math.floor(searchHeight/searchRowHeight) * -1;
        	  that.resultsTableObject.adjustTableLength(adjRows);
  			  jQuery(userDiv).toggle("blind",{},250, function(){that.resultsTableObject.setTableLength();});
  			  jQuery(this).attr('src', rollUp);
          break;	*/
	/*if (rollLeft) {
          	//logic to expand map to full size
        	  var panelSelector = jQuery("#left_col");
        	  var mapSelector = jQuery("#map");
        	  if (panelSelector.css("display") == "none"){
        		  //don't do anything; map is already full width
        	  } else if (mapSelector.css("display") == "none"){
        		  //go back to previous left column width; search panels are full width
        		  panelSelector.width(that.getSearchPanelWidth());
        		  panelSelector.css("display", "block");
            	  that.resultsTableObject.hideCol('ContentDate');
        		  mapSelector.width(jQuery('#container').width() - panelSelector.width() - 1);
        		  mapSelector.add("#menu").css("display", "inline-block");
        		  //OpenGeoportal.map.updateSize();
        		  //that.mapObject.updateSize();
        	  } else {
        		  //display full width map
        		  panelSelector.css("display", "none");
        		  jQuery("#roll_right").css("display", "block");
        		  jQuery(".ui-resizable-handle").css("display", "none");
        		  mapSelector.width(jQuery('#container').width() - 18);
        		  //OpenGeoportal.map.updateSize();
        		  //that.mapObject.updateSize();
        	  }
          	//break;
          } else if (rollRight){
        	  var panelSelector = jQuery("#left_col");
        	  var mapSelector = jQuery("#map");
        	  if (panelSelector.css("display") == "none"){
        		  //map is full width; go back to combo display
        		  jQuery("#roll_right").css('display', 'none');
        		  jQuery(".ui-resizable-handle").css("display", "block");
        		  panelSelector.width(that.getSearchPanelWidth());
        		  mapSelector.width(jQuery('#container').width() - panelSelector.width() - 1);
            	  //OpenGeoportal.map.updateSize();
        		  //that.mapObject.updateSize();
                  panelSelector.css('display', 'block');
                  that.filterResults();
        	  } else if (mapSelector.css("display") == "none"){
        		  //don't do anything; search panel is already full width
        	  } else {
        		  //go to full width search panel
        		  mapSelector.add("#menu").css("display", "none");
        		  panelSelector.width(jQuery('#container').width() - 1);
            	  that.resultsTableObject.showCol('ContentDate');
        	  }
          } else {
          	alert('searchBoxResize fall-through.');
          }
    	});
};
	 */
	this.mapFilterStatus = function(eventObj){
		if (jQuery(eventObj).is(":checked")){
			jQuery(".mapFilterFlag").attr("checked", "checked");
		} else {
			jQuery(".mapFilterFlag").removeAttr("checked");
		}

		this.searchSubmit();
	};

	this.chooseSort = function(columnName){
		this.utility.whichTab().tableObject().sortColumns(columnName, false);
	};

	this.toggleColumn = function(thisObj){
		var action,
		checked = jQuery(thisObj).is(":checked"),
		column = jQuery(thisObj).val();

		if (checked) {
			this.utility.whichTab().tableObject().showCol(column);
		} else {
			this.utility.whichTab().tableObject().hideCol(column);
		}

		action = checked ? "Column Added" : "Column Removed";

		analytics.track("Change Results Columns Displayed", action, column);
	};

	this.updateSortMenuHandler = function(){
		var that = this;
		jQuery(document).on("view.updateSortMenu", that.updateSortMenu());
	};

	this.updateSortMenu = function(){
		//these pieces should be also called when updated elsewhere
		var tableObj = this.utility.whichTab().tableObject();

		var organize = tableObj.tableOrganize.getState();

		var fields = tableObj.tableHeadingsObj.getTableHeadings();
		var buttonHtml = fields[organize.organizeBy].displayName;
		jQuery("#sortDropdownSelect > span > span").html(buttonHtml);
		jQuery("#sortDropdownMenu").find("input:radio").each(function(){
			if (jQuery(this).val() == organize.organizeBy){
				jQuery(this).attr("checked", true);
			}
		});

	};

//	should add to cartTable code
	this.initSortable = function(){
		var that = this;
		jQuery( "#savedLayers > tbody" ).sortable({helper: "original", opacity: .5, containment: "parent", 
			items: "tr", tolerance: "pointer", cursor: "move",
			start: function(event, ui){
				//this code is ugly...optimize
				jQuery("#savedLayers .resultsControls").each(function(){
					var rowObj = jQuery(this).parent()[0];
					//console.log(rowObj);
					var tableObj = jQuery("#savedLayers").dataTable();
					tableObj.fnClose(rowObj);
					//why doesn't this close the row?
					tableObj.fnDraw(false);
				});
			},
			stop: function(event, ui){
				var dataArr = [];
				var tableObj = jQuery("#savedLayers").dataTable();
				dataArr = tableObj.fnGetData();
				var newArr = [];
				var openCount = 0;
				jQuery("#savedLayers > tbody > tr").each(function(index, Element){
					var dataTableIndex = tableObj.fnGetPosition(Element);
					if (typeof dataTableIndex == 'number'){
						newArr[index - openCount] = dataArr[dataTableIndex];
					} else {
						openCount += 1;
					}
				});
				tableObj.fnClearTable(false);
				tableObj.fnAddData(newArr);
				var tableLength = newArr.length;
				for (var i in newArr){

					if (typeof that.mapObject.getLayersByName(newArr[i][0])[0] != 'undefined'){
						var layer = that.mapObject.getLayersByName(newArr[i][0])[0];
						that.mapObject.setLayerIndex(layer, tableLength - (i+1));
					}
				}

				that.cartTableObject.callbackExpand();

			}
		});
	};

	this.toggleChecksSaved = function(eventObj){
		var target = eventObj.target;
		if (jQuery(target).is(':checked')){
			jQuery(target).attr('title', "Unselect All");
			jQuery(".cartCheckBox").each(function(){
				jQuery(this).attr('checked', true);
			});
		} else {
			jQuery(target).attr('title', "Select All");
			jQuery(".cartCheckBox").each(function(){
				jQuery(this).attr('checked', false);	
			});
		}
	};

	this.loginHandler = function(){
		var that = this;
		jQuery(document).off(".login");

		var promptLogin = function(e){that.promptLogin(e);};
		jQuery(document).on("click.login", ".loginButton", promptLogin); 
		jQuery("#headerLogin").on("click.login", promptLogin);

	};

	this.updateCartNumberHandler = function(){
		var that = this;
		jQuery(document).on("view.updateCartNumber", function(){
			that.updateSavedLayersNumber();
		});
	};

	this.updateSavedLayersNumber = function(){
		//boo
		jQuery('.savedLayersNumber').text('(' + this.cartTableObject.numberOfResults() + ')');
	};

	this.isRaster = function(dataType){
		dataType = dataType.toLowerCase();
		if ((dataType == "raster")||(dataType == "paper map")){
			return true;
		} else {
			return false;
		}
	};

	this.isVector = function(dataType){
		//console.log(dataType);
		dataType = dataType.toLowerCase();
		//console.log(dataType);
		if ((dataType == "line")||(dataType == "point")||(dataType == "polygon")){
			return true;
		} else {
			return false;
		}
	};

	this.downloadDialog = function(){
		//first, check to see if anything is in savedLayers & checked
		var layerList = this.getLayerList("download");

		var dialogContent = "";
		var counter = 0;
		for (var i in layerList){
			counter++;
		}
		if (counter == 0){
			dialogContent = 'No layers have been selected.';
		} else {
			//this should probably call a dialog instance for error messages/notifications

			//generate a list of appropriate choices for the chosen layers
			//for now a best guess;  at some point, we might be able to do something clever
			//by looking at the download config file.
			var showVectorControl = false;
			var showRasterControl = false;
			for (var layerId in layerList){
				if (this.requiresEmailAddress(layerList[layerId])){
					needEmailInput = true;
				}
				var dataType = layerList[layerId].dataType;
				if (this.isVector(dataType)){
					showVectorControl = true;
					continue;
				}
				if (this.isRaster(dataType)){
					showRasterControl = true;
					continue;
				}
			}
			var vectorControl = "<label for=\"vectorDownloadType\" class=\"downloadSelect\">Vector files</label>";
			vectorControl += "<select id=\"vectorDownloadType\" class=\"downloadSelect\"> \n";
			vectorControl += "<option value=\"shp\">shapefile</option> \n";
			vectorControl += "<option value=\"kmz\">KMZ</option> \n";
			vectorControl += "</select><br/> \n";
			var rasterControl = "<label for=\"rasterDownloadType\" class=\"downloadSelect\">Raster files</label>";
			rasterControl += "<select id=\"rasterDownloadType\" class=\"downloadSelect\"> \n";
			rasterControl += "<option value=\"GeoTIFF\">GeoTiff</option> \n";
			rasterControl += '<option value="kmz">KMZ</option> \n';
			rasterControl += "</select><br/> \n";
			var clipControl = '<input id="checkClip" type="checkbox" checked="checked" /><label for="checkClip" id="checkClipLabel">Clip data to map extent</label><br/> \n';
			//var emailInput = '<label for="emailAddress">Enter your email address:</label><input id="emailAddress" type="text" /> </br>\n';
			var formatLabel = "<span>Select format for:</span><br />\n";
			if (showVectorControl || showRasterControl){
				dialogContent += formatLabel;
				if (showVectorControl){
					dialogContent += vectorControl;
				}
				if (showRasterControl){
					dialogContent += rasterControl;
				}
				dialogContent += clipControl;

			} else {
				dialogContent += "The selected layers have an invalid data type and can not be downloaded.";
			}
		}

		var that = this;
		var params = {
				zIndex: 3000,
				autoOpen: false,
				minHeight: '30px',
				width: 300,
				title: "DOWNLOAD SETTINGS",
				resizable: false,
				modal: true
		};
		if (typeof jQuery('#downloadDialog')[0] == 'undefined'){
			var downloadDiv = '<div id="downloadDialog" class="dialog downloadSettingsDialog"> \n';
			downloadDiv += dialogContent;
			downloadDiv += '</div> \n';
			jQuery('body').append(downloadDiv);
		} else {
			//replace dialog text/controls & open the instance of 'dialog' that already exists
			jQuery("#downloadDialog").html(dialogContent);
			jQuery("#downloadDialog").dialog( "option", "disabled", false );
		}
		jQuery("#downloadDialog").dialog(params);
		var buttons;
		if (counter == 0){
			buttons = {
					Cancel: function() {
						jQuery(this).dialog('close');
						jQuery("#optionDetails").html("");
						jQuery(".downloadSelection, .downloadUnselection").removeClass("downloadSelection downloadUnselection");
					}
			};
		} else {
			buttons = {
					Continue: function() {
						that.downloadContinue();
					},
					Cancel: function() {
						jQuery(this).dialog('close');
						jQuery("#optionDetails").html("");
						jQuery(".downloadSelection, .downloadUnselection").removeClass("downloadSelection downloadUnselection");
					}
			};
		}
		jQuery("#downloadDialog").dialog("option", "buttons", buttons);
		jQuery("#downloadDialog").dialog('open');
	};

	this.downloadContinue = function(){
		var clipped = this.isClipped();
		var vectorFormat = jQuery("#vectorDownloadType").val();
		var rasterFormat = jQuery("#rasterDownloadType").val();
		var arrBbox = [];
		var layerObj;
		if (clipped){
			//if this is true, we should also make sure that part or all of the requested layer is in the extent
			//if not, it should be excluded
			//arrBbox = OpenGeoportal.map.getGeodeticExtent().toArray();
			arrBbox = this.mapObject.getGeodeticExtent().toArray();
			layerObj = this.getLayerList("download", {clipped: arrBbox});
		} else {
			arrBbox = [-180,-90,180,90];
			layerObj = this.getLayerList("download");
		}
		/*for (var layer in layerObj){
		if (layerObj[layer].directDownload){
			console.log(layerObj);
			jQuery("body").append('<iframe style="display:none" src="' + layerObj[layer].directDownloadUrl + '" ></iframe>');
			delete layerObj[layer];
		}
	}*/
		var layerIds = [];
		var needEmailInput = 0;
		var layerNumber = 0;
		for (var layer in layerObj){
			layerNumber++;
			if ((this.requiresEmailAddress(layerObj[layer]))&&(rasterFormat.toLowerCase() != "kmz")){
				needEmailInput++;
			}
			if (this.isVector(layerObj[layer].dataType)){
				layerIds.push(layer + "=" + vectorFormat);
			} else if (this.isRaster(layerObj[layer].dataType)){
				layerIds.push(layer + "=" + rasterFormat);
			}
		}
		if (layerNumber == 0){
			jQuery("#downloadDialog").dialog('close');
			return;
		}
		var requestObj = {};
		if (arrBbox.length > 0){
			requestObj.bbox = arrBbox.join();
		}
		//requestObj.format = fileFormat;
		requestObj.layers = layerIds;

		//first, check to see if anything is in savedLayers & checked
		var that = this;
		pluralSuffix = function(totalNumber){
			var plural;
			if (totalNumber > 1){
				plural = "s";
			} else {
				plural = "";
			}
			return plural;
		};
		var downloadContinue = '<div>You have selected ' + layerNumber + ' layer' + pluralSuffix(layerNumber) + ' for download.</div>\n';
		var addEmail = "";
		if (needEmailInput > 0){
			addEmail += '<div><label for="emailAddress">You have selected Harvard raster data. Please enter your email to receive a download link:</label><br />\n';
			addEmail += '<input id="emailAddress" type="text" /></div>\n';
			addEmail += '<span id="emailValidationError" class="warning"></span>';

		}
		if ((layerNumber - needEmailInput) > 0){
			downloadContinue += '<div>A zip file will be generated. \n';
			downloadContinue += 'It may take up to 10 minutes to process your file.<br /> \n';
			downloadContinue += '<span class="notice">Do not close the GeoData website.</span></div>\n';
		}
		downloadContinue += addEmail;
		jQuery("#downloadDialog").html(downloadContinue);
		jQuery("#downloadDialog").dialog({title: "DOWNLOAD",
			width: 350,
			buttons: {
				Download: function() {
					requestObj.layerNumber = layerNumber;
					if (layerNumber == 0){
						jQuery(this).dialog('close');
						return;
					}
					var emailAddress = "";
					if (needEmailInput > 0){
						emailAddress = jQuery("#emailAddress").val();
						if (!that.checkAddress(emailAddress)){
							var warningText = 'You must enter a valid email address.';
							jQuery("#emailValidationError").html(warningText);
							return;
						}
					}
					requestObj.email = emailAddress;
					that.toProcessingAnimation(jQuery(this).parent().find("button").first());
					that.requestDownload(requestObj);
				},
				Cancel: function() {
					jQuery(this).dialog('close');
					jQuery("#optionDetails").html("");
					jQuery(".downloadSelection, .downloadUnselection").removeClass("downloadSelection downloadUnselection");
				}
			}});
		jQuery("#emailAddress").focus();
	};

	this.checkAddress = function(emailAddress){
		var stringArray = emailAddress.split("@");
		if (stringArray.length < 2) {
			return false;
		} else {
			var domainArray = stringArray[1].split(".");
			var userString = stringArray[0];
			if (domainArray.length < 2) {
				return false;
			} else if ((domainArray[0].length + domainArray[1].length + userString.length) < 3){
				return false;
			} 
		}
		return true;

	};

	this.isClipped = function(){
		if (jQuery('#checkClip').is(':checked')){
			return true;
		} else {
			return false;
		}
	};

	this.requestErrorMessage = function(errorMessageObj){

		var line = "";
		for (var failedToDownload in data.failed){
			line += "<tr>";
			//for (var infoElement in data.failed[failedToDownload]){
			line += "<td>";
			line += '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>';
			line += "</td>";
			line += "<td>";
			line += data.failed[failedToDownload]["institution"];
			line += "</td>";						
			line += "<td>";
			line += data.failed[failedToDownload]["title"];
			line += "</td>";						
			line += "<td>";
			line += data.failed[failedToDownload]["layerId"];
			line += "</td>";
			line += '<td><span class="warning">';
			line += data.failed[failedToDownload]["message"];
			line += "</span></td>";
			//}
			line += "</tr>";
		}
		if (line.length > 0){
			var message = '<table class="downloadStatus">';
			message += line;
			message += "</table>";
			this.genericModalDialog(message, "DOWNLOAD ERRORS");
		}
	};

	this.requestDownloadSuccess = function(data){
		//this will simply be a request ID.  add it to the  request queue.
		OpenGeoportal.org.downloadQueue.registerLayerRequest(data.requestId);

		//will also have status info for requested layers in this returned object
		/*var line = "";
	for (var failedToDownload in data.failed){
		line += "<tr>";
		//for (var infoElement in data.failed[failedToDownload]){
			line += "<td>";
			line += '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>';
			line += "</td>";
			line += "<td>";
			line += data.failed[failedToDownload]["institution"];
			line += "</td>";						
			line += "<td>";
			line += data.failed[failedToDownload]["title"];
			line += "</td>";						
			line += "<td>";
			line += data.failed[failedToDownload]["layerId"];
			line += "</td>";
			line += '<td><span class="warning">';
			line += data.failed[failedToDownload]["message"];
			line += "</span></td>";
		//}
		line += "</tr>";
	}
	if (line.length > 0){
		var message = '<table class="downloadStatus">';
		message += line;
		message += "</table>";
		this.genericModalDialog(message, "DOWNLOAD ERRORS");
	}
	if (data.succeeded.length > 0){
		//check packageLink
		if (typeof data.packageLink != 'undefined'){
			jQuery("body").append('<iframe style="display:none" src="' + data.packageLink + '"></iframe>');
		}
		var line = "";
		for (var successful in data.succeeded){
			if (data.succeeded[successful].disposition == "LINK_EMAILED"){
				line += "<tr>";
				line += "<td>";
				line += data.succeeded[successful]["institution"];
				line += "</td>";						
				line += "<td>";
				line += data.succeeded[successful]["title"];
				line += "</td>";						
				//line += "<td>";
				//line += data.succeeded[successful]["layerId"];
				//line += "</td>";
				//line += "<td>";
				//line += data.succeeded[successful]["message"];
				//line += "</td>";
				line += "</tr>";
			}
		}

		if (line.length > 0){
			var message = "<p>A link for the following layers was emailed to '" + requestObj.email + "'.  ";
			message += '<span class="notice">It may take up to 10 minutes to receive the email.</span></p>'; 
			message += '<table class="downloadStatus">';
			message += line;
			message += "</table>";
			this.genericModalDialog(message, "LAYERS EMAILED");
		}
	}*/

	};

	this.requestDownload = function(requestObj){
		var that = this;
		jQuery("#downloadDialog").dialog( "option", "disabled", true );

		jQuery("#savedLayers tr").has(".cartCheckBox:checked").each(function() {
			var data = jQuery("#savedLayers").dataTable().fnGetData(this),
			inst_idx = that.resultsTableObject.tableHeadingsObj.getColumnIndex("Institution"),
			layer_idx = that.resultsTableObject.tableHeadingsObj.getColumnIndex("LayerId");
			analytics.track("Layer Downloaded", data[inst_idx], data[layer_idx]);
		});
		delete requestObj.layerNumber;

		var params = {
				url: "requestDownload",
				data: requestObj,
				dataType: "json",
				type: "POST",
				//traditional: true,
				context: this,
				complete: function(){
					var noSelectionHtml = "";
					jQuery("#optionDetails").html(noSelectionHtml);
					jQuery(".downloadSelection, .downloadUnselection").removeClass("downloadSelection downloadUnselection");
				},
				success: function(data){OpenGeoportal.org.downloadQueue.registerLayerRequest(data.requestId, requestObj);}
		};
		//close the download box;
		jQuery("#downloadDialog").dialog("close");
		jQuery.ajax(params);
	};

	this.genericModalDialog = function(customMessage, dialogTitle){

		var divId = "genericModalDialog" + jQuery('.genericModalDialog').size();
		var div = '<div id="' + divId + '" class="dialog genericModalDialog">';
		div += customMessage;
		div += '</div>';
		jQuery('body').append(div);

		jQuery('#' + divId).dialog({
			zIndex: 2999,
			title: dialogTitle,
			resizable: true,
			modal: true,
			minWidth: 415,
			autoOpen: false		
		});

		jQuery('#' + divId).dialog('open');
		return divId;
	};

	this.requiresEmailAddress = function(layerObject){
		if ((layerObject.institution == "Harvard")&&(this.isRaster(layerObject.dataType))){
			return true;
		} else {
			return false;
		}
	};

	this.IgnoreAuthenticationWarning = {"home": false, "external": false};


	this.authenticationWarning = function(checkboxObj, rowData, canLogin){

		var that = this;
		var institution = rowData[this.cartTableObject.tableHeadingsObj.getColumnIndex("Institution")];
		var ignoreWarningId = "ignoreAuthenticationWarning";
		var disposition;
		var warningMessage = '<span>This layer is restricted by licensing agreement to the ' + institution + ' community. </span>';
		if (canLogin){
			if (this.IgnoreAuthenticationWarning.home){
				this.cartTableObject.addToCart(checkboxObj, rowData);
				return;
			}
			warningMessage += '<span class="notice">Restricted layers can be added to the Cart, but you must login before you can preview or download restricted layers.</span>'; 
			ignoreWarningId += "Internal";
			disposition = "home";
		} else {
			if (this.IgnoreAuthenticationWarning.external){
				this.cartTableObject.addToCart(checkboxObj, rowData);
				return;
			}
			warningMessage += '<span class="notice">Restricted layers can be added to the Cart here, but you must use ' + institution;
			warningMessage += "'s site and login to preview or download restricted layers.</span>"; 
			ignoreWarningId += "External";
			disposition = "external";
		}

		warningMessage += "<br />";
		warningMessage += '<span class="ignoreWarning"><input id="ignoreAuthenticationWarning" type="checkbox" /><label for="ignoreAuthenticationWarning">Don\'t show this message again.</span>';

		var divId = this.genericModalDialog(warningMessage, "RESTRICTED LAYER");

		var addToCartFunction = function() {
			that.IgnoreAuthenticationWarning[disposition] = jQuery("#" + ignoreWarningId).is(":checked");
			jQuery(this).dialog('close');
			that.cartTableObject.addToCart(checkboxObj, rowData);
		};

		var loginAndAddFunction = function(){
			that.IgnoreAuthenticationWarning[disposition] = jQuery("#" + ignoreWarningId).is(":checked");
			//that.promptLogin();
			that.login.loginDialog();

			//pass some info to the loginDialog
			jQuery(this).dialog('disable');
			var dialogBox = jQuery('#' + divId);
			jQuery(document).bind("loginSuccess.addToCart", function(){
				that.cartTableObject.addToCart(checkboxObj, rowData);
				dialogBox.dialog('close');
				jQuery(document).unbind("loginSuccess.addToCart");
			});
			jQuery(document).bind("loginCancel", function(){
				dialogBox.dialog("enable");
			});
		};

		var cancelFunction = function(){
			that.IgnoreAuthenticationWarning[disposition] = jQuery("#" + ignoreWarningId).is(":checked");
			jQuery(this).dialog('close');
			//some code to deselect the layer check box;
			jQuery(checkboxObj).attr("checked", false);
		};

		var buttons = {};
		if (canLogin){
			buttons["Login & Add"] = loginAndAddFunction;
			buttons["Add Only"] = addToCartFunction;
			buttons["Cancel"] = cancelFunction;
		} else {
			buttons["Add"] = addToCartFunction;
			buttons["Cancel"] = cancelFunction;
		}

		jQuery('#' + divId).dialog(	
				{width: 535,
					buttons: buttons
				}
		);


	};

	this.availableLayerLogic = function(action, rowData){
		switch (action){
		case "mapIt":
			//public vector layers only.
			var institution = rowData[this.cartTableObject.tableHeadingsObj.getColumnIndex('Institution')].toLowerCase();
			var access = rowData[this.cartTableObject.tableHeadingsObj.getColumnIndex('Access')].toLowerCase();
			var dataType = rowData[this.cartTableObject.tableHeadingsObj.getColumnIndex('DataType')].toLowerCase();

			if (access != "public"){
				return false;
			} else {
				if (this.isVector(dataType)){
					return true;
				} else {
					return false;
				}
			}
			break;
		case "removeFromCart":
			return true;
			break;
		case "shareLink":
			return true;
			break;
		case "download":
			//no external restricted layers, no local restricted layers if not logged in. 
			var institution = rowData[this.cartTableObject.tableHeadingsObj.getColumnIndex('Institution')].toLowerCase();
			var access = rowData[this.cartTableObject.tableHeadingsObj.getColumnIndex('Access')].toLowerCase();
			var dataType = rowData[this.cartTableObject.tableHeadingsObj.getColumnIndex('DataType')].toLowerCase();
			if (dataType == "libraryrecord"){
				return false;
			}
			if (access == "public"){
				return true;
			} else if (institution != OpenGeoportal.InstitutionInfo.getHomeInstitution().toLowerCase()){
				return false;
			} else if (this.login.isLoggedIn()){
				return true;
			} else {
				return false;
			}
			break;
		case "webService":
			//public layers only.  right now, only Tufts.
			var institution = rowData[this.cartTableObject.tableHeadingsObj.getColumnIndex('Institution')].toLowerCase();
			var access = rowData[this.cartTableObject.tableHeadingsObj.getColumnIndex('Access')].toLowerCase();
			var dataType = rowData[this.cartTableObject.tableHeadingsObj.getColumnIndex('DataType')].toLowerCase();
			if (dataType == "libraryrecord"){
				return false;
			}
			if ((institution != "mit")||(access != "public")){
				return false;
			} else {
				return true;
			}
			break;
		}
		return false;
	};

	this.getLayerList = function(downloadAction, params){
		if (arguments.length < 2){
			params = {};
			params.clipped = false;
		}
		jQuery(".downloadSelection").removeClass("downloadSelection");
		jQuery(".downloadSelection").removeClass("downloadUnselection");

		var layerInfo = {};
		var tableObj = jQuery("#savedLayers").dataTable();
		var checkedRows = jQuery(".cartCheckBox:checked");
		var that = this;
		checkedRows.each(function(){
			var rowNode = jQuery(this).closest('tr');
			var aPos = tableObj.fnGetPosition(rowNode[0]);
			var aData = tableObj.fnGetData(aPos);
			var headingsObj = that.cartTableObject.tableHeadingsObj;
			var minX = aData[headingsObj.getColumnIndex('MinX')];
			var minY = aData[headingsObj.getColumnIndex('MinY')];
			var maxX = aData[headingsObj.getColumnIndex('MaxX')];
			var maxY = aData[headingsObj.getColumnIndex('MinY')];
			var isValidLayer = that.availableLayerLogic(downloadAction, aData);
			if (params.clipped != false){
				//do a test to see if the layer's bbox is within the clip extent
				var layerBounds = new OpenLayers.Bounds();
				layerBounds.extend(new OpenLayers.LonLat(minX,minY));
				layerBounds.extend(new OpenLayers.LonLat(maxX,maxY));

				var clipBounds = new OpenLayers.Bounds();
				clipBounds.extend(new OpenLayers.LonLat(params.clipped[0],params.clipped[1]));
				clipBounds.extend(new OpenLayers.LonLat(params.clipped[2],params.clipped[3]));
				//this isn't working yet
				//isValidLayer = layerBounds.intersectsBounds(clipBounds);
			}
			if (isValidLayer){
				that.cartTableObject.downloadActionSelectRow(aPos, true);
				var layerID = aData[headingsObj.getColumnIndex('LayerId')];
				//console.log(layerID);
				layerInfo[layerID] = {};
				layerInfo[layerID].name = aData[headingsObj.getColumnIndex('Name')];
				layerInfo[layerID].institution = aData[headingsObj.getColumnIndex('Institution')];
				layerInfo[layerID].dataType = aData[headingsObj.getColumnIndex('DataType')];
				layerInfo[layerID].access = aData[headingsObj.getColumnIndex('Access')];
				layerInfo[layerID].bounds = [minX, minY, maxX, maxY];
				var locationObj = jQuery.parseJSON(aData[headingsObj.getColumnIndex("Location")]);
				console.log(locationObj);
				var downloadLinkExists = false;
				var directDownloadUrl = "";
				if (typeof locationObj["fileDownload"] != undefined){
					downloadLinkExists = true;
					directDownloadUrl = locationObj["fileDownload"]
				}
				layerInfo[layerID].directDownload = downloadLinkExists;
				layerInfo[layerID].directDownloadUrl = directDownloadUrl;
			} else {
				that.cartTableObject.downloadActionSelectRow(aPos, false);
			}
		});
		return layerInfo;
	};

//	OpenGeoportal.UserInterface.prototype.downloadFromMapServer = function(requestObj) {
	//modularize wms call so I can use the same code for 'save image'
	/*if (!jQuery("#attachment")[0]){
		jQuery("body").append('<div id="attachment" style="display:none;"></div>');
	}*/
	//var url = "WMSGetMapProxy.jsp?server=" + requestObj.server + '&format=' + requestObj.format + '&bbox=' + requestObj.bbox;
	/*var url = "getImage?server=" + requestObj.server + '&format=' + requestObj.format + '&bbox=' + requestObj.bbox;
	url += '&srs=' + requestObj.srs + '&layers=' + requestObj.layers;
	url += '&width=' + requestObj.width + '&height=' + requestObj.height + '&type=' + requestObj.type;
	if (typeof requestObj.sld != 'undefined'){
		url += '&sld=' + requestObj.sld;
	}
	jQuery("#downloadDialog").dialog("close");
	var downloadFrameId;
	do {
		downloadFrameId = "downloadFrame" + parseInt(Math.random() * 10000);
	} while (jQuery("#" + downloadFrameId).length > 0)
		var that = this;
	this.utility.showLoadIndicator("mapLoadIndicator", downloadFrameId);
	jQuery("body").append('<iframe id="' + downloadFrameId + '" style="display:none" src="' + url + '"></iframe>');
	jQuery("#" + downloadFrameId).bind("load", function(e){
		that.utility.hideLoadIndicator("mapLoadIndicator", downloadFrameId);
	});*/
//	};

	this.doPrint = function(){
		window.print();
		//jQuery('head > link[href="css/print.css"]').remove();
	};

	this.printImage = function(){
		//just not fast enough to be reliable
		//jQuery('head').append('<link rel="stylesheet" type="text/css" media="print" href="css/print.css" />');
		//setTimeout("OpenGeoportal.ui.doPrint()", 100);	
		window.print();
	};


	this.toProcessingAnimation = function($fromObj){
		jQuery("#requestTickerContainer").show();
		var options = { to: "#requestTickerContainer", className: "ui-effects-transfer"};
		$fromObj.effect( "transfer", options, 500, function(){
			//OpenGeoportal.ui.updateSavedLayersNumber();
		});
	};

	this.saveImage = function(imageFormat, resolution){
		imageFormat = 'png';
		var format;
		switch (imageFormat){
		case 'jpeg':
			format = "image/jpeg";
			break;
		case 'png':
			format = "image/png";
			break;
		case 'bmp':
			format = "image/bmp";
			break;
		default: throw new Error("This image format (" + imageFormat + ") is unavailable.");
		}

		var requestObj = {};
		requestObj.layers = [];

		for (var layer in this.mapObject.layers){
			var currentLayer = this.mapObject.layers[layer];
			if (currentLayer.CLASS_NAME != "OpenLayers.Layer.WMS"){
				continue;
			}
			if (currentLayer.visibility == false){
				continue;
			}

			var sld = this.layerStateObject.getState(currentLayer.name, "sld");
			var opacity = this.layerStateObject.getState(currentLayer.name, "opacity");
			if (opacity == 0){
				continue;
			}
			//insert this opacity value into the sld to pass to the wms server
			var layerObj = {};
			var storedName = this.layerStateObject.getState(currentLayer.name, "wmsName");
			if (storedName == ''){
				layerObj.name = currentLayer.params.LAYERS;
			} else {
				layerObj.name = storedName;
			}
			layerObj.opacity = opacity;
			layerObj.zIndex = this.mapObject.getLayerIndex(currentLayer);
			if ((typeof sld != 'undefined')&&(sld !== null)&&(sld != "")){
				var sldParams = [{wmsName: layerObj.name, layerStyle: sld}];
				//layerObj.sld = escape(this.mapObject.createSLDFromParams(sldParams));
				layerObj.sld = this.mapObject.createSLDFromParams(sldParams);
			}
			layerObj.layerId = currentLayer.name;
			requestObj.layers.push(layerObj);
		}

		var bbox;
		bbox = this.mapObject.getExtent().toBBOX();

		requestObj.format = format;
		requestObj.bbox = bbox;
		requestObj.srs = 'EPSG:900913';
		requestObj.width = jQuery('#map').width();
		requestObj.height = jQuery('#map').height();
		//return a url from the servlet
		var params = {
				url: "requestImage",
				data: JSON.stringify(requestObj),
				dataType: "json",
				type: "POST",
				context: this,
				complete: function(){
				},
				success: function(data){
					OpenGeoportal.ogp.downloadQueue.registerImageRequest(data.requestId, requestObj);

					//should parse errors
					//will also have status info for requested layers in this returned object
					/*var line = "";
				for (var failedToDownload in data.errors){
					line += "<tr>";
					//for (var infoElement in data.failed[failedToDownload]){
						line += "<td>";
						line += '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>';
						line += "</td>";
						line += "<td>";
						//line += data.failed[failedToDownload]["institution"];
						line += "</td>";						
						line += "<td>";
						//line += data.failed[failedToDownload]["title"];
						line += "</td>";						
						line += "<td>";
						//line += data.failed[failedToDownload]["layerId"];
						line += "</td>";
						line += '<td><span class="warning">';
						//line += data.failed[failedToDownload]["message"];
						line += "</span></td>";
					//}
					line += "</tr>";
				}
				if (line.length > 0){
					var message = '<table class="downloadStatus">';
					message += line;
					message += "</table>";
					this.genericModalDialog(message, "DOWNLOAD ERRORS");
				}*/
					//check packageLink
					/*if (typeof data.imageLink != 'undefined'){
						var downloadFrameId;
						do {
							downloadFrameId = "downloadFrame" + parseInt(Math.random() * 10000);
						} while (jQuery("#" + downloadFrameId).length > 0)
						var that = this;
						this.utility.showLoadIndicator("mapLoadIndicator", downloadFrameId);
						jQuery("body").append('<iframe id="' + downloadFrameId + '" style="display:none" src="' + data.imageLink + '"></iframe>');
						jQuery("#" + downloadFrameId).bind("load", function(e){
							that.utility.hideLoadIndicator("mapLoadIndicator", downloadFrameId);
						});
				}*/


				}
		};

		jQuery.ajax(params);
		this.toProcessingAnimation(jQuery("#map_tabs > span").first());


	};

//	based on Dave's code
	this.getParamsFromUrl = function() {
		var params = {};
		var layers = [], hash;
		var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
		for(var i = 0; i < hashes.length; i++) {
			hash = hashes[i].split('=');
			if ((hash[0] == "layer%5B%5D")||(hash[0] == "layer[]")){
				layers.push(hash[1]);
			} else {
				params[hash[0]] = hash[1];
			}
		}
		if (layers.length > 0){
			params.layer = layers;
		}
		return params;
	};

	this.addSharedLayersToCart = function(){
		var params = this.getParamsFromUrl();

		if (typeof params.layer == 'undefined'){
			return;
		}
		var solr = new OpenGeoportal.Solr();
		var query = solr.getInfoFromLayerIdQuery(params.layer);
		solr.sendToSolr(query, this.getLayerInfoJsonpSuccess, this.getLayerInfoJsonpError, this);
		var sharedExtent = params.minX + ',' + params.minY + ',' + params.maxX + ',' + params.maxY;
		this.mapObject.zoomToLayerExtent(sharedExtent);
		jQuery("#tabs").tabs("option", "active", 2);
		this.initSortable();
	};

	this.getLayerInfoJsonpSuccess = function(data, newContext){
		//wrong context? not sure
		newCartData = newContext.cartTableObject.processData(data);
		for(var i in newCartData){
			newContext.addLayerToCart(newCartData[i]);
		}
	};

	this.getLayerInfoJsonpError = function(){
		throw new Error("The attempt to retrieve layer information from layerIDs failed.");
	};
//	solr query against layerIds
//	process data functions, pass to this function
	this.addLayerToCart = function(layerData){
		var savedTable = jQuery('#savedLayers').dataTable();
		var currentData = savedTable.fnGetData();
		layerData = [layerData];
		var newData = layerData.concat(currentData);
		savedTable.fnClearTable();
		savedTable.fnAddData(newData);
		this.updateSavedLayersNumber();
		//jQuery('#savedLayersNumber').text('(' + OpenGeoportal.cartTableObject.numberOfResults() + ')');
		//console.log(layerData);
		var headingsObj = this.cartTableObject.tableHeadingsObj;
		var layerID = layerData[0][headingsObj.getColumnIndex('LayerId')];
		var dataType = layerData[0][headingsObj.getColumnIndex('DataType')];
		if (!this.layerStateObject.layerStateDefined(layerID)){
			this.layerStateObject.addNewLayer(layerID, {"dataType": dataType, "inCart": true});
		} else {
			this.layerStateObject.setState(layerID, {"inCart": true});
		}
	};

	this.shortenLink = function(longLink){
		var request = {"link": longLink};
		var url = "shortenLink";
		var that = this;
		var ajaxArgs = {url: url, 
				data: jQuery.param(request),
				type: "GET", 
				dataType: "json",
				success: function(data){
					var shortLink = data["shortLink"];
					jQuery("#shareText").attr("rows", that.calculateRows(shortLink));
					jQuery("#shareDialog").dialog('open');
					jQuery("#shareText").text(shortLink).focus();} 
		};

		jQuery.ajax(ajaxArgs);
	};

	this.calculateRows = function(theText){
		var numCharacters = theText.length;
		var rows = 1;
		if (numCharacters > 75){
			rows = Math.floor(numCharacters/40);
		}
		return rows;
	};

	this.shareLayers = function(){
		var layers = [];
		var layerObj = this.getLayerList("shareLink");
		for (var layer in layerObj){
			layers.push(layer);
		}
		var dialogContent = "";
		if (layers.length == 0){
			dialogContent = 'No layers have been selected.';
			//this should probably call a dialog instance for error messages/notifications
		} else {
			var path = top.location.href.substring(0, top.location.href.lastIndexOf("/"));
			var shareLink = path + "/openGeoPortalHome.jsp";
			var geodeticBbox = this.mapObject.getGeodeticExtent();
			var queryString = '?' + jQuery.param({ layer: layers, minX: geodeticBbox.left, minY: geodeticBbox.bottom, maxX: geodeticBbox.right, maxY: geodeticBbox.top });
			shareLink += queryString;

			dialogContent = '<textarea id="shareText" class="linkText" ></textarea> \n';
			dialogContent += '<p>Use this link to share this Cart</p>';
			this.shortenLink(shareLink);
		}

		this.createShareDialog(dialogContent);
	};

	this.createShareDialog = function(dialogContent){
		if (typeof jQuery('#shareDialog')[0] == 'undefined'){
			var shareDiv = '<div id="shareDialog" class="dialog"> \n';
			shareDiv += dialogContent;
			shareDiv += '</div> \n';
			jQuery('body').append(shareDiv);
			jQuery("#shareDialog").dialog({
				zIndex: 3000,
				autoOpen: false,
				width: 495,
				height: 'auto',
				title: 'SHARE CART',
				resizable: false,
				buttons: {
					Close: function() {
						jQuery(this).dialog('close');
						jQuery("#optionDetails").html("");
						jQuery(".downloadSelection, .downloadUnselection").removeClass("downloadSelection downloadUnselection");
					}
				}});
		} else {
			//replace dialog text/controls & open the instance of 'dialog' that already exists
			jQuery("#shareDialog").html(dialogContent);
		}
		jQuery('#shareText').focus(function(){
			// Select input field contents
			this.select();
		});
	};

	this.shareServices = function(){
		var layerList = this.getLayerList("webService");
		var dialogContent = "";
		var queryString = [];
		for (var layerId in layerList){
			//console.log(layerId);
			//console.log(layerList[layerId]);
			if (layerList[layerId]["access"].toLowerCase() == "public"){
				//console.log({LayerId: layerId});
				queryString.push(layerId);
			}
		}
		if (queryString.length == 0){
			dialogContent = 'No layers have been selected.';
		} else {
			//console.log(queryString);
			//console.log(jQuery.param(queryString, true));
			var serviceTypes = [{"type": "WFS", "title": "Web Feature Service (WFS):", "caption": "Creates a vector web service. Only available for vector data."}, 
			                    {"type":"WMS", "title": "Web Mapping Service (WMS):", "caption": "Creates a raster web service for all your data. Vector data will be converted to raster format."}];//WCS later?  		   		
			var path = top.location.href.substring(0, top.location.href.lastIndexOf("/"));
			dialogContent += '<p>Web Services are provided in two formats. Paste the selected link into your desktop mapping software.</p>';
			dialogContent += '<div id="owsServicesArea">\n';
			for (var i in serviceTypes){
				dialogContent += '<span class="sub_headerTitle">' + serviceTypes[i].title + '</span><a href="#">?</a>';
				dialogContent += '<br/><span>' + serviceTypes[i].caption + '</span>';
				dialogContent += '<div class="owsServicesLinkContainer">';
				var dynamicCapabilitiesRequest = path + "/ogp" + serviceTypes[i].type + ".jsp?OGPIDS=" + queryString.join();
				dialogContent += '<textarea class="shareServicesText linkText" >' + dynamicCapabilitiesRequest + '</textarea> <br />\n';
				dialogContent += '</div><br/>';
			}

			dialogContent += '</div>';

		}


		if (typeof jQuery('#shareDialog')[0] == 'undefined'){
			var shareDiv = '<div id="shareServicesDialog" class="dialog"> \n';
			shareDiv += '</div> \n';
			jQuery('body').append(shareDiv);
			jQuery("#shareServicesDialog").dialog({
				zIndex: 3000,
				autoOpen: false,
				height: 'auto',
				title: 'WEB SERVICES',
				width: 495,
				buttons: {
					Close: function() {
						jQuery(this).dialog('close');
						jQuery("#optionDetails").html("");
						jQuery(".downloadSelection, .downloadUnselection").removeClass("downloadSelection downloadUnselection");
					}
				}});
		} 
		//replace dialog text/controls & open the instance of 'dialog' that already exists
		jQuery("#shareServicesDialog").html(dialogContent);
		var that = this;
		jQuery(".shareServicesText").each(function(){
			jQuery(this).attr("rows", that.calculateRows(jQuery(this).text()));
		});

		jQuery("#shareServicesDialog").dialog('open');

		jQuery('.shareServicesText').bind("focus", function(){
			// Select input field contents
			this.select();
		});
		jQuery('.shareServicesText').first().focus();

	};

	/*
	 * 
	 * login code
	 * 
	 */



	this.logoutResponse = function() {
		var that = this;
		jQuery(document).on("logoutSucceeded", function(event){
			jQuery("#headerLogin").text("Login").unbind("click");
			jQuery("#headerLogin").click(function(event){that.promptLogin(event);});
			that.changeControlsToLoginButtons(that.config.getHomeInstitution());//get local inst.
			//
			//will also need to turn on login labels for layers in search results and cart, remove 
			//restricted layers from preview?
			//should we logout on page load to prevent weird states? or just check the state at page load?
		});
	};

	this.promptLogin = function(event){
		this.login.loginDialog();
	};


	this.changeLoginButtonsToControls = function(){
		//change login button to checkbox for institution logged in
		var that = this;
		//loginButton login
		//previewControl previewOff
		jQuery(".colPreview .loginButton").each(function(){
			var node = jQuery(this).closest("tr");
			var tableObject = node.closest("table");
			var tableName = tableObject.attr("id");
			tableObject = tableObject.dataTable();
			var pos = tableObject.fnGetPosition(node[0]);
			var row = tableObject.fnGetData(pos);
			var rowObj = {};
			rowObj.aData = row;
			if (tableName == "searchResults"){
				jQuery(this).parent().html(that.resultsTableObject.getActivePreviewControl(rowObj));
			} else if (tableName == "savedLayers"){
				jQuery(this).parent().html(that.cartTableObject.getActivePreviewControl(rowObj));	
			}
		});
	};

	this.changeControlsToLoginButtons = function(logoutInstitution){
		//change checkbox to login button for institution logged out
		var that = this;
		jQuery(".colPreview .previewControl").each(function(){
			var node = jQuery(this).closest("tr");
			var tableObject = node.closest("table");
			var tableName = tableObject.attr("id");
			tableObject = tableObject.dataTable();
			var pos = tableObject.fnGetPosition(node[0]);
			var row = tableObject.fnGetData(pos);
			var rowObj = {};
			rowObj.aData = row;
			if (tableName == "searchResults"){
				jQuery(this).parent().html(that.resultsTableObject.getPreviewControl(rowObj));
			} else if (tableName == "savedLayers"){
				jQuery(this).parent().html(that.cartTableObject.getPreviewControl(rowObj));	
			}

		});
	};

	this.applyLoginActions = function(){
		// how do we update the UI so the user know login succeeded?
		this.changeLoginButtonsToControls();
		//change the login button in top right to logout
		var that = this;
		//console.log(this);
		jQuery("#headerLogin").text("Logout");
		jQuery("#headerLogin").unbind("click");
		jQuery("#headerLogin").click(function(event){event.preventDefault();
		//for logout capability
		that.login.processLogout();
		/*var ajaxArgs = {url: "logout", 
			crossDomain: true,
			xhrFields: {
				withCredentials: true
				},
			context: that,
			dataType: "json",
			success: that.logoutResponse
			};
		jQuery.ajax(ajaxArgs);*/
		});
	};
	/*
// callback handler invoked when if an error occurs during ajax call to authenticate a user
OpenGeoportal.UserInterface.prototype.loginResponseError = function(jqXHR, textStatus, errorThrown)
{
	alert("an error occured during log in: " + textStatus);
	this.userId = null;
};
	 */

	/*
	 * ---------------------------------------------------------------
	 */

//	toggle the attribute info button & functionality
	this.toggleFeatureInfo = function(thisObj, layerID, displayName){
		var layerStateObject = this.layerStateObject;
		if (!layerStateObject.getState(layerID, "getFeature")){
			//update layer state
			layerStateObject.setState(layerID, {"getFeature": true});
			layerStateObject.getFeatureTitle = displayName;
		} else {
			//update layer state, turn off get feature 
			layerStateObject.setState(layerID, {"getFeature": false});
		}

	};

//	get the color from the layer state object to use for the shown swatch
	this.setPaletteColor = function(layerID){
		var paletteColor = this.layerStateObject.getState(layerID, "color");
		var escapedLayerID = this.utility.idEscape(layerID);
		jQuery(".colorPalette").each(function(){
			//console.log(["iterate", paletteColor]);
			if (jQuery(this).is('[id$=' + escapedLayerID + ']')){
				//console.log("match");
				jQuery(this).css("background-color", paletteColor);
			}
		});
	};

	this.colorDialogHandler = function(){
		var that = this;
		jQuery(document).on("view.openColorChooser", function(event, data){
			that.colorDialog(data.layerId);
		});
	};
//	create the color picker dialog box
	this.colorDialog = function(layerID){
		//create a hidden div w/ the dialog info
		//create a new dialog instance, or just open the dialog if it already exists
		//if it already exists, function should reset color picker to match layer

		//has to know the layerId so layerState can be updated.
		//sync ui can send an event that the color dialog, color control, and map style function can be bound to, so that they can update
		var allColors = {};
		allColors.grey = ["#828282", "#aaaaaa", "#b2b2b2", "#cccccc", "#e1e1e1", "#ffffff"];
		allColors.red = ["#730000", "#a80000", "#e80000", "#ff0000", "#ff7f7f", "#ffbebe"];
		allColors.darkOrange = ["#732600", "#a83800", "#e64c00", "#ff5500", "#ffa77f", "#ffebbe"];
		allColors.orange = ["#734c00", "#a87000", "#e69800", "#ffaa00", "#ffd37f", "#ffebaf"];
		allColors.yellow = ["#737300", "#a8a800", "#e6e600", "#ffff00", "#ffff73", "#ffffbe"];
		allColors.grassGreen = ["#426e00", "#6da800", "#98e600", "#aaff00", "#d1ff73", "#e9ffbe"];
		allColors.green = ["#267300", "#38a800", "#4ce600", "#55ff00", "#a3ff73", "#d3ffbe"];
		allColors.cyan = ["#00734c", "#00a884", "#00e6a9", "#00ffc5", "#73ffdf", "#beffe8"];
		allColors.blue = ["#004c73", "#0084a8", "#00a9e6", "#00c5ff", "#73dfff", "#bee8ff"];
		allColors.indigo = ["#002673", "#0049a9", "#005ce6", "#0070ff", "#73b2ff", "#bed2ff"];
		allColors.violet = ["#4c0073", "#8400a8", "#a900e6", "#c500ff", "#df73ff", "#e8beff"];
		allColors.pink = ["#780f52", "#a80084", "#e00fa7", "#ff00c5", "#ff73df", "#ffbee8"];

		var currentColorSelection = this.layerStateObject.getState(layerID, "color");
		
		var colorDialog$ = jQuery('#colorDialog');
		if (colorDialog$.length == 0){
			var dialogDiv = '<div id="colorDialog" class="dialog"> \n';
			dialogDiv += '</div> \n';
			jQuery('body').append(dialogDiv);
			colorDialog$ = jQuery('#colorDialog');
		}

		var colorDiv = '<table><tbody>';
		for (var row in allColors){
			colorDiv += '<tr>';
			for (var cell in allColors[row]){
				colorDiv += '<td class="colorCellParent">';
				var currentColorValue = allColors[row][cell];
				var selectionClass;
				if (currentColorValue == currentColorSelection){
					selectionClass = " colorCellSelected";
				} else {
					selectionClass = "";
				}
				colorDiv += '<div class="colorCell' + selectionClass + '" style="background-color:' + allColors[row][cell] + '"></div>';
				colorDiv += '</td>';
			}
			colorDiv += '</tr>';
		}
		colorDiv += '</tbody></table>';
		colorDialog$.html(colorDiv);
		colorDialog$.dialog({
			zIndex: 2999,
			autoOpen: false,
			width: 'auto',
			height: 'auto',
			title: "COLORS",
			resizable: false
		});    	  
		colorDialog$.dialog('open');
		
		//until someone thinks of something better
		colorDialog$.data("data", {"layerId": layerID});
	};

	this.selectColorCellHandler = function(){
		var that = this;
		jQuery(document).on("click", ".colorCell", function(event){
			var selectedColor = jQuery(this).css("background-color");
			if (selectedColor.indexOf("rgb") > -1){
				selectedColor = that.utility.rgb2hex(selectedColor);
			}
			var colorDialog$ = jQuery('#colorDialog');
			var layerID = colorDialog$.data("data").layerId;
			//console.log("setting color state: " + layerID + " " + selectedColor);
			
			that.layerStateObject.setState(layerID, {color: selectedColor});	//here's where things happen
		});
	};

	this.viewChangeColorCell = function(layerID, selectedColor){
		//needs TLC
		
		//thisObj, layerID, dataType
		jQuery('.colorCell').removeClass('colorCellSelected');
		jQuery(thisObj).addClass('colorCellSelected');
		this.setPaletteColor(layerID);
		//OpenGeoportal.map.changeStyle(layerID, dataType);
		this.mapObject.changeStyle(layerID, dataType);
	};

//	toggle whether the applied style has an outline
	this.toggleOutline = function(thisObj, layerID, dataType){
		//sets state object to match checkbox value, calls map function to apply the style to the layer
		var layerStateObject = this.layerStateObject;
		if (jQuery(thisObj).is(':checked') == true){
			layerStateObject.setState(layerID, {"graphicWidth": 1});
		} else {
			layerStateObject.setState(layerID, {"graphicWidth": 0}); 
		}
		//OpenGeoportal.map.changeStyle(layerID, dataType); 
		this.mapObject.changeStyle(layerID, dataType);  
	};

	this.mouseCursor = function(){
		var that = this;
		var layerStateObject = this.layerStateObject;
		jQuery('.olMap').css('cursor', "-moz-grab");
		jQuery(document).bind('zoomBoxActivated', function(){
			//jQuery(document).on('click', 'div.olControlZoomBoxItemInactive', function(){
			jQuery('.olMap').css('cursor', "-moz-zoom-in");
			var mapLayers = that.mapObject.layers;
			for (var i in mapLayers){
				var currentLayer = mapLayers[i];
				if (layerStateObject.layerStateDefined(currentLayer.name)){
					if (layerStateObject.getState(currentLayer.name, "getFeature")){
						that.mapObject.events.unregister("click", currentLayer, that.mapObject.wmsGetFeature);
						layerStateObject.setState(currentLayer.name, {"getFeature": false});
					}
				} else {
					continue;
				}
			}
			layerStateObject.resetState('getFeature');
			jQuery('.attributeInfoControl').attr('src', that.utility.getImage('preview.gif'));
		});
		jQuery(document).bind('panActivated', function(){
//			jQuery(document).on('click', '.olControlNavigationItemActive', function(){
			jQuery('.olMap').css('cursor', "-moz-grab");
			//var mapLayers = OpenGeoportal.map.layers;
			var mapLayers = that.mapObject.layers;
			for (var i in mapLayers){
				var currentLayer = mapLayers[i];
				if (layerStateObject.layerStateDefined(currentLayer.name)){
					if (layerStateObject.getState(currentLayer.name, "getFeature")){
						that.mapObject.events.unregister("click", currentLayer, that.mapObject.wmsGetFeature);
						layerStateObject.setState(currentLayer.name, {"getFeature": false});
					}
				} else {
					continue;
				}
			}
			layerStateObject.resetState('getFeature');
			jQuery('.attributeInfoControl').attr('src', that.utility.getImage('preview.gif'));
		});
	};

	this.getImage = function(imageName){
		return this.utility.getImage(imageName);
	}

	this.resizePanels = function(){
		var that = this;
		jQuery("#map").resizable({handles: 'w', ghost: true,
			minWidth: 512, //min full extent map
			maxWidth: jQuery("#container").width() - 381, //left_col.outerWidth(), both tabs in line
			stop: function(event, ui) {
				//var widthDelta = ui.size.width - ui.originalSize.width;
				var newWidth = jQuery("#container").width() - jQuery("#map").width();
				jQuery("#map").css("left", 0);
				jQuery("#left_col").outerWidth(newWidth);
				that.setSearchPanelWidth(newWidth);

				that.utility.whichTab().tableObject().getTableObj().fnDraw();
				that.mapObject.updateSize();
			}
		});
	};

	this.createExportParams = function(){
		var exportParams = {};
		exportParams.layers = this.getLayerList("mapIt");
		exportParams.extent = {};
		exportParams.extent.global = this.mapObject.getSpecifiedExtent("global");
		exportParams.extent.current = this.mapObject.getSpecifiedExtent("current");
		exportParams.extent.maxForLayers = this.mapObject.getSpecifiedExtent("maxForLayers", exportParams.layers);
		return exportParams;
	};

	this.cartOptionText = function(){
		var noSelectionHtml = "Choose what to do with layers in your Cart";
		jQuery("#optionDetails").html(noSelectionHtml);
		var mapItHtml = "Open highlighted layers in GeoCommons to create maps";
		var shareHtml = "Create a link to share this Cart";
		var webServiceHtml = "Stream highlighted layers into an application";
		var downloadHtml = "Download highlighted layers to your computer";
		var that = this;
		jQuery("#mapItButton").hover(function(){jQuery("#optionDetails").html(mapItHtml);that.getLayerList("mapIt");},
				function(){jQuery("#optionDetails").html(noSelectionHtml);jQuery(".downloadSelection, .downloadUnselection").removeClass("downloadSelection downloadUnselection");});
		jQuery("#mapItButton").click(function(){console.log(that.getLayerList("mapIt"));var geoCommonsExport = new OpenGeoportal.Export.GeoCommons(that.createExportParams());
		geoCommonsExport.exportDialog(that);});
		//jQuery("#mapItButton").click(function(){jQuery("#mapitNotice").dialog("open")});
		jQuery("#shareButton").hover(function(){jQuery("#optionDetails").html(shareHtml);that.getLayerList("shareLink");},
				function(){if ((jQuery("#shareDialog").length == 0)||(!jQuery("#shareDialog").dialog("isOpen"))){jQuery("#optionDetails").html(noSelectionHtml);
				jQuery(".downloadSelection, .downloadUnselection").removeClass("downloadSelection downloadUnselection");}});
		jQuery("#shareButton").click(function(){that.shareLayers();});
		jQuery("#webServiceButton").hover(function(){jQuery("#optionDetails").html(webServiceHtml);that.getLayerList("webService");},
				function(){if ((jQuery("#shareServicesDialog").length == 0)||(!jQuery("#shareServicesDialog").dialog("isOpen"))){jQuery("#optionDetails").html(noSelectionHtml);	
				jQuery(".downloadSelection, .downloadUnselection").removeClass("downloadSelection downloadUnselection");}});
		jQuery("#webServiceButton").click(function(){that.shareServices();});
		jQuery("#downloadButton").hover(function(){jQuery("#optionDetails").html(downloadHtml);that.getLayerList("download");},
				function(){if ((jQuery("#downloadDialog").length == 0)||(!jQuery("#downloadDialog").dialog("isOpen"))){jQuery("#optionDetails").html(noSelectionHtml);
				jQuery(".downloadSelection, .downloadUnselection").removeClass("downloadSelection downloadUnselection");}});
		jQuery("#downloadButton").click(function(){that.downloadDialog();});
		jQuery("#removeFromCartButton").hover(function(){that.getLayerList("removeFromCart");},
				function(){jQuery(".downloadSelection, .downloadUnselection").removeClass("downloadSelection downloadUnselection");});
		jQuery("#removeFromCartButton").click(function(){that.cartTableObject.removeRows();}); 
	};

	this.anchorsToNiceScroll = function(affectedDiv, offsetHash){
		jQuery("#" + affectedDiv + " a.niceScroll").click(function(event){
			event.preventDefault();
			//parse the hrefs for the anchors in this DOM element into toID
			var toID = jQuery(this).attr("href");
			jQuery("#" + affectedDiv).scrollTo(jQuery(toID), {offset: offsetHash });
		});
	};

	this.dialogTemplate = function dialogTemplate(dialogDivId, dialogContent, dialogTitle, buttonsObj) {
		if (typeof jQuery('#' + dialogDivId)[0] == 'undefined'){
			var dialogDiv = '<div id="' + dialogDivId + '" class="dialog"> \n';
			dialogDiv += dialogContent;
			dialogDiv += '</div> \n';
			jQuery('body').append(dialogDiv);
			jQuery("#" + dialogDivId).dialog({
				zIndex: 3000,
				autoOpen: false,
				width: 'auto',
				title: dialogTitle.toUpperCase(),
				resizable: true,
				buttons: buttonsObj
			});
		} else {
			//replace dialog text/controls & open the instance of 'dialog' that already exists
			jQuery("#" + dialogDivId).html(dialogContent);
			jQuery("#" + dialogDivId).dialog("option", "buttons", buttonsObj);

		}
		jQuery("#" + dialogDivId).dialog('open');
	};

	this.minimizeDialog = function(dialogId){
		//1. collect current state of dialog before minimizing.
		//2. attach that info to the dialog element (jQuery.data)
		//3. also attach a flag that indicates minimized or not
		//4. minimize the dialog. (header bar only)
		//5. change position to lower right corner (fixed to bottom of window)
		//6. animate the movement
		//can I just toggle a class?
		//7. animated message in toolbar that describes what's being done
		if (!this.isDialogMinimized(dialogId)) {
			jQuery("#" + dialogId).data({"minimized": true});
			var position = jQuery("#" + dialogId).dialog( "option", "position" );
			jQuery("#" + dialogId).data({"maxPosition": position});
			jQuery("#" + dialogId).parent().children().each(
					function(){
						if (!jQuery(this).hasClass("ui-dialog-titlebar")){
							jQuery(this).hide();
						}
					});
			jQuery("#" + dialogId).dialog("option","position", ["right","bottom"]);
			jQuery("#" + dialogId).parent().css("position", "fixed");
		}
	};

	this.isDialogMinimized = function(dialogId){
		var result;
		/*if (typeof jQuery("#" + dialogId).data() == "undefined"){
		jQuery("#" + dialogId).data({"minimized": false});
		result = false;
	} else if (jQuery("#" + dialogId).data() == null){
		jQuery("#" + dialogId).data({"minimized": false});
		result = false;
	} else*/ if (jQuery("#" + dialogId).data().minimized) {
		result = true;
	} else {
		result = false;
	}
	//console.log(jQuery("#" + dialogId).data().minimized);
	return result;
	};

	this.maximizeDialog = function(dialogId){
		//1. check minimized flag
		//2. read stored state values
		//3. apply stored state values
		//4. animate the movement
		//5. turn off animated message (?)
		if (this.isDialogMinimized(dialogId)) {
			jQuery("#" + dialogId).parent().children().each(
					function(){
						if (!jQuery(this).hasClass("ui-dialog-titlebar")){
							jQuery(this).show();
						}
					});
			jQuery("#" + dialogId).data({"minimized": false});
			var position = jQuery("#" + dialogId).data().maxPosition;
			jQuery("#" + dialogId).dialog("option", "position", position);
			jQuery("#" + dialogId).parent().css("position", "absolute");
		}
		//>>> jQuery("#geoCommonsExportDialog").dialog("option", "position", jQuery("#geoCommonsExportDialog").data("maxPosition"))
	};

	this.previewControlShowOn = function(thisObj){
		var previewControl$ = jQuery(thisObj);
		previewControl$.removeClass("previewOff").addClass("previewOn");
		var hideLayerText = "Turn off layer preview on the map";
		previewControl$.attr("title", hideLayerText);
	};

	this.previewControlShowOff = function(thisObj){
		var previewControl$ = jQuery(thisObj);
		previewControl$.removeClass("previewOn").addClass("previewOff");
		var showLayerText = "Preview layer on the map";
		previewControl$.attr("title", showLayerText);
	};

	this.previewViewHandler = function(){
		var that = this;
		jQuery(document).on("view.showPreviewOn", function(event){
			//console.log(event);
			that.previewControlShowOn(event.target);
		});
		jQuery(document).on("view.showPreviewOff", function(event){
			//console.log(event);
			that.previewControlShowOff(event.target);
		});
	};


	this.autocomplete = function(){

		jQuery( "#advancedOriginatorText" ).autocomplete({
			source: function( request, response ) {
				var solr = new OpenGeoportal.Solr();
				var fieldName = "OriginatorSort";
				var query = solr.getTermQuery(fieldName, request.term);
				var facetSuccess = function(data){
					var labelArr = [];
					var dataArr = data.terms[fieldName];
					for (var i in dataArr){
						if (i%2 != 0){
							continue;
						}
						var temp = {"label": dataArr[i], "value": '"' + dataArr[i] + '"'};
						labelArr.push(temp);
						i++;
						i++;
					}
					response(labelArr);
				};
				var facetError = function(){};
				solr.termQuery(query, facetSuccess, facetError, this);

			},
			minLength: 2,
			select: function( event, ui ) {

			},
			open: function() {
				jQuery( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
			},
			close: function() {
				jQuery( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
			}
		});
	};

	this.infoBubble = function(infoHtml, optionsObj){

		var arrowDirection = "top-arrow";//default value
		if (optionsObj.arrow == 'top'){
			arrowDirection = "top-arrow";
		} else if (optionsObj.arrow == "left"){
			arrowDirection = "left-arrow";
		}
		var selector = jQuery(".infoBubble").length + 1;
		var closeBubble = '<div class="closeBubble button"></div>';
		var doNotShow = '<label><input type="checkbox"/>Do not show this screen again</label>';
		var infoBubble = '<div class="infoBubbleText triangle-isosceles ' + arrowDirection + '">' + closeBubble + infoHtml + doNotShow + '</div>';
		var infoBubbleMain = '<div id="infoBubble' + selector + '" class="infoBubbleBackground triangle-isoscelesBackground ' + arrowDirection + 'Background">' + infoBubble + '</div>';

		jQuery("body").append(infoBubbleMain);
		jQuery("#infoBubble" + selector).height(optionsObj.height + 4).width(optionsObj.width + 4).css("top", optionsObj.top - 2).css("left", optionsObj.left -2);
		jQuery("#infoBubble" + selector + " > .infoBubbleText").height(optionsObj.height).width(optionsObj.width);
		var infoBubble$ = jQuery("#infoBubble" + selector);
		infoBubble$.on("click", ".closeBubble", function(){infoBubble$.hide();}).show();

		return infoBubble$;
	};

};

