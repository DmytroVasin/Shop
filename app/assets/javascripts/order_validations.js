$(function() {
  var condition
  var email = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  var phone = /^([0-9\(\)\/\+ \-]*)$/;
  var RegExp;

  $("#order_name, #order_surname, #order_city, #order_address").on('blur', function() {
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
    $("#order_name, #order_surname, #order_city, #order_address, #order_phone, #order_email").blur();

    if ( $('.errors_false').length !== 0 ) {
      $("body,html").animate({"scrollTop": 470}, "slow");
      return false;
    }
  });
});

function classChanger(condition){
  $(this)
      .parent()
      .toggleClass('errors_true', condition)
      .toggleClass('errors_false', !condition)
}