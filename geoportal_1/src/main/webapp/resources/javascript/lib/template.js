if (typeof OpenGeoportal == 'undefined'){
	OpenGeoportal = {};
} else if (typeof OpenGeoportal != "object"){
    throw new Error("OpenGeoportal already exists and is not an object");
}

OpenGeoportal.Template = function() {
	 
	this.dataTable = _.template('<table id="<%= tableId %>" class="display"></table>');
	
	var mapToolBarHtml = '<div id="mapToolBar">'
		+ '<div id="mapLoadIndicator" class="loadIndicator"></div>'
		+ '<div id="ogpMapButtons"></div>'
		+ '</div>';
	
	this.map = _.template(mapToolBarHtml + '<div id="<%= mapId %>OLMap"></div>');
			
	this.mapButton = _.template('<span class="mapStyledButton <%= displayClass %>" title="<%= title %>"><%= buttonText %></span>');


	
	
	
	/*
	 * <div id="mapToolBar" class="shadowDown">
	<div id="mapLoadIndicator" class="loadIndicator"></div> 
	<div id="ogpMapButtons"> 
		<!-- <span class="mapStyledButton saveImageButton" title="Save map image">Save Image</span>
		<span class="mapStyledButton printButton" title="Print map">Print</span>
		<div id="basemapDropdown">
			<button id="basemapSelect" class="mapStyledButton" title="Select base map">
				<span>Basemap<img src="resources/media/arrow_down.png" alt="Select base map" /></span>
			</button>
			<div id="basemapMenu">
			</div>
		</div>-->
	</div>  
</div>	
<div id="mapOpenLayersMap" class="openlayersMap"></div>
	 */
	
	/*this.getPreviewControlText = function(){
		var pcText = '<div class="previewControls">';
		pcText += '<div class="opacityControlCell">';
		pcText += '<div class="opacityControl">opacity: ';
		pcText += '<div class="controlText opacityText"><%= opacity %></div>';
		pcText += '<img src="' + this.getImage("arrow_down.png") + '" class="controlExpand button" />';
		pcText += '</div>';
		pcText += '<div class="controlContainer"><div class="opacitySlider" title="Adjust layer transparency">';
		pcText += '<img src="' + this.getImage("opacity_bg.png") + '" /></div></div>';
		pcText += '</div>';
    	return pcText;
	};
	this.previewControlHeader =_.template(this.getPreviewControlText());
		*/
		
		/*
		 * 	    var sOut = 
	    //read state
	    if (!org.OpenGeoPortal.layerState.layerStateDefined(layerID)){
	    	org.OpenGeoPortal.layerState.addNewLayer(layerID, {"dataType": dataType});
	    }

	    var opacityVal = org.OpenGeoPortal.layerState.getState(layerID, "opacity") + '%';

	    sOut += '<div class="opacityControlCell">';
	    sOut += '<div class="opacityControl">opacity: ';
	    sOut += '<div class="controlText opacityText" id="opacityText' +  tableID + layerID + '">' + opacityVal + '</div>';
	    sOut += '<img src="' + this.getImage("arrow_down.png") + '" class="controlExpand button" />';
	    sOut += '</div>';
	    sOut += '<div class="controlContainer"><div class="opacitySlider" title="Adjust layer transparency" id="opacity' +  tableID + layerID + '">';
	    sOut += '<img src="' + this.getImage("opacity_bg.png") + '" /></div></div>';
	    sOut += '</div>';
	    if ((dataType == "Raster")||(dataType == "Paper Map")||(dataType == "LibraryRecord")){
	    	sOut += '<div class="sizeControlCell">';
		    sOut += '</div>';
	    	sOut += '<div class="colorControlCell">';
		    sOut += '</div>';
	    	sOut += this.getZoomToLayerControl();
	    	sOut += '<div class="attributeInfoControl">';
		    sOut += '</div>';
	    } else {
	    	var sizeVal = org.OpenGeoPortal.layerState.getState(layerID, "graphicWidth") + 'px';
	    	
	    	sOut += '<div class="sizeControlCell">';
	    	sOut += '<div class="sizeControl" >';
	    	switch (dataType){
	    	case "Polygon":
	    		sOut += "border: ";
	    		break;
	    	case "Point":
	    		sOut += "pt size: ";
	    		break;
	    	case "Line":
	    		sOut += "ln width: ";
	    		break;
	    	}
	    	sOut += '<div class="controlText sizeText" id="sizeText' +  tableID + layerID + '">' + sizeVal + '</div>';
		    sOut += '<img src="' + this.getImage("arrow_down.png") + '" class="controlExpand button" />';
	    	sOut += '</div>';
		    sOut += '<div class="controlContainer"><div class="sizeSlider" title="Adjust size" id="size' +  tableID + layerID + '">';
		    sOut += '<img src="' + this.getImage("opacity_bg.png") + '" /></div></div>';
	    	sOut += '</div>';
	    	sOut += this.getColorControl(tableID, layerID, dataType);
	    	sOut += this.getZoomToLayerControl();
	    	sOut += this.getAttributeInfoControl(layerID);
	    }

	    sOut += '</div>';
	    return sOut;
		 */
};