$(document).ready( function () {
  var sideMenu = $('#side-nav'),
  sideMenuHeight = sideMenu.outerHeight()+400;
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

function goToScroll(id) {
  id = id.replace("link", "");
  $('html, body').delay(2000).animate({
    scrollTop: $("#"+id).offset().top-170}, 'slow');
    console.log($("#"+id).offset().top);
}
