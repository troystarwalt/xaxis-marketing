$(document).ready(function(){
  $("a[href^='#'][class*='smooth-scroll']").on('click', function(event) {  //Collect the links
    if (this.hash !== "") { // Check to make sure it is a real anchor link
      event.preventDefault();  // If it is, then don't jump
      var hash = this.hash, // Quick variable
          scrollToPosition = $(hash).offset().top - 100; // Tell us where we want to go
      $('html, body').animate({
        scrollTop: scrollToPosition  // Animate to the posistion
      }, 800, function(){
        window.location.hash = hash;
        $('html').animate({ 'scrollTop': scrollToPosition}, 0); // Keep from bouncing back
      });
    }
  });
});
