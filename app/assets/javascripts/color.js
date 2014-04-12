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

  function getSelected(root) {
    return root.find('.chosen-choices .search-choice span').map(function () {
      return $(this).text();
    }).toArray();
  }

  $('.accept_color').on('click', function () {
     var tr = $(this).closest('tr');
     var acceptedColorArray = getSelected( tr.find('td.color') );

    $.ajax({
      type: "POST",
      url: "/admin/colours/update_common_colour",
      data: { id: $(this).data('id'), acceptedColorArray: acceptedColorArray }
    });
  });

  $('#accept_features').on('click', function () {
     var currentField = $('#features_category');
     var acceptedMaterialArray = getSelected( currentField.find('.material') );
     var acceptedZipperArray   = getSelected( currentField.find('.zipper') );
     var acceptedFeatureArray  = getSelected( currentField.find('.feature') );

    $.ajax({
      type: "POST",
      url: "/admin/products/update_features",
      data: { id: $(this).data('id'), acceptedMaterialArray: acceptedMaterialArray, acceptedZipperArray: acceptedZipperArray, acceptedFeatureArray: acceptedFeatureArray }
    });
  });
});
