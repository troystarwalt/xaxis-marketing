$(document).ready(function(){
  // Using gon variables for image modals
  $('.headshot-overlay-link, .headshot-image').on('click', function (e){
    var index = $(this).data('index');
    var headshot = gon.headshots[index];

    $('.hs-img').attr({
      src: headshot.grey_image.large.url,
      alt: headshot.first_name,
      photo_id: headshot.id
      });
    $('#hsModal').modal('show');
    e.preventDefault();
  });
  // Clearing out the image from the modal on hide/close
  $('#hsModal').on('hide.bs.modal', function(e){
    $('.hs-img').attr('src', '');
  });

  // Using gon variable for bio modals
  $('.headshot-bio').on('click', function (e) {
    var index = $(this).data('index');
    var hsBio = gon.headshots[index];
    $('.hs-bio-img').attr({
      src: hsBio.grey_image.thumb.url,
      alt: hsBio.full_name,
      photo_id: hsBio.id
    });
    $('.hs-name').html(hsBio.first_name + " " + hsBio.last_name);
    $('.hs-title').html(hsBio.title);
    $('.hs-bio').html(hsBio.bio);
    $('#hsBioModal').modal('show');
    e.preventDefault();
  });
});
