$(function(){
  var widthOfOneStar       = 17,
      formUpdateScore      = $('#product_score'),
      votedStarsBackground = $('.raiting_votes'),
      hoverStarsBackground = $('.raiting_hover'),
      starsRaitingImgs     = $('.raiting'),
      starWidht,
      offsetOfStarsImgs,
      countOfFullStars;


  // display current count of stars:
  calculateCurrenCountOfStars(widthOfOneStar, votedStarsBackground);

  // Display hovered stars
  starsRaitingImgs.hover(function() {
    votedStarsBackground.hide();
    hoverStarsBackground.show();
  }, function() {
    votedStarsBackground.show();
    hoverStarsBackground.hide();
  });

  // Calculate hovered star width
  offsetOfStarsImgs = starsRaitingImgs.offset();
  starsRaitingImgs.mousemove(function(e){
    countOfFullStars = calculateCursorPosition(e, offsetOfStarsImgs, widthOfOneStar);
    hoverStarsBackground.width(countOfFullStars * widthOfOneStar);
  });


  // Check radio button and sent to controller selected value.
  starsRaitingImgs.on('click', function(e){
    countOfFullStars = calculateCursorPosition(e, offsetOfStarsImgs, widthOfOneStar);

    sentVote(countOfFullStars);
  });


  function calculateCurrenCountOfStars(starWidth, starsFields){
    var rankOfScore = $('.hidden_rank'),
        hiddenRank;

    hiddenRank = rankOfScore.html();
    starsFields.width(hiddenRank * starWidth);
  };

  function calculateCursorPosition(event, offset, oneStartWidth){
    var widhtVotes;

    widhtVotes = event.pageX - offset.left;
    if (widhtVotes === 0){
      widhtVotes = 1;
    }

    return Math.ceil(widhtVotes / oneStartWidth);
  };

  function sentVote(score){
    var productId = $('.stars_raiting').data('product-id');

    $.ajax({
      type: 'PUT',
      url: '/products/' + productId + '/vote',
      data: { score: score }
    });
  };
});
