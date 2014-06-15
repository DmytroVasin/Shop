$(function () {

  // ZOOM paginator      --------------------------------------------------------------
  var main_image = $('.image_polaroid img');
  main_image.elevateZoom({ gallery:'wrap_image_rotator',
    cursor: 'pointer',
    galleryActiveClass: 'active',
    imageCrossfade: true,
    loadingIcon: '/assets/progres.gif',
    scrollZoom : true,
    zoomWindowPosition: 2,
    zoomWindowOffetx: 35 });

  main_image.bind("click", function(e) {
    var ez = main_image.data('elevateZoom');
    $.fancybox(ez.getGalleryList());
    return false;
  });
  // ZOOM paginator  END  --------------------------------------------------------------


  // ENDLESS paginator     -------------------------------------------------------------
  var itemsFolder = $('#items_bar');
  itemsFolder.on('click', '.disabled, .active', function() {
    return false;
  });

  itemsFolder.on('click', '.pagination ul li:not(.disabled , .active)', function() {
    var spiner = $('#items_bar #spinner_loading, #items_bar #spinner_loading_background');
    spiner.show();
  });

  // ENDLESS pagination END  -----------------------------------------------------------

  // Throttle method from underscore.js
  throttle = function(func, wait, options) {
    var spin = $('#items_bar #spinner_loading, #items_bar #spinner_loading_background');
    var context, args, result;
    var timeout = null;
    var previous = 0;
    options || (options = {});
    var later = function() {
      previous = options.leading === false ? 0 : new Date;
      timeout = null;
      result = func.apply(context, args);
    };
    return function() {
      spin.show();
      var now = new Date;
      if (!previous && options.leading === false) previous = now;
      var remaining = wait - (now - previous);
      context = this;
      args = arguments;
      if (remaining <= 0) {
        clearTimeout(timeout);
        timeout = null;
        previous = now;
        result = func.apply(context, args);
      } else if (!timeout && options.trailing !== false) {
        timeout = setTimeout(later, remaining);
      }
      return result;
    };
  };

  // Submit form in every change:
  changeMeter = function () {
    var categories = $('.categories_bar input[type=checkbox]:checked');
    var brands     = $('.brand_bar input[type=checkbox]:checked');
    var gender     = $('.gender_bar input[type=checkbox]:checked');
    var color      = $('.color_bar input[type=checkbox]:checked');

    var material   = $('.material_bar input[type=checkbox]:checked');
    var zipper     = $('.zipper_bar input[type=checkbox]:checked');
    var feature    = $('.feature_bar input[type=checkbox]:checked');

    var select_val = $('.sortdropdown').val();

    function getValues(checkboxes) {
      return checkboxes.map(function (index, element) {
        return $(element).val();
      }).toArray();
    };

    datas = {
      categories_params: getValues(categories),
      brand_params: getValues(brands),
      gender_params: getValues(gender),
      color_params: getValues(color),

      material_params: getValues(material),
      zipper_params: getValues(zipper),
      feature_params: getValues(feature),

      price_between: Array($('#leftValue').val(), $('#rightValue').val()),
      sort_direction: select_val,
    }


    if ( JSON.stringify(datas) != localStorage.getItem('filters') ){
      localStorage.setItem('filters', JSON.stringify(datas));
      localStorage.setItem('page_number', 1);
    } else {
      datas.page = localStorage.getItem('page_number');
    }


    $.ajax({
      type: "GET",
      url: '/products/product_search.js',
      data: datas
    });
  };

  function startSlider(value){
    var num;

    $('#slider a').each(function(index) {
      if ( value == $(this).data('color') ) {
        num = $(this).index();
        $(this).click();

        for(var i = 1; i <= num; i++) {
          Navigate.leaf_over( 85 );
        };
        return false;
      }
    });
  }

  var colors_under_picture     = $('.color_select #line_item_color'),
      colors_under_description = $('.main_color_select #line_item_color_description');

  colors_under_picture.on('change', function(){
    var selected_val = $(this).val();
    colors_under_description.val(selected_val);

    startSlider(selected_val);
  });

  colors_under_description.on('change', function(){
    var mainColorSelectTag = $(this).val();
    colors_under_picture.val(mainColorSelectTag);

    startSlider(mainColorSelectTag);
  });

  // Change small colour:
  $('body').on('click', '.color_field', function () {
    var itemId, color, that, specialColorBlock, currentProduct;

    that   = $(this);
    specialColorBlock = that.parent('.special_colors');
    itemId = specialColorBlock.data('item-id');
    color  = that.attr('class').split('color_field ')[1];
    currentProduct = specialColorBlock.siblings('.productlinkimg').find('.productimg')

    $.ajax({
      type: 'GET',
      dataType: 'json',
      url: '/products/color_picker',
      data: {
        id: itemId,
        color: color
      },
      success: function(data) {
        currentProduct.attr('src', data.imgUrl);
      }
    });

  });

  $('body').on('change', ".sortdropdown, input:checkbox, #leftValue, #rightValue", throttle(changeMeter, 2000, {leading: false}));
  $('.custom-find').on('click', throttle(changeMeter, 1000, {leading: false}));

  // Accordion
  var sectionHeader = $('.section h3');
  sectionHeader.on('click', function(){
    var element,
        that = $(this),
        currentSection = that.siblings('ul'),
        countOfCheckedElements = currentSection.find('input:checkbox:checked').length;


    if ( currentSection.length === 0 ){
      element = $('.trackbar');
    } else if ( countOfCheckedElements === 0 ){
      element = currentSection;
    }

    element.stop().slideToggle('1000');
  });


  // Reset button ---------------------------------------------------------
  var resetButton   = $('.custom-reset'),
      findButton    = $('.custom-find').first(),
      allCheckboxes = $('.section input:checkbox'),
      sortDropdown  = $('#sort_by');

  resetButton.on('click', function(){
    allCheckboxes.each(function(){
      $(this).prop('checked', false);
    });

    sortDropdown.prop('selectedIndex',0);

    $('#leftValue').val('0');
    $('#rightValue').val('4000');

    App.clearFilters();
    App.getFilters();

    findButton.click();
  });

  itemsFolder.on('click', '#no_match_criteria span', function(){
    resetButton.first().click();
  });

  // Reset button ---------------------------------------------------------

  // Pick brand from image ------------------------------------------------

  var rightAdBlock = $('#remote_site, #rotator');

  rightAdBlock.find('[data-item-name]').on('click', function(){
    var filterName   = $(this).data('item-name'),
        categoryName = $(this).data('category-name');

    App.clearFilters();
    App.addItemToFilter(categoryName, filterName );

    window.location='/products';
    return false;
  });

  // Pick brand from image ------------------------------------------------

});
