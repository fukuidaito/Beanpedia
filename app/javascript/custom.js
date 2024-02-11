document.addEventListener("DOMContentLoaded", function() {
    const startLink = document.getElementById('start-link');
    const continueLink = document.getElementById('continue-link');
    const startArrow = startLink.querySelector('.arrow');
    const continueArrow = continueLink.querySelector('.arrow');
  
    startLink.addEventListener('mouseenter', function() {
      startArrow.style.opacity = '1';
      continueArrow.style.opacity = '0';
    });
  
    continueLink.addEventListener('mouseenter', function() {
      startArrow.style.opacity = '0';
      continueArrow.style.opacity = '1';
    });
  
    startLink.addEventListener('mouseleave', function() {
      startArrow.style.opacity = '1';
    });
  
    continueLink.addEventListener('mouseleave', function() {
      continueArrow.style.opacity = '0';
    });
  });