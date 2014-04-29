$(function () {
  var faqListItem = $('ul.faq li a');
  faqListItem.on('click', function () {
    $('strong').removeClass('red');
    var clickedClassName = this.href.split("#")[1];
    $('html, body').animate({
      scrollTop: $("." + clickedClassName).offset().top
    }, 'slow', 'linear');
    $('strong.' + clickedClassName).addClass('red');
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
