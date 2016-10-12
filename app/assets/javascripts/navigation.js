// Doesn't work yet.

$(document).ready( function () {
  var sideMenu = $('#side-nav'),
  sideMenuHeight = sideMenu.outerHeight()+400
  menuItems = sideMenu.find("a"),
  scrollItems = menuItems.map(function () {
    var item = $($(this).attr("href"));
    if (item.length) { return item;}
  });
  console.log(menuItems);
  $(window).scroll(function(){
    console.log(sideMenuHeight + this);
    var fromTop = $(this).scrollTop()+sideMenuHeight;
    console.log(fromTop);
    var cur = scrollItems.map(function(){
      if ($(this).offset().top<fromTop)
      return this;
    });
    cur = cur[cur.length-1]
    var id = cur && cur.length ? cur[0].id: "";
    menuItems.parent().removeClass('active-side-link').end().filter("[href='#"+id+"']").parent().addClass("active-side-link");
  });
});
