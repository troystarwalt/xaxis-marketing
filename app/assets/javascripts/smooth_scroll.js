$(document).ready(function(){
  $("a[href^='#'][class*='smooth-scroll']").on('click', function(event) {
    if (this.hash !== "") {
      event.preventDefault();
      var hash = this.hash;
      $('html, body').animate({
        scrollTop: $(hash).offset().top - 165
      }, 800, function(){
        window.location.hash = hash;
      });
    }
  });
});
