import "@hotwired/turbo-rails";
import jquery from "jquery";

window.$ = jquery;
import Raty from "./raty";  // Assuming raty.js is in the same directory

window.raty = function(elem,opt) {
  let raty =  new Raty(elem,opt)
  raty.init();
  return raty;
}