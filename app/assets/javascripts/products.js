$(function () {

// Sort menu - dropdown list
  $('.sortdropdown').on('change', function () {
    $('#form_sort').submit();
  });


// Sort Section PRICE list
  var countChecked = function () {
    $(this).parent().parent().siblings().find('input[type=checkbox]:checked').prop('checked', false);

    $('#form_sort').submit();
  };

  $('input[name=price_between]').on("click", function () {
    countChecked.call(this);
  });

//  Sort Section PRODUCT TYPE list
  $('input[name=product_type]').on("click", function () {
    countChecked.call(this);
  });

// ENDLESS paginator     -------------------------------------------------------------
  $('#ednless_paginator').on('click', function () {

    url = $('.pagination .next_page').attr('href');
    if (url) {
      $.getScript(url);
      $('.pagination ul').replaceWith('<div id="endless_message"></div>');
    }
  });
// ENDLESS pagination ( remove adding link - if count of products == 6 )
  if (!($('div').hasClass('pagination'))) {
    $('#ednless_paginator').remove();
  }
// ENDLESS pagination END  ----------------------------------------------------------
});