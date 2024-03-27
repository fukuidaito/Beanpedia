import "@hotwired/turbo-rails";
import jquery from "jquery"
window.$ = jquery
import "jquery-raty";

document.addEventListener("DOMContentLoaded", () => {
  $('#star').raty({
    path: '/assets/images',
    scoreName: 'board[star]'
  });
});