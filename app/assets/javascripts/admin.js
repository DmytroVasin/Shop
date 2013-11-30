//= require jquery
//= require jquery_ujs
//= require_self

$(function() {
  $('.disabled').click(function( e ) {
    e.preventDefault();
  });

  $('.row').on("click", '#table th a, #perfume_table #paginator .pagination a', function() {
    $.getScript(this.href);
    return false;
  });

  var search_elem = $('#products_search');
  search_elem.on('keyup', 'input', function() {
    $.get(search_elem.attr("action"), search_elem.serialize(), null, "script");
    return false;
  });

  $(document).on('click', '#best_sellers', function(){
    that = $(this);
    $.ajax({
      type: "POST",
      url: "/admin/products/best_sell",
      data: { product_id: that.data('product-id'), checked: that.prop("checked") }
    }).done(function() {
      // Hack - to reload table for displaying checkboxes.
      page = $('.active a').text();
      window.location.search ='?page=' + page;
    });
  });
});
