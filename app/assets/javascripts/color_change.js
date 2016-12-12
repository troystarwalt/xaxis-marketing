$('.color-card-top').on('click', function () {
  var background_color = $(this).css('background-color');
  var white = "#FFF"
  $('.color-change-content').css('background-color', background_color);
  $('#color_change').css('display', 'block');
  countDown();
})

function countDown() {
  var timer = setInterval(function() {
    var count = parseInt($('.color-counter').html());
    if (count !==0) {
      $('.color-counter').html(count -1);
    }
    else {
      clearInterval(timer);
      clearColor();
      $('.color-counter').text(4);
    }
  }, 1000);
}

function clearColor() {
  $('#color_change').css('display', 'none');
};

$('.color-close').on('click', function() {
  $('#color_change').css('display', 'none');
});
