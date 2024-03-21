import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-friends"
export default class extends Controller {
  static targets = ["form", "input", "list"]

  connect() {
  }

  update() {
    console.log(this.inputTarget.value);
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    console.log(url);
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        this.listTarget.innerHTML = data
        console.log(data);
      })
  }
}
