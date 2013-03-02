$(function () {
//  Scrolling page aftee loading

  if(window.location.hash == '#brands') {
    $("body,html").animate({"scrollTop":470},"slow");
  }

  $('.viewallbrandslink').on('click', function(){
    if (window.location.pathname == '/products') {
      $("body,html").animate({"scrollTop":470},"slow");
    } else {
      window.location='/products#brands';
    }

  });
});
