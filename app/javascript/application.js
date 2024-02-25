  import "@hotwired/turbo-rails"

  document.addEventListener('DOMContentLoaded', function() {
    const map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: -33.8688, lng: 151.2195},
      zoom: 13,
    });
  
    const request = {
      location: map.getCenter(),
      radius: '500',
      type: ['cafe'],
      keyword: 'coffee'
    };
  
    const service = new google.maps.places.PlacesService(map);
    service.nearbySearch(request, (results, status) => {
      if (status === google.maps.places.PlacesServiceStatus.OK && results) {
        results.forEach((place) => {
          console.log(place.name);
          console.log(place.vicinity);
          if (place.photos) {
            console.log(place.photos[0].getUrl());
          }
        });
      }
    });
  });