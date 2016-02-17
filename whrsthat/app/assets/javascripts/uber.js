// var userLatitude
//     , userLongitude
//   , partyLatitude = 40.7283405
//   , partyLongitude = -73.994567;

// navigator.geolocation.watchPosition(function(position) {
//     // Update latitude and longitude
//     userLatitude = position.coords.latitude;
//     userLongitude = position.coords.longitude;

//   // Query Uber API if needed
//     getEstimatesForUserLocation(userLatitude, userLongitude);
// });

function getEstimatesForUserLocation() {
  $(".uber-list").empty().show()
  $.ajax({
    url: `/uber/${$event.id}/estimates/price`,
    method: 'post',
    data: {
      'authenticity_token': $('meta[name="csrf-token"]').attr('content')
    },
    success: function(results) {
      results = results.map((result) => {
        return $(`
          <li class="mdl-list__item" data-product-id="${result.product_id}">
            <span class="mdl-list__item-primary-content">
            <i class="material-icons mdl-list__item-icon">driver</i>
            <span class="display_name">${result.display_name}</span>
            <span class="price">${result.high_estimate}</span>
          </span>
          </li>
        `);
      }).forEach((li) => $('ul.uber-list').append(li));

    }
  });
}