$(document).ready(function(){
  // Using gon variables for image modals
  $('.single-event-photo').on('click', function (e){
    var index = $(this).data('index');
    var photo = gon.photos[index];

    $('.event-photos').attr({
      src: photo.image.medium.url,
      alt: photo.title
      });
    $('.event-photos').data('photoId', photo.id);
    $('#eventPhotos').modal('show');
    e.preventDefault();
  });
  // Clearing out the image from the modal on hide/close
  $('#eventPhotos').on('hidden.bs.modal', function(e){
    $('.event-photos').attr('src', '');
  });
});

var elem = document.querySelector('.photo-grid');

var msnry;

imagesLoaded( elem, function() {
  console.log("images loaded")
  msnry = new Masonry( elem, {
    itemSelector: '.photo-grid-item',
    columnWidth: '.photo-grid-sizer',
  });
});
