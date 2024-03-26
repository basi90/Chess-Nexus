import { Controller } from "@hotwired/stimulus"

let current_piece
let clicked_piece
let board_state
// Connects to data-controller="board-piece"
export default class extends Controller {
  static values = { gameId: Number }

  connect() {
  }

  selectPiece(event) {
    event.preventDefault();
    let square = event.currentTarget;
    let row = square.parentElement.dataset.row
    let col = square.dataset.col

    if (square.classList.contains("highlight-square")) {
      fetch(`/games/${this.gameIdValue}/select_move`, {
        method: 'POST',
        headers: { "Accept": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content},
        body: JSON.stringify({
          row: row,
          col: col
        })
      })
        .then(response => response.json())
        .then(data => { board_state = data });

      const rowDiv = document.querySelector(`[data-row='${row}']`)
      const colDiv = rowDiv.querySelector(`[data-col='${col}']`)
      colDiv.innerHTML = current_piece;
      clicked_piece.innerHTML = "";
      document.querySelectorAll(".highlight-square").forEach(square => {square.classList.remove("highlight-square")})

    } else {
      const rowDiv = document.querySelector(`[data-row='${row}']`)
      const colDiv = rowDiv.querySelector(`[data-col='${col}']`)
      current_piece = square.innerHTML
      clicked_piece = colDiv

      fetch(`/games/${this.gameIdValue}/select_piece`, {
        method: 'POST',
        headers: { "Accept": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content},
        body: JSON.stringify({
          row: row,
          col: col,
          board_state: board_state
        })
      })
        .then(response => response.json())
        .then(data => {
          Object.values(data).forEach(value => {
            Object.values(value).forEach(square => {
              const rowDiv = document.querySelector(`[data-row='${square.row}']`)
              const colDiv = rowDiv.querySelector(`[data-col='${square.col}']`)

              colDiv.classList.toggle("highlight-square");
            })
          })
        })
      }

    }

}
