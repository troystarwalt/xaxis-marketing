$(document).ready(function(){
  var kkeys = [], fishyText = [70,73,83,72,89]; //this spells dinner
  $(window).on("keydown", function(e){
    kkeys.push( e.keyCode );
    if ( kkeys.toString() == fishyText.toString()) {
      kkeys = [];
      swimFishySwim();
    }
  });
});

function swimFishySwim(){
  $('body').append("<img src='/assets/goldfish.png' class='fish-image' />")
  $('.fish-image').animate({
        left: "100vw"
      }, 5000, function(){
        $('.fish-image').remove();
  });
}
