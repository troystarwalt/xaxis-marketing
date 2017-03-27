$(document).ready(function(){
  // Using gon variable for bio modals
  $('.headshot-bio').on('click', function (e) {
    var index = $(this).data('index');
    var hsBio = gon.headshots[index];
    $('.hs-bio-img').attr({
      src: hsBio.grey_image.thumb.url,
      alt: hsBio.first_name + ' ' + hsBio.last_name
    });
    $('.hs-bio-img').data('photoid', hsBio.id);
    $('.hs-name').html(hsBio.first_name + " " + hsBio.last_name);
    $('.hs-title').html(hsBio.title);
    $('.hs-bio').html(hsBio.bio);
    $('#hsBioModal').modal('show');
    e.preventDefault();
  });
});
