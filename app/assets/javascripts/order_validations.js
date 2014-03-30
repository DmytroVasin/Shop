$(function() {
  var condition
  var email = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  var phone = /^([0-9\(\)\/\+ \-]*)$/;
  var RegExp;

  $("#order_name, #order_surname, #order_city").on('blur', function() {
    condition = $(this).val().length > 2;
    classChanger.call(this, condition);
  });

  $("#order_email, #order_phone").on('blur', function() {
    if ( $(this).data('value') == 'phone' ) {
      RegExp = phone;
    } else {
      RegExp = email;
    }

    condition = RegExp.test(this.value);
    classChanger.call(this, condition);
  });

  $('#new_order').on('submit', function() {
    $("#order_name, #order_surname, #order_city, #order_phone, #order_email").blur();

    if ( $('.errors_false').length !== 0 ) {
      $("body,html").animate({"scrollTop": 470}, "slow");
      return false;
    }
  });

  $('#order_payment_method').on('change', function(){
    if (this.value === '0.1'){
      changePriceToPay(0.1, 0.9, 0.9);
    } else {
      changePriceToPay(0, 1, 0.3);
    }
  });

});
function changePriceToPay(persentOfDiscount, multipleValOfDiscount, prepayPricePersent ){
  var price_with_discount, price_to_prepay, ordered_price;

  ordered_price       = parseFloat( $('.common_price').text().replace(/\,/g, '') );
  price_with_discount = (ordered_price * multipleValOfDiscount).toFixed(2);
  price_to_prepay     = (ordered_price * prepayPricePersent).toFixed(2);
  final_price         =

  $('.common_price_discount').text(persentOfDiscount*100 + '%')
  $('.common_price_with_discount').text(price_with_discount + ' грн.');
  $('.common_price_with_prepay').text(price_to_prepay + ' грн.')
  $('.common_price_final').text(price_with_discount - price_to_prepay + ' грн.');
}

function classChanger(condition){
  $(this)
      .parent()
      .toggleClass('errors_true', condition)
      .toggleClass('errors_false', !condition)
}
