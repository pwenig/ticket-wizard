google.maps.event.addDomListener(window, 'load', initialize);
function initialize() {
  var autocomplete = new google.maps.places.Autocomplete(document.getElementById("txtautocomplete"));
};