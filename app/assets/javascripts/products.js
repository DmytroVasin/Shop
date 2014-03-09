$(function () {
	$('.video_slider').on('click', function(){
		$('.iframe_video_wrapper').stop(true).slideToggle('show');
		$(this).toggleClass('border_bottom');
	});


	// ZOOM paginator      --------------------------------------------------------------
  var main_image = $('.image_polaroid img');
  main_image.elevateZoom({gallery:'wrap_image_rotator', cursor: 'pointer', galleryActiveClass: 'active', imageCrossfade: true, loadingIcon: '/assets/progres.gif', zoomWindowPosition: 2, zoomWindowOffetx: 35 });

  main_image.bind("click", function(e) {
    var ez = main_image.data('elevateZoom');
    $.fancybox(ez.getGalleryList());
    return false;
  });
  // ZOOM paginator  END  --------------------------------------------------------------


  // ENDLESS paginator     -------------------------------------------------------------
	  $('body').on('click', '#ednless_paginator', function () {

	    url = $('.pagination .next_page').attr('href').replace("flag=true","flag=false");;
	    if (url) {
	      $.getScript(url);
	      $('.pagination ul').replaceWith('<div id="endless_message"></div>');
	    }
	  });
	// ENDLESS pagination END  -----------------------------------------------------------

	// Throttle method from underscore.js
	throttle = function(func, wait, options) {
    var context, args, result;
    var timeout = null;
    var previous = 0;
    options || (options = {});
    var later = function() {
      previous = options.leading === false ? 0 : new Date;
      timeout = null;
      // console.log('Hide loading');
      $('#items_bar').removeClass('hidden_loading');
      $('#hidden_loading').remove();
      result = func.apply(context, args);
    };
    return function() {
      var now = new Date;
      if (!previous && options.leading === false) previous = now;
      var remaining = wait - (now - previous);
      context = this;
      args = arguments;
      if (remaining <= 0) {
        clearTimeout(timeout);
        timeout = null;
        previous = now;
        result = func.apply(context, args);
      } else if (!timeout && options.trailing !== false) {
      	// console.log('Show loading');
      	$('#items_bar').addClass('hidden_loading').after("<div id='hidden_loading'></div>");
        timeout = setTimeout(later, remaining);
      }
      return result;
    };
  };

	// Submit form in every change:
	changeMeter = function () {
		var categories = $('.categories_bar input[type=checkbox]:checked');
		var brands     = $('.brand_bar input[type=checkbox]:checked');
		var gender     = $('.gender_bar input[type=checkbox]:checked');
		var color      = $('.color_bar input[type=checkbox]:checked');
		var select_val = $('.sortdropdown').val();

		function getValues(checkboxes) {
			return checkboxes.map(function (index, element) {
				return $(element).val();
			}).toArray();
		};

		function getPrice() {
			return Array($('#leftValue').val(), $('#rightValue').val());
		};

    $.ajax({
	    type: "GET",
	    url: '/products.js',
	    data: {
	      categories_params: getValues(categories),
	      brands_params: getValues(brands),
	      gender_params: getValues(gender),
	      color_params: getValues(color),
	      price_between: getPrice,
	      sort_direction: select_val,
	      flag: true
      }
	  })
	};
	$('body').on('change', ".sortdropdown, input:checkbox, #leftValue, #rightValue", throttle(changeMeter, 2000, {leading: false}));


	$('#images_color').on('change', function(){
		var selected_val = $('#images_color').val(),
				num;

		$('#slider a').each(function(index) {
			if ( selected_val == $(this).data('color') ) {
				num = $(this).index();

				for(var i = 1; i <= num; i++) {
					Navigate.leaf_over( 85 );
      	};
				return false;
			}
		});
	});
});
