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
    siblings = $(this).parents('td').parents('tr').height('285px').siblings();
    $.each(siblings, function() {
      $(this).css('height','20px');
    });
  });

  $('.accept_color').on('click', function(){
    var acceptedColorArray = []
    selectedColors = $(this).parents('tr').find('.chosen-choices .search-choice');
    $.each(selectedColors, function(){
      acceptedColorArray.push($(this).find('span').text());
    });

    $.ajax({
      type: "POST",
      url: "/admin/colours/update_common_colour",
      data: { id: $(this).data('id'), acceptedColorArray: acceptedColorArray }
    })

  });
});
