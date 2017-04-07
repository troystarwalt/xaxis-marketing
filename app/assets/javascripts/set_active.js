var factLinkContainer = $('#facts-nav');
var factLinks = factLinkContainer.find('a');

$("div[data-page='onexaxis']").ready(function () {
  factLinks[0].className += " active-facts-link";
})

$('.facts-link').click(function () {
  var $this = $(this);
  factLinks.removeClass('active-facts-link');
  $this.addClass('active-facts-link');
})
