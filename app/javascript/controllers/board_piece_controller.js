import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="board-piece"
export default class extends Controller {
  connect() {
    console.log('hello');
  }

  movePiece(event) {
    console.log(event.currentTarget.innerHTML);
    console.log(event.currentTarget.parentElement);
    if (event.currentTarget.innerHTML != "") {
      event.currentTarget.classList.toggle("highlight-square");
    }
  }
}
