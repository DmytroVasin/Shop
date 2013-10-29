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


// // ENDLESS paginator     -------------------------------------------------------------
//   $('#ednless_paginator').on('click', function () {

//     url = $('.pagination .next_page').attr('href');
//     if (url) {
//       $.getScript(url);
//       $('.pagination ul').replaceWith('<div id="endless_message"></div>');
//     }
//   });
// // ENDLESS pagination ( remove adding link - if count of products == 6 )
//   if (!($('div').hasClass('pagination'))) {
//     $('#ednless_paginator').remove();
//   }
// // ENDLESS pagination END  ----------------------------------------------------------
});