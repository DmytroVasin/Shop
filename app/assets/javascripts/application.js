// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require welcome
//= require products
//= require jquery.easing.1.3.js
//= require bootstrap-inputmask.js
//= require scrolling
//= require order_validations
//= require jquery.elevateZoom-3.0.3.min
//= require_self
//= require trackbar

$(function () {

// ------------------------------------------ Tooltip ( Ask Valera how to do blur and focus on tooltip ?)
// TODO: Fix this!
  var input_field = $('.clickTip');
  var hidden_tooltip = $('#aToolTip');
  input_field.focus(function () {
    hidden_tooltip.show();
  });
  input_field.blur(function () {
    hidden_tooltip.hide();
  });

// ------------------------------------------ Main menu
  $('#sdt_menu > li').bind('mouseenter',function () {
    var $elem = $(this);
    $elem.find('img')
        .stop(true)
        .animate({
          'width': '144px',
          'height': '40px',
          'left': '0px'
        }, 300, 'easeOutBack')
        .andSelf()
        .find('.sdt_wrap')
        .stop(true)
        .animate({'top': '45px'}, 400, 'easeOutBack')
        .andSelf()
        .find('.sdt_descr')
        .css('display', 'block')
        .andSelf()
        .find('.sdt_active')
        .stop(true)
        .animate({'height': '60px'}, 300, function () {
          var $sub_menu = $elem.find('.sdt_box');
          $sub_menu.slideDown(600);
        });
  }).bind('mouseleave', function () {
        var $elem = $(this);
        $elem.find('.sdt_active')
            .stop(true)
            .animate({'height': '0px'}, 200)
            .andSelf().find('img')
            .stop(true)
            .animate({
              'width': '0px',
              'height': '0px',
              'left': '82px'}, 300)
            .andSelf()
            .find('.sdt_wrap')
            .stop(true)
            .animate({'top': '0px'}, 500)
            .find('.sdt_descr')
            .css('display', 'none');
      });
});