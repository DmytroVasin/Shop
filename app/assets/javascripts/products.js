$(function () {

  $('.sortdropdown').on('change', function () {
    window.location='/products?sort='+ this.value;
  });


  var countChecked = function() {
    $(this).parent().siblings().find('input[type=checkbox]:checked').removeAttr('checked');
    window.location='/products?price='+ this.value;
  };

  $( 'input[name=price_checkboxes]' ).on( "click", countChecked );

});