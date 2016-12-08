// Check for page load and ready.
$(document).ready(function () {
  setMinHeight();
  // Check for window resize and set the minHeight
  $(window).resize(function () {
    setMinHeight();
  });
});

function setMinHeight() {
  var elements = document.getElementsByClassName('image-preview-101');
  var changeHeight = document.getElementsByClassName('single-101-container');

  var elementHeights = Array.prototype.map.call(elements,
    function(el) {
      return el.clientHeight;
    });
    console.log(elementHeights);

    var maxHeight = Math.max.apply(null, elementHeights)
    Array.prototype.forEach.call(changeHeight, function(el) {
      el.style.minHeight = (maxHeight + 30) + "px";
    });
    console.log("resized");
}
