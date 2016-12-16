$('.active_admin .logged_in').ready(function() {
  $('.site_title').append("<button class='mobile-nav'>X</button>");

  $('.mobile-nav').on('click', function () {
    var menu_items = $('#tabs');
    if (menu_items.css('display') =='none') {
      menu_items.css('display', 'flex');
    }
    else {
      menu_items.toggle();
    }
  });
});
