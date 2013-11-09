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

  function getParam(sParamName){
    var Params = location.search.substring(1).split("&");
    var variable = "";
    for (var i = 0; i < Params.length; i++){
      if (Params[i].split("=")[0] == sParamName){
        if (Params[i].split("=").length > 1) variable = Params[i].split("=")[1];
        return variable;
      }
    }
    return "";
  };

  console.log( getParam("filter") );



	// Submit form in every change:
	$('body').on('change', ".sortdropdown, input[type=checkbox]", function () {
		var prices = $('.price_bar input[type=checkbox]:checked');
		var prices_params = [];

		$.each(prices, function(){
			prices_params.push($(this).val());
		})

		$.ajax({
		  type: "GET",
		  url: '/products.js',
		  data: { price_between: prices_params }
		})






		// $('#form_sort').submit();
		// var value = $(this).val();
		// window.location.search = 'filter='+prices_params;
	});

});
