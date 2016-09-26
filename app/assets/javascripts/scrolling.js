// Doesn't work yet.

$(document).ready( function () {
  var sideMenu = $('#side-nav'),
  sideMenuHeight = sideMenu.outerHeight()+15
  console.log(sideMenuHeight)
  menuItems = sideMenu.find("a"),
  console.log(menuItems)
  scrollItems = menuItems.map(function () {
    var item = $($(this).attr("href"));
    if (item.length) { return item;}
  });
  console.log(scrollItems)
  $(window).scroll(function(){

    var fromTop = $(this).scrollTop()+sideMenuHeight;

    var cur = scrollItems.map(function(){
      if ($(this).offset().top<fromTop)
      return this;
    });
    cur = cur[cur.length-1]
    var id = cur && cur.length ? cur[0].id: "";

    menuItems
    .parent().removeClass('active')
    .end().filter("[href='#"+id+"']").parent().addClass("active");
  });
})
