$(function () {
  $('ul.faq li a').on('click', function () {
    $('strong').removeClass('red');
    var clicked_class_name = this.href.split("#")[1];
    $('html, body').animate({
      scrollTop: $("." + clicked_class_name).offset().top
    }, 'slow', 'linear');
    $('strong.' + clicked_class_name).addClass('red');
  });


  // Query the DOM
  var launchModalButton = $('#launch-modal'),
      modalBackground   = $('#modal-background'),
      modal             = $('#modal'),
      closeButton       = $('#close-modal');

  // Show Modal
  launchModalButton.on('click', function(){
    modalBackground.show();
    modal.show();
  })

  // Hide Modal
  closeButton.on('click', function(){
    modalBackground.hide();
    modal.hide();
    return false;
  })

});
