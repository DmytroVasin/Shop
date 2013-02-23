$(function () {

  $('.sortdropdown').on('change', function () {
    window.location='/products?sort='+ this.value;
  });

});