$('#assets-color-palette').ready(function() {
  var top_box = $('.color-card-top');
  $('.color-hex').each(function(i, obj) {
    $(this).parent().siblings(top_box).css('background-color', $(this).text());
  });

  $('.color-card-title').each(function(i, obj) {
    var _this = $(this)
    if (_this.text().length >16 ){
      _this.addClass('way-too-long');
    }    else if (_this.text().length >= 13) {
      _this.addClass('too-long');
    }
  })
});
