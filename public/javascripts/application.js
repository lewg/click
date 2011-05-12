// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



/**
* Helper functions for the UI 
*/
var ClickUI = new (function() {
	
	this.next_id = 0
	this.prev_id = 0
		
	// Goto the next image
	this.nextImg = function() {
		this.setImage(this.next_id);
	}
		
	// Goto to the previous image
	this.prevImg = function() {
		this.setImage(this.prev_id);
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
			ClickUI.next_id = data.next_id;
			$('#next_link').attr('href', '#'+data.next_id);
			ClickUI.prev_id = data.prev_id;
			$('#prev_link').attr('href', '#'+data.prev_id);
		})
	}
	
})


$(document).ready(function() {

	// Set the global list
	start_id = parseInt($.url().attr('anchor'));
	ClickUI.setImage(start_id);
	
	// Power left/right buttons
	$('#right_arrow').click(function(){
		window.location.hash = ClickUI.next_id;
		ClickUI.nextImg();
		return(false);
	});
	$('#left_arrow').click(function(){
		window.location.hash = ClickUI.prev_id;
		ClickUI.prevImg();
		return(false);
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