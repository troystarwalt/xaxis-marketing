// Side menu highlighting
$('#brands').ready( function () {
  var sideMenu = $('#side-nav'),
  sideMenuHeight = sideMenu.outerHeight()+100;
  menuItems = sideMenu.find("a"),
  scrollItems = menuItems.map(function () {
    var item = $($(this).attr("href"));
    if (item.length) { return item;}
  });
  $(window).scroll(function(){
    var fromTop = $(this).scrollTop()+sideMenuHeight;
    var cur = scrollItems.map(function(){
      if ($(this).offset().top<fromTop)
      return this;
    });
    cur = cur[cur.length-1];
    var id = cur && cur.length ? cur[0].id: "";
    menuItems.parent().removeClass('active-side-link').end().filter("[href='#"+id+"']").parent().addClass("active-side-link");
  });
});

// Only run this function if we are on platforms. This helps with the side menu nav.
$('.platforms').ready(function() {
  if (window.location.href.indexOf("platforms/") > -1) {
    $(window).scroll(function(){
      $("#side-nav").css("top",Math.max(375,1175-$(this).scrollTop()));
    });
  }
  if (document.referrer.includes("platforms") && window.scrollY === 0) {
    goToScroll('learn-more');
  }
});

// used to be 375, 700 with the smaller cards
$('#brands').ready(function() {

  function goToScroll(id) {
    id = id.replace("link", "");
    $('html, body').animate({
      scrollTop: $("#"+id).offset().top-170}, 'fast');
    }
    $(function() {
      $.fn.scrollBottom = function() {
        return $(document).height() - this.scrollTop() - this.height();
      };

      var $el = $('#side-nav');
      var $window = $(window);
      var top = $el.parent().position().top;

      $window.bind("scroll resize", function() {
        var gap = $window.height() - $el.height() - 180;
        var visibleFoot = 360 - $window.scrollBottom();
        var scrollTop = $window.scrollTop()

        if (scrollTop < top - 30) {
          $el.css({
            top: (top - scrollTop) + "px",
            bottom: "auto"
          });
        } else if (visibleFoot > gap) {
          $el.css({
            top: "auto",
            bottom: visibleFoot + "px"
          });
        } else {
          $el.css({
            top: 190,
            bottom: "auto"
          });
        }
      }).scroll();
    });
  });
