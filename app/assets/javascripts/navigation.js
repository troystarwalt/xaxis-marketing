$(document).ready( function () {
  var sideMenu = $('#side-nav'),
  sideMenuHeight = sideMenu.outerHeight()+400
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
    cur = cur[cur.length-1]
    var id = cur && cur.length ? cur[0].id: "";
    menuItems.parent().removeClass('active-side-link').end().filter("[href='#"+id+"']").parent().addClass("active-side-link");
  });
});
