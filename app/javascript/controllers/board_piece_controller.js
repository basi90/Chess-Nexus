import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="board-piece"
export default class extends Controller {
  static values = { gameId: Number }

  connect() {
    console.log('hello');
    console.log(this.gameIdValue);

  }

  movePiece(event) {
    event.preventDefault();
    let square = event.currentTarget;
    let row = square.parentElement.dataset.row
    let column = square.dataset.column

    if (event.currentTarget.innerHTML != "") {
      event.currentTarget.classList.toggle("highlight-square");
    }

    console.log(JSON.stringify({
      row: row,
      column: column
    }))

    fetch(`/games/${this.gameIdValue}/update_board`, {
      method: 'POST',
      headers: { "Accept": "application/json" },
      body: JSON.stringify({
        row: row,
        column: column
      })
    })
      .then(response => response.json())
      .then(data => {
        console.log(data);;
      });
  }
}
