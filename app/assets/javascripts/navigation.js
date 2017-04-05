// Side menu highlighting
$('#brands').ready( function () {
  var sideMenu = $('#side-nav'),                   // Capture the nav
      sideMenuHeight = sideMenu.outerHeight()-170, // Get the height of the sideMenu
      menuItems = sideMenu.find("a"),              // Grab each anchor in the sideMenu
      scrollItems = menuItems.map(function () {    // Go through the anchors and return the href value.
        var item = $($(this).attr("href"));
        if (item.length) {
          console.log(item);
          return item;
        }           // If there is a length (a value), then return it.
      });
  $(window).scroll(function(){
    var fromTop = $(this).scrollTop()+sideMenuHeight;  // Find out how far we are from the top
    var cur = scrollItems.map(function(){              // If window is scrolled to a specfici href, then return it.
      if ($(this).offset().top<fromTop)
      return this;
    });
    cur = cur[cur.length-1];
    var id = cur && cur.length ? cur[0].id: "";        // Get the ID of the target DIV from the ScrollItem
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

$('#brands').ready(function() {
  // Only running this if on platforms.
  function goToScroll(id) {
    id = id.replace("link", "");
    // used to be 375, 700 with the smaller cards
    $('html, body').animate({
      scrollTop: $("#"+id).offset().top-170}, 'fast');
  }

  // This function handles the side nav movement.
  $(function() {
    $.fn.scrollBottom = function() {
      return $(document).height() - this.scrollTop() - this.height();
    };

    var $el = $('#side-nav');
    var $window = $(window);
    var top = $el.parent().position().top;
    var top_of_side_nav = $el.offset();
    var footer = $('footer');
    var footerHeight = footer.height();

    $window.bind("scroll resize", function() {
      var gap = $window.height() - top_of_side_nav.top - footerHeight;
      var visibleFoot = 360 - $window.scrollBottom();
      var scrollTop = $window.scrollTop()
      if (scrollTop < top_of_side_nav.top - 90) {
        $el.css({
          top: "255px",
          bottom: "auto"
        });
      } else if (visibleFoot > gap) {
        $el.css({
          top: "auto",
          bottom: "360px"
        });
      } else {
        $el.css({
          top: 190,
          bottom: "auto"
        });
      }
    }).scroll();
  });



  function checkOffset() {
    // A lot of code to keep a back-to-top arrow from moving past the footer
    var backToTopArrow = document.querySelector('#btw-arrow-link');
    var footer = document.querySelector('footer');
    var main_body = document.querySelector('#brands');
    var footer_container = document.querySelector('.footer-container');
    function getRectTop(el){
      var rect = el.getBoundingClientRect();
      return rect.top;
    }


    if((getRectTop(backToTopArrow) + document.body.scrollTop) + backToTopArrow.offsetHeight >= (getRectTop(footer) + document.body.scrollTop) - 200) {
      var getStyle = window.getComputedStyle;
      var margin_top_footer = getStyle(footer_container).marginTop;
      var footer_height = getStyle(footer).height;
      var container_height = getStyle(main_body).height;
      backToTopArrow.style.position = 'absolute';

      // backToTopArrow.style.bottom = ((parseInt(footer_height) - parseInt(margin_top_footer) - 140) - parseInt(container_height)) + "px";
      backToTopArrow.style.bottom = ((parseInt(footer_height) - 539)) + "px";
      }
    if(document.body.scrollTop + window.innerHeight < (getRectTop(footer) + document.body.scrollTop)) {
      backToTopArrow.style.position = 'fixed'; // restore when you scroll up
      backToTopArrow.style.bottom = '10%';
      }
  }

  document.addEventListener("scroll", function(){
    checkOffset();
  });
});
