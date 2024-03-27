import "@hotwired/turbo-rails";
import jquery from "jquery";
import Raty from "./raty";
window.$ = jquery;

document.addEventListener("DOMContentLoaded", () => {
  const ratyElement = document.getElementById('star');
  if (ratyElement) {
    const raty = new Raty(ratyElement, {
      path: '/assets/images',
      scoreName: 'board[star]'
    });
    raty.init();
  }
});
