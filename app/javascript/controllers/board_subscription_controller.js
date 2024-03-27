import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="board-subscription"
export default class extends Controller {
  static values = { boardId: Number }
  static targets = [ "board" ]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "BoardChannel", id: this.boardIdValue },
      { received: data => this.boardTarget.innerHTML = data }
    )
  }

  disconnect() {
    this.channel.unsubscribe()
  }
}
