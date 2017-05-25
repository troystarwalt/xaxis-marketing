$(document).ready(function(){
  $('.headshot-container_image').hover(function() {
    var image_height = $(this).find('img').height();
    $(this).find('div').css({opacity: 0, display: 'flex', height: image_height}).animate({ opacity: 1}, 250);},
    function() {
    $(this).find('div').fadeOut(250);
  });
});
