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
//= require spin
//= require voters
//= require init_spin

$(function () {
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

var App = {
  applyFilters: function(){
    var filter_object = App.getFilters();

    $.each( filter_object['categories_params'], function( index, value ) {
      $(".categories_bar [value='" + value + "']").prop('checked', true);
    });

    $.each( filter_object['gender_params'], function( index, value ) {
      $(".gender_bar [value='" + value + "']").prop('checked', true);
    });

    $.each( filter_object['color_params'], function( index, value ) {
      $(".color_bar [value='" + value + "']").prop('checked', true);
    });

    $.each( filter_object['brands_params'], function( index, value ) {
      $(".brand_bar [value='" + value + "']").prop('checked', true);
    });

    $.each( filter_object['material_params'], function( index, value ) {
      $(".material_bar [value='" + value + "']").prop('checked', true);
    });

    $.each( filter_object['feature_params'], function( index, value ) {
      $(".feature_bar [value='" + value + "']").prop('checked', true);
    });

    $.each( filter_object['zipper_params'], function( index, value ) {
      $(".zipper_bar [value='" + value + "']").prop('checked', true);
    });

    $('#leftValue').val( filter_object['price_between'][0]);
    $('#rightValue').val( filter_object['price_between'][1]);

    $(".sortdropdown [value='"+filter_object['sort_direction']+"']").attr("selected", "selected");
  },

  getFilters: function(){
    if (localStorage.getItem('filters') === null) {
      localStorage.setItem('filters', JSON.stringify({"categories_params":[],"brands_params":[],"gender_params":[],"color_params":[],"material_params":[],"zipper_params":[],"feature_params":[],"price_between":["0","4000"],"sort_direction":""}) );
      localStorage.setItem('page_number', 1);
    };

    return JSON.parse(localStorage.getItem('filters'));
  },

  clearFilters: function(){
    localStorage.removeItem('filters');
    localStorage.removeItem('page_number');
  },

  addItemToFilter: function(category, itemName){
    var filter_object = App.getFilters();
    filter_object[category + '_params'].push(itemName);

    localStorage.setItem('filters', JSON.stringify(filter_object));
  }

};
