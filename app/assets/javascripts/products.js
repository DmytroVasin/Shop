$(function () {

// Sort menu - dropdown list
  $('.sortdropdown').on('change', function () {
//    window.location='/products?sort='+ this.value;
  });


// Sort Section PRICE list
  var countChecked = function() {
    $(this).parent().siblings().find('input[type=checkbox]:checked').prop('checked', false);
//    window.location='/products?price='+ this.value;
  };

  $( 'input[name=price_checkboxes]' ).on( "click", function(){
    countChecked.call(this);
  } );
});