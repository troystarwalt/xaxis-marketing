$(document).ready(function(){
  $('.platform-preview-image').hover(function() {
    $(this).find('div').css({opacity: 0, display: 'flex'}).animate({ opacity: 1}, 500);},
    function() {
    $(this).find('div').fadeOut(500);
  });

});
