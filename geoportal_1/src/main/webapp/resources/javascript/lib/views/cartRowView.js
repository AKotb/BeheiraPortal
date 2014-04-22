if (typeof OpenGeoportal === 'undefined') {
	OpenGeoportal = {};
} else if (typeof OpenGeoportal !== "object") {
	throw new Error("OpenGeoportal already exists and is not an object");
}

if (typeof OpenGeoportal.Views === 'undefined') {
	OpenGeoportal.Views = {};
} else if (typeof OpenGeoportal.Views !== "object") {
	throw new Error("OpenGeoportal.Views already exists and is not an object");
}

OpenGeoportal.Views.CartRow = OpenGeoportal.Views.LayerRow.extend({

	events : {
		"click .viewMetadataControl" : "viewMetadata",
		"click .previewControl" : "togglePreview",
		"click .colExpand" : "toggleExpand",
		"click .colTitle" : "toggleExpand",
		"mouseover" : "doMouseoverOn",
		"mouseout" : "doMouseoverOff",
		"click .cartCheckBox" : "toggleCheck"

	},

	subClassInit: function(){
		this.listenTo(this.model, "change:isChecked", this.checkedView);
		this.listenTo(this.model, "change:actionAvailable", this.showActionAvailable);
	},

	toggleCheck: function(){
		this.model.set({isChecked : !this.model.get("isChecked")});
	},
	checkedView: function(){
		var isChecked = this.model.get("isChecked");

		this.$el.find("input.cartCheckBox").prop("checked", isChecked);		
	},

	
	showActionAvailable: function(){

		this.$el.removeClass("cartAction cartSelected");

		if (this.model.has("actionAvailable")){
			if (this.model.get("actionAvailable") === "yes"){
				this.$el.addClass("cartAction cartSelected");
			} else if (this.model.get("actionAvailable") === "no"){
				this.$el.addClass("cartAction");
			}
		}
	}
});
