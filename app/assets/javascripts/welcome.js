$(function (){
// ------------------------------------------ Trick to preload image
	(new Image()).src = '/assets/progres.gif';
// ------------------------------------------ Trick to preload image

// ------------------------------------------ Slider
	// theRotator();
// ------------------------------------------ Top Product slider


	var nextButton = $('.nextproduct'),
	prevButton = $('.previousproduct'),
	nextImg = $('.next_img'),
	prevImg = $('.prev_img'),
	list = $('#slider');

	Navigate = {
		isAnimated: false,

		forwarding: function (size) {
			var that = this;

			if (this.isAnimated) {
				return;
			}

			this.isAnimated = true;

			list
			.prepend( list.children().last() )
			.css({ left: '-='+size })
			.animate({ left: '+='+size }, 'fast', 'linear', function () {
				that.isAnimated = false;
			});
		},

		backward: function (size) {
			var that = this;

			if (this.isAnimated) {
				return;
			}

			this.isAnimated = true;

			list
			.animate({ left: '-='+size }, 'fast', 'linear', function () {
				list
				.append( list.children().first() )
				.css({ left: '+='+size });
				that.isAnimated = false;
			});
		},

		leaf_over: function (size) {
			var that = this;
			list
			.animate({ left: '-='+size }, 100, 'linear', function () {
				list
				.append( list.children().first() )
				.css({ left: '+='+size });
			});
		}
	};

	nextButton.on('click', Navigate.forwarding.bind(Navigate, 125));
	prevButton.on('click', Navigate.backward.bind(Navigate, 125));
	nextImg.on('click', Navigate.forwarding.bind(Navigate, 85));
	prevImg.on('click', Navigate.backward.bind(Navigate, 85));




	var prevBigImg = $('.prevBigImg'),
			nextBigImg = $('.nextBigImg');

	BigRotator = {
		forwarding: function () {
			var current = $('div#rotator ul li.show');
			var prev = ((current.prev().length) ? current.prev() : $('div#rotator ul li:last'));
			prev.addClass('show').animate({opacity: 1.0}, 200);
			current.animate({opacity: 0.0}, 200).removeClass('show');
		},

		backward: function () {
			var current = $('div#rotator ul li.show');
			var next = ((current.next().length) ? current.next() : $('div#rotator ul li:first'));
			next.addClass('show').animate({opacity: 1.0}, 200);
			current.animate({opacity: 0.0}, 200).removeClass('show');
		}
	};

	nextBigImg.on('click', BigRotator.forwarding.bind(BigRotator));
	prevBigImg.on('click', BigRotator.backward.bind(BigRotator));

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
