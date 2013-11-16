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
	    console.log('.....');
	    console.log(url);
	    console.log('.....');
	    if (url) {
	      $.getScript(url);
	      $('.pagination ul').replaceWith('<div id="endless_message"></div>');
	    }
	  });
	// ENDLESS pagination END  ----------------------------------------------------------




	// // Sort menu - dropdown list
	// $('.sortdropdown').on('change', function () {
	// 	$('#form_sort').submit();
	// });

	// // Sort Section PRICE list
	// var countChecked = function () {
	// 	$(this).parent().parent().siblings().find('input[type=checkbox]:checked').prop('checked', false);

	// 	$('#form_sort').submit();
	// };

	// $('input[name=price_between]').on("click", function () {
	// 	countChecked.call(this);
	// });

	// Submit form in every change:
	$('body').on('change', ".sortdropdown, input:checkbox", function () {
		var categories = $('.categories_bar input[type=checkbox]:checked');
		var brands     = $('.brand_bar input[type=checkbox]:checked');
		var gender     = $('.gender_bar input[type=checkbox]:checked');
		var color      = $('.color_bar input[type=checkbox]:checked');
		var prices     = $('.price_bar input[type=checkbox]:checked');

		function getValues(checkboxes) {
			return checkboxes.map(function (index, element) {
				return $(element).val();
			}).toArray();
		};

		$.ajax({
			type: "GET",
			url: '/products.js',
			data: {
				categories_params: getValues(categories),
				brands_params: getValues(brands),
				gender_params: getValues(gender),
				color_params: getValues(color),
				price_between: getValues(prices),
				flag: true
			}
		});
	});

});
