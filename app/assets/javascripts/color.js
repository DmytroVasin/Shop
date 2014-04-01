//= require chosen.jquery.min
//= require prism

$(function() {
  var config = {
    '.chosen-select': {}
  }

  for (var selector in config) {
    $(selector).chosen(config[selector]);
  }

  $('.chosen-container').on('click', function(){
    siblings = $(this).parents('td').parents('tr').height('200px').siblings();
    $.each(siblings, function() {
      $(this).css('height','20px');
    });
  });
});
