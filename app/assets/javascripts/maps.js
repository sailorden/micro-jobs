$("#map").ready(function() {

  var map = L.mapbox.map('map', 'louishoang.jn2haba8').setView([42.366, -71.109], 13);

  // Set marker with JSON
  var data = $.parseJSON($.ajax({
    url:  '/users.json',
    dataType: "json",
    async: false
  }).responseText);

  var featureLayer = L.mapbox.featureLayer(data).addTo(map);

  // // Set marker without JSON
  // L.marker([37.9, -77], {
  //   icon: L.mapbox.marker.icon({
  //       'marker-size': 'medium',
  //       'marker-symbol': 'rocket',
  //       'marker-color': '#fa0'
  //   })
  // }).addTo(map);

  featureLayer.eachLayer(function(data) {
    var marker;
    var properties;
    var popupContent;

    marker = data;
    properties = marker.feature.properties;
      if (properties.role === "User") {
        popupContent = '<div class="popup">' + '<p>' + properties.name + '</p>' + '</div>';
      }

    marker.bindPopup(popupContent, {
      closeButton: false,
      minWidth: 100,
      maxWidth: 200,
      maxHeight: 200,
    });
  })


});
