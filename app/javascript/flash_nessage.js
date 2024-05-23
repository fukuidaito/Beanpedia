  document.addEventListener("turbo:load", () => {
    setTimeout(() => {
      const flashMessages = document.getElementById('flash-messages');
      if (flashMessages) {
        flashMessages.style.display = 'none';
      }
    }, 3000);
  });
