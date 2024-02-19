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