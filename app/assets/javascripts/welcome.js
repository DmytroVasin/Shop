$(function (){
// ------------------------------------------ Slider
	theRotator();

// ------------------------------------------ Top Product slider


var nextButton = $('.nextproduct'),
prevButton = $('.previousproduct'),
list = $('#slider');

Navigate = {
	isAnimated: false,
	
	forward: function () {
		var that = this;
		
		if (this.isAnimated) {
			return;
		}
		
		this.isAnimated = true;
		
		list
		.prepend( list.children().last() )
		.css({ left: '-=125' })
		.animate({ left: '+=125' }, 'fast', 'linear', function () {
			that.isAnimated = false;
		});
	},
	
	backward: function () {
		var that = this;
		
		if (this.isAnimated) {
			return;
		}
		
		this.isAnimated = true;
		
		list
		.animate({ left: '-=125' }, 'fast', 'linear', function () {
			list
			.append( list.children().first() )
			.css({ left: '+=125' });
			that.isAnimated = false;
		});
	}
};

nextButton.on('click', Navigate.forward.bind(Navigate));
prevButton.on('click', Navigate.backward.bind(Navigate));

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