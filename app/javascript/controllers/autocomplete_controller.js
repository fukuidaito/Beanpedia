import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    console.log("Autocomplete Controller connected");
  }

  search() {
    fetch(`${this.data.get("url-value")}?query=${this.inputTarget.value}`)
      .then(response => response.json())
      .then(data => this.displayResults(data))
      .catch(error => console.error("Error fetching data: ", error));
  }

  displayResults(data) {
    this.resultsTarget.innerHTML = '';
    data.forEach(item => {
      const li = document.createElement('li');
      li.textContent = item.name; // あるいは適切な属性に変更
      this.resultsTarget.appendChild(li);
    });
  }
}