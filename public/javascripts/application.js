// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



/**
* Helper functions for the UI 
*/
var ClickUI = new (function() {

	var id_list = []
	var current_photo = null;
	
	// Set the List of Image IDs, return the first one
	this.setList = function(new_ids) {
		current_photo = new_ids.shift()
		id_list = new_ids
		this.setImage(current_photo)
		return current_photo
	}
	
	// Get the next image id
	this.nextImg = function() {
		id_list.push(current_photo)
		current_photo = id_list.shift()
		this.setImage(current_photo)
		return(current_photo)
	}
	
	// Get the previous image id
	this.prevImg = function() {
		id_list.unshift(current_photo)
		current_photo = id_list.pop()
		this.setImage(current_photo)
		return(current_photo)
	}
	
	this.setImage = function(image_id) {
		$.getJSON('/photos/'+image_id+'.json', function(data){
			// Set the Image URL
			$('#main_image img').attr('src', data.url);
			// Set the caption
			$('#caption').html(data.title)
			// Set the info
			$('#image_info').html(data.info)
		})
	}
	
})


$(document).ready(function() {
	
	$.getJSON('/photos.json', function(data){
		// Set the global list
		ClickUI.setList(data.id_list);
	})
	
	// Power left/right buttons
	$('#right_arrow').click(function(){
		ClickUI.nextImg()
	});
	$('#left_arrow').click(function(){
		ClickUI.prevImg()
	});
	
	// Bind left/right arrows
	$(document).bind('keydown', function(e){
		switch (e.keyCode) {
			case 37:
				ClickUI.prevImg();
				break;
			case 39:
				ClickUI.nextImg();
				break;
	 	}
	})
	
})