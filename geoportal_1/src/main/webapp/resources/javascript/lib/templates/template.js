if (typeof OpenGeoportal == 'undefined'){
	OpenGeoportal = {};
} else if (typeof OpenGeoportal != "object"){
    throw new Error("OpenGeoportal already exists and is not an object");
}

OpenGeoportal.Template = function() {
	 
	this.dataTable = _.template('<table id="<%= tableId %>" class="display"></table>');
	
	var mapToolBarHtml = '<div id="mapToolBar"><div id="ogpMapButtons">'
		+ '<div id="mapLoadIndicator" class="loadIndicator"></div>'
		+ '</div>'
		+ '</div>';
	
	this.map = _.template(mapToolBarHtml + '<div id="<%= mapId %>OLMap"></div>');
			
	this.mapButton = _.template('<span class="mapStyledButton <%= displayClass %>" title="<%= title %>" ><%= buttonText %></span>');
	this.basemapMenu = _.template('<div id="basemapMenu"></div>');

	 var selectHtml =  '<div class="styledSelect">' +
	  "<div>" +
	    '<button class="select"><%= buttonLabel %></button>' +
	  "</div>" +
	  "<ul><%= menuHtml%></ul>" ;//+
	  '</div>';

	this.styledSelectBody = _.template(selectHtml);
	
    var simpleMenuHtml = '<li><a class="<%= className %>"><%= name %></a>' +
    	'<input type="hidden" value="<%= value %>" /></li>';
    this.simpleMenuItem = _.template(simpleMenuHtml);

    var controlMenuHtml = '<li><a class="<%= className %>"><%= icon %><div class="selectText"><%= name %></div><%= control %></a>';
	controlMenuHtml += '<input type="hidden" value="<%= value %>" /></li>';
    this.controlMenuItem = _.template(controlMenuHtml);

    var genericButtonHtml = '<div id="<%= buttonId %>" class="button"><%= buttonLabel %></div>';
    this.genericButton = _.template(genericButtonHtml);
    
    var dialogHeaderButtonHtml = '<div id="<%= buttonId %>" class="<%= displayClass %> button"><%= buttonLabel %></span>';
    this.dialogHeaderButton = _.template(dialogHeaderButtonHtml);

 	/***************
	 * Preview Tools
	 *************/
	//html content/formatting for expanded row
	var previewToolHtml = '<div class="previewControls"><%=toolsMarkup%>';
	previewToolHtml += '</div>';
	this.previewTools = _.template(previewToolHtml);
	
	var sliderHtml = '<div class="<%=controlClass%>">';
	sliderHtml +=		'<div class="sliderControl">';
	sliderHtml += 			'<div class="sliderDisplay">';
	sliderHtml += 				'<span class="sliderLabel"><%=label%>:</span>';
	sliderHtml += 				'<span class="sliderValue"><%=value%></span>';
	sliderHtml += 				'<span class="sliderUnits"><%=units%></span>';
	sliderHtml += 			'</div>';
	sliderHtml += 			'<div class="sliderArrow button"></div>';
	sliderHtml += 			'<div class="controlContainer">';
	sliderHtml +=				'<div class="previewToolsSlider" title="<%=tooltip%>"></div>';
	sliderHtml += 			'</div>';
	/* remove the class "previewToolsSlider" to use the default jquery ui slider */
	sliderHtml += '</div></div>';
	
	this.sliderControl = _.template(sliderHtml);
	
	var colorHtml = '<div class="colorControlCell"><div class="colorControl button" title="Change the layer color" style="background-color:<%=color%>"></div></div>';
	this.colorControl = _.template(colorHtml);


	//can probably make all of these from this generic control html
	var zoomHtml = '<div class="button zoomToLayerControl" title="Zoom to geographic extent of layer"></div>';
	this.zoomControl = _.template(zoomHtml);

	var getFeatureHtml = '<div class="button attributeInfoControl <%=toolClass%>" title="Click a previewed feature on the map to view its attributes"></div>';
	this.getFeatureControl = _.template(getFeatureHtml);
	
	var genericControl = '<div class="button <%= controlClass %> <%=displayClass%>" title="<%= tooltip %>"><%= text %></div>';
	this.genericControl = _.template(genericControl);

	var genericIconHtml = 	'<div class="<%= controlClass %> <%= displayClass %>" title="<%= tooltip %>"><%= text %></div>';
	this.genericIcon = _.template(genericIconHtml);
	
	var genericDialogHtml = '<div id="<%= id %>" class="dialog"></div>';
	this.genericDialogShell = _.template(genericDialogHtml);
	
	var metadataContentHtml = '<div id="toMetadataTop"></div><div id="metadataContent"></div><div id="metadataFooter"><%= layerId %></div>';
	this.metadataContent = _.template(metadataContentHtml);
	
	var iframeDownloadHtml = '<iframe class="<%= iframeClass%>" src="<%= iframeSrc %>" onload="jQuery(document).trigger(\'iframeload\')"/>';
	this.iframeDownload = _.template(iframeDownloadHtml);

	var defaultDownloadCheckboxHtml = '<input type="checkbox" class="cartCheckBox" checked />';
	this.defaultDownloadCheckbox = _.template(defaultDownloadCheckboxHtml);
	
	//var list = "<% _.each(people, function(name) { %> <li><%= name %></li> <% }); %>";
	var attributeTableHtml = '<table class="attributeInfo">' +
			'<caption class="getFeatureTitle offsetColor" title="<%= layerId %>"><%= title %></caption>' +
			"<% _.each(tableContent, " +
			"function(rowObj) { %><tr><td class=\"attributeName\" ><%= rowObj.header %></td><%  _.each(rowObj.values, " +
			"function(value) { %><td><%= value %></td> <% }); %></tr><% }); %>" +
			"</table>";
	this.attributeTable= _.template(attributeTableHtml);
};