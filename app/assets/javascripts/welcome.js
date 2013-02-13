$(function (){
// ------------------------------------------ Slider
	theRotator();

// ------------------------------------------ Top Product slider
	$('.nextproduct').on('click', function(){
		$(this).siblings("#wrap").find('li').each(function(){
			if (!$(this).is(':animated')) {
				currect_left = $(this).css('left');
				if (currect_left == '500px') {
					$(this).hide();
					$(this).animate({ left: '-125px' }, 500, function() {
					$(this).show();
					});
				}
				else {
					$(this).animate({ left: '+=125' }, 500 );
				}
			}
		});
	});
	$('.previousproduct').on('click', function(){
		$(this).siblings("#wrap").find('li').each(function(){
			if (!$(this).is(':animated')) {
				currect_left = $(this).css('left');
				if (currect_left == '-125px') {
					$(this).hide();
					$(this).animate({ left: '500px' }, 500, function() {
					$(this).show();
					});
				}
				else {
					$(this).animate({ left: '-=125' }, 500 );
				}
			}
		});
	});




});
// ------------------------------------------- additional functions
function theRotator() {
	$('div#rotator ul li').css({opacity: 0.0});
	$('div#rotator ul li.show').css({opacity: 1.0});
	setInterval('rotate()', 8000);
}

function rotate() {
	var current = $('div#rotator ul li.show');
	var next = ((current.next().length) ? current.next() : $('div#rotator ul li:first'));
	next.addClass('show').animate({opacity: 1.0}, 3000);
	current.animate({opacity: 0.0}, 3000).removeClass('show');
}