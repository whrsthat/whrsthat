'use strict';

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
    done: () => {
      $('body').css({ cursor: '' })
    },
    success: function(results) {

      results = results
      .filter((result) => result.low_estimate || result.high_estimate)
      .map((result) => {
        return $(`
          <li class="mdl-list__item uber-price" data-product-id="${result.product_id}">
            <i class="material-icons mdl-list__item-icon">driver</i>
            <span class="mdl-list__item-primary-content">
              <span class="display_name">${result.display_name}</span>
              <span class="price">$${result.high_estimate||result.low_estimate}</span>
            </span>
            <span class="mdl-list__item-secondary-action">
               <label class="demo-list-radio mdl-radio mdl-js-radio mdl-js-ripple-effect" for="option-1">
                  <input type="radio" id="option-1" class="mdl-radio__button uber-radio" name="options" value="1" checked />
                </label>
            </span>
          </li>
        `);
      }).forEach((li) => $('ul.uber-list').append(li));

    }
  });
}

$(() => {
  $('.uber-dialog .close').click(() => {
    $('.uber-dialog')[0].close();
  })

  $('.uber-dialog .uber-radio').click(function () {
    if ($(this).is(':checked')) {

    }
  });

  $('.uber-dialog .order').click(() => {
    let product_id = $('.uber-dialog .uber-radio:checked').parents('li').attr('data-product-id');
    $.ajax({
      url: '/uber/requests',
      method: 'post',
      data: {
        'authenticity_token': $('meta[name="csrf-token"]').attr('content'),
        event_id: $event.id,
        product_id: product_id
      }
    }).done(() => {
      $('.uber-dialog')[0].close();
    })
  });
});