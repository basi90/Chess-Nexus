import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="game-subscription"
export default class extends Controller {
  static values = { gameId: Number }
  static targets = [ "opponent" ]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "GameChannel", id: this.gameIdValue },
      { received: data => this.opponentTarget.textContent = `${data.username}`
                  
      }
    )
  }

  disconnect() {
    this.channel.unsubscribe()
  }
}
