// Check for page load and ready.
$(document).on('ready page:change', function() {
  $('.one_oh_one_series').ready(function() {
    console.log("sucks")
    setMinHeight();
    // Check for window resize and set the minHeight
    $(window).resize(function () {
      setMinHeight();
    });
  });
});
function setMinHeight() {
  console.log("setting height");
  var elements = document.getElementsByClassName('image-preview-101');
  var changeHeight = document.getElementsByClassName('single-101-container');

  var elementHeights = Array.prototype.map.call(elements,
    function(el) {
      return el.clientHeight;
    });

    var maxHeight = Math.max.apply(null, elementHeights)
    Array.prototype.forEach.call(changeHeight, function(el) {
      if (maxHeight < 200) {
        el.style.minHeight = (maxHeight + 65) + "px";

      }
      else {
        el.style.minHeight = (maxHeight + 35) + "px";
      }
    });
  }
