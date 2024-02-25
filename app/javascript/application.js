document.addEventListener("DOMContentLoaded", function() {
    const startArrow = document.querySelector('#start-link .arrow');
    const continueArrow = document.querySelector('#continue-link .arrow');
  
    document.getElementById('start-link').addEventListener('mouseenter', function() {
      startArrow.style.opacity = '1';
      continueArrow.style.opacity = '0';
    });
  
    document.getElementById('continue-link').addEventListener('mouseenter', function() {
      continueArrow.style.opacity = '1';
      startArrow.style.opacity = '0';
    });
  
    // マウスがどちらのリンクからも離れた場合、デフォルト状態（STARTにのみ▶が表示される）に戻す
    document.querySelector('.blackboard.answer').addEventListener('mouseleave', function() {
      startArrow.style.opacity = '1';
      continueArrow.style.opacity = '0';
    });
  });
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