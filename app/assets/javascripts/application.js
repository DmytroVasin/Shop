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
    var filter_object = App.getFilters(),
        filter_properties = [
          'categories',
          'gender',
          'color',
          'brand',
          'material',
          'feature',
          'zipper'
        ];

    for ( i = 0; i < filter_properties.length; i += 1 ) {
      $.each( filter_object[ filter_properties[i] + '_params'], function( index, value ) {
        $('.' + filter_properties[i] + "_bar [value='" + value + "']").prop('checked', true);
      });
    };

    $('#leftValue').val( filter_object['price_between'][0]);
    $('#rightValue').val( filter_object['price_between'][1]);

    $(".sortdropdown [value='"+filter_object['sort_direction']+"']").attr("selected", "selected");
  },

  defaultFilters: function(){
    return JSON.stringify({"categories_params":[],"brand_params":[],"gender_params":[],"color_params":[],"material_params":[],"zipper_params":[],"feature_params":[],"price_between":["0","4000"],"sort_direction":""});
  },

  getFilters: function(){
    if (localStorage.getItem('filters') === null) {
      localStorage.setItem('filters', this.defaultFilters() );
      localStorage.setItem('page_number', 1);
    };

    return JSON.parse(localStorage.getItem('filters'));
  },

  clearFilters: function(){
    localStorage.removeItem('filters');
    localStorage.removeItem('page_number');
  },

  addItemsToFilter: function(filtersHash){
    var filter_object = App.getFilters();

    $.each(filtersHash, function(key, value){
      valueArray = value.split(',');
      filter_object[key + '_params'] = valueArray;
    })

    localStorage.setItem('filters', JSON.stringify(filter_object));
  },

  showFiltersPopup: function(datas){
    var filterPopup = $('.filter_is_on');

    if ( datas == this.defaultFilters() ){
      filterPopup.hide();
    } else {
      filterPopup.show();
    }
  },

  getFilterFromAdLink: function(){
    return {"gender":"Mens,Unisex"}
  },

  adLinksRequired: function(){
    return {
      'ad_link_1': {"material":"leather"},
      'ad_link_2': {"color":"White"},
      'ad_link_3': {"categories":"Luggage"},
      'ad_link_4': {"color":"White,Multi"},
      'ad_link_5': {"categories":"Duffle Bags"},
      'ad_link_6': {"categories":"Laptop Bags"},
      'ad_link_7': {"categories":"Laptop Bags","feature":"laptop_sleeve"},
      'ad_link_8': {"gender":"Womens","material":"leather"},
      'ad_link_9': {"gender":"Mens,Unisex"},
      'ad_link_10': {"gender":"Womens,Unisex"},
      'ad_link_11': {"brand":"Nike"},
      'ad_link_12': {"brand":"GUESS"},
      'ad_link_13': {"brand":"Calvin Klein"},
      'ad_link_14': {"brand":"Dakine"},
      'ad_link_15': {"brand":"Adidas"},
      'ad_link_16': {"brand":"ALDO"},
      'ad_link_17': {"brand":"Betsey Johnson"},
      'ad_link_18': {"brand":"Big Buddha"},
      'ad_link_19': {"brand":"Diesel"},
      'ad_link_20': {"brand":"ECCO"},
      'ad_link_21': {"brand":"Fossil"},
      'ad_link_22': {"brand":"Herschel Supply Co"},
      'ad_link_23': {"brand":"Ivanka Trump"},
      'ad_link_24': {"brand":"JanSport"},
      'ad_link_25': {"brand":"Nine West"},
      'ad_link_26': {"categories":"Messenger Bags"},
      'ad_link_27': {"categories":"Messenger Bags","gender":"Womens,Unisex"},
      'ad_link_28': {"categories":"Messenger Bags","gender":"Mens,Unisex"},
      'ad_link_29': {"categories":"Messenger Bags","material":"leather"},
      'ad_link_30': {"categories":"Wallets & Accessories"},
      'ad_link_31': {"categories":"Wallets & Accessories","gender":"Womens,Unisex"},
      'ad_link_32': {"categories":"Wallets & Accessories","material":"leather"},
      'ad_link_33': {"categories":"Wallets & Accessories","gender":"Mens,Unisex"},
      'ad_link_34': {"brand":"PUMA"},
      'ad_link_35': {"categories":"Wallets & Accessories","gender":"Womens,Unisex","material":"leather"},
      'ad_link_36': {"categories":"Wallets & Accessories","zipper":"zipper"},
      'ad_link_37': {"categories":"Wallets & Accessories","gender":"Womens,Unisex","zipper":"zipper"}
    }
  }
};
