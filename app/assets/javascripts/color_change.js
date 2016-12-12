$('.color-card-top').on('click', function () {
  var background_color = $(this).css('background-color');
  const $og_bg_c = $('#assets-color-palette').css('background-color');
  console.log("clicked card");
  $('#assets-color-palette').css('background-color', background_color);
  delayColor($og_bg_c);
})

function delayColor(cv) {
    window.setTimeout(function(){
      $('#assets-color-palette').css('background-color', cv);},
      2000);
};
