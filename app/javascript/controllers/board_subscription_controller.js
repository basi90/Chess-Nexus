import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="board-subscription"
export default class extends Controller {
  static values = { boardId: Number, currentUserId: Number, whiteUserId: Number, blackUserId: Number }
  static targets = [ "board" ]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "BoardChannel", id: this.boardIdValue },
      { received: (data) => {
        if (this.currentUserIdValue === this.whiteUserIdValue) {
          this.boardTarget.innerHTML = data.board_white
        } else if (this.currentUserIdValue === this.blackUserIdValue) {
          this.boardTarget.innerHTML = data.board_black
        }
        }
      }
    )
  }

  disconnect() {
    this.channel.unsubscribe()
  }
}
