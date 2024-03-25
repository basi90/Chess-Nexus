import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="board-piece"
export default class extends Controller {
  connect() {
    console.log('hello');
  }

  movePiece(event) {
    event.preventDefault();
    let square = event.currentTarget;
    let row = square.dataset.row
    let column = square.parentElement.dataset.column
    let pieceId = square.dataset.pieceId

    console.log(event.currentTarget.innerHTML);
    console.log(event.currentTarget.parentElement);
    if (event.currentTarget.innerHTML != "") {
      event.currentTarget.classList.toggle("highlight-square");
    }
  }
}
