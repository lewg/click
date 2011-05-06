// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



/**
* Helper functions for the UI 
*/
var ClickUI = new (function() {
	
	var next_id = 0
	var prev_id = 0
	
	// Get the next image id
	this.nextImg = function() {
		this.setImage(next_id);
	}
	
	// Get the previous image id
	this.prevImg = function() {
		this.setImage(prev_id);
	}
	
	this.setImage = function(image_id) {
		if (isNaN(image_id)) {
			data_url = '/photos/first.json';
		} else {
			data_url = '/photos/'+image_id+'.json';
		}
		$.getJSON(data_url, function(data){
			// Set the Image URL and Description
			$('#image img').attr('src', data.url).attr('alt', data.description)
			// Set the caption
			$('#caption').html(data.title);
			// Set the info
			$('#image_info').html(data.info);
			// Set Next/Prev
			next_id = data.next_id;
			$('#next_link').attr('href', '#'+next_id);
			prev_id = data.prev_id;
			$('#prev_link').attr('href', '#'+prev_id);
		})
	}
	
})


$(document).ready(function() {

	// Set the global list
	start_id = parseInt($.url().attr('anchor'));
	ClickUI.setImage(start_id);
	
	// Power left/right buttons
	$('#right_arrow').click(function(){
		ClickUI.nextImg();
	});
	$('#left_arrow').click(function(){
		ClickUI.prevImg();
	});
	
	// Bind left/right arrows
	$(document).bind('keydown', function(e){
		switch (e.keyCode) {
			case 37:
				$('#left_arrow').click();
				break;
			case 39:
				$('#right_arrow').click();
				break;
	 	}
	})
	
})