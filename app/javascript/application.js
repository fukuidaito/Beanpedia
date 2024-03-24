import "@hotwired/turbo-rails";
import $ from "jquery";
import "jquery-raty-js";

document.addEventListener("DOMContentLoaded", () => {
    $('#star').raty({
      path: '/assets/images', // Raty が使用する画像ファイルのパスを指定
      scoreName: 'board[star]'
    });
  });