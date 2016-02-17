// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require lodash/dist/lodash.min.js
//= require gmaps/google
//= require material-design-lite/material.min.js
//= require javascript.fullPage.min.js
//= require javascript.fullPage.js
//= require gmaps/google
//= require exif-js/exif.js
//= require datetimepicker/build/jquery.datetimepicker.full.min.js
//= require typeahead.js/dist/typeahead.bundle.min.js
//= require typeahead.js/dist/bloodhound.min.js
//= require typeahead-addresspicker/dist/typeahead-addresspicker.min.js
//= require_tree .

$(function () {
	$('input[type="password"]').addClass('mdl-textfield__input')
	'mdl-button mdl-js-button mdl-button--raised'.split(' ').forEach(($class) => {
		$('button,input[type="submit"]').addClass($class);
	});
});

navigator.geolocation.watchPosition(function (position) {
	var latitude  = position.coords.latitude;
	var longitude = position.coords.longitude;
	
	window.latitude = latitude;
	window.longitude = longitude;

 	$.ajax({
        type: 'POST',
        url: `/users/geo`,
        data: { latitude: latitude, longitude: longitude, authenticity_token: $('meta[name="csrf-token"]').attr('content') }
  	});
}, function () {

}, { enableHighAccuracy: true });

$(function () {
	$('#event_time_at') && $('#event_time_at').datetimepicker()	
});