$('.active_admin .logged_in').ready(function() {
  $('.site_title').append("<button class='mobile-nav'><i class='fa-toggler fa fa-bars'></i></button>");

  $('.mobile-nav').on('click', function () {
    var menu_items = $('#tabs');
    if (menu_items.css('display') =='none') {
      menu_items.css('display', 'flex');
      $('.fa-toggler').toggleClass('fa-bars fa-times');
    }
    else {
      menu_items.toggle();
      $('.fa-toggler').toggleClass('fa-times fa-bars');
    }
  });
});
