$('.all_hands, .brands').ready(function(){
  // Using gon variables for image modals
  $('.activate-modal').on('click', function (e){

    var index = $(this).data('index');
    $modalImage = $('.modal-image');  // Making this global for hiding it.
    var modalId = getId();
    var photo = getId() == 'eventPhotos' ? gon.photos[index] : gon.headshots[index]

    // var setAttr = $('.modal-image').attr;

    if ( modalId == 'eventPhotos') {  // For our event photos modals.
      $modalImage.attr({
          src: photo.image.medium.url,
          alt: photo.title
        });
      } else if ( modalId == 'hsModal') { // For our headshots modals.
      $modalImage.attr({
        src: photo.grey_image.large.url,
        alt: photo.first_name + ' ' + photo.last_name
        });
      }

    $modalImage.data('photoId', photo.id);
    $('#' + modalId).modal('show');
    e.preventDefault();
  });
  // Clearing out the image from the modal on hide/close
  $('#' + getId()).on('hidden.bs.modal', function(e){
    console.log($modalImage);
    $modalImage.attr('src', '');
  });

  function getId() {
    return modalId = $('.modal')[0].id
  };
});
