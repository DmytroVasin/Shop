$(function (){
// ------------------------------------------ Main menu

	$('#sdt_menu > li').bind('mouseenter',function(){
		var $elem = $(this);
		$elem.find('img')
		.stop(true)
		.animate({
			'width':'120px',
			'height':'40px',
			'left':'0px'
		},300,'easeOutBack')
		.andSelf()
		.find('.sdt_wrap')
		.stop(true)
		.animate({'top':'45px'},400,'easeOutBack')
		.andSelf()
		.find('.sdt_descr')
		.css('display', 'block')
		.andSelf()
		.find('.sdt_active')
		.stop(true)
		.animate({'height':'60px'},300,function(){
			var $sub_menu = $elem.find('.sdt_box');
			$sub_menu.slideDown(600);
		});
	}).bind('mouseleave',function(){
		var $elem = $(this);
		var $sub_menu = $elem.find('.sdt_box');
		if($sub_menu.length)
			$sub_menu.hide();
		$elem.find('.sdt_active')
		.stop(true)
		.animate({'height':'0px'},200)
		.andSelf().find('img')
		.stop(true)
		.animate({
			'width':'0px',
			'height':'0px',
			'left':'82px'},300)
		.andSelf()
		.find('.sdt_wrap')
		.stop(true)
		.animate({'top':'5px'},500)
		.find('.sdt_descr')
		.css('display', 'none');
	});

// ------------------------------------------ Tooltip

  $('.clickTip').aToolTip({
    clickIt: true,
    tipContent: 'Например: Christian Dior'
  });

// ------------------------------------------ Slider
	theRotator();

});


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