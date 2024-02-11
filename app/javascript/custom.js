document.addEventListener("DOMContentLoaded", function() {
    const blinkBefore = document.querySelector('.blackboard .blink-before');
  
    blinkBefore.addEventListener('mouseenter', function() {
      this.style.animation = 'moveArrow 1s infinite';
    });
  
    blinkBefore.addEventListener('mouseleave', function() {
      this.style.animation = '';
    });
  });

