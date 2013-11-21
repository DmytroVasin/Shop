$(function () {
	$("#zooming").elevateZoom({ zoomWindowPosition: 2, zoomWindowOffetx: 35 });

	$('.video_slider').on('click', function(){
		$('.iframe_video_wrapper').stop(true).slideToggle('show');
		$(this).toggleClass('border_bottom');
	});

	$(".image_polaroid img").elevateZoom({gallery:'wrap_image_rotator', cursor: 'pointer', galleryActiveClass: 'active', imageCrossfade: true, loadingIcon: '/assets/progres.gif'});

	$(".image_polaroid img").bind("click", function(e) {
		var ez =   $('.image_polaroid img').data('elevateZoom');
		$.fancybox(ez.getGalleryList());
		return false;
	});


	// ENDLESS paginator     -------------------------------------------------------------
	  $('body').on('click', '#ednless_paginator', function () {

	    url = $('.pagination .next_page').attr('href').replace("flag=true","flag=false");;
	    if (url) {
	      $.getScript(url);
	      $('.pagination ul').replaceWith('<div id="endless_message"></div>');
	    }
	  });
	// ENDLESS pagination END  ----------------------------------------------------------

	// Throttle method from underscore.js
	throttle = function(func, wait, options) {
    var context, args, result;
    var timeout = null;
    var previous = 0;
    options || (options = {});
    console.log(options);
    var later = function() {
      previous = options.leading === false ? 0 : new Date;
      timeout = null;
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
	$('body').on('change', ".sortdropdown, input:checkbox, #leftValue, #rightValue", throttle(changeMeter, 3000, {leading: false}));
});
