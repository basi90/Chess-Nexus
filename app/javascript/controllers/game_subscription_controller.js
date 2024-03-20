import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="game-subscription"
export default class extends Controller {
  static values = { gameId: Number }
  static targets = [ "opponent" ]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "GameChannel", id: this.gameIdValue },
      // { received: data => console.log(`${data} has joined the game`) },
      { received: data => this.opponentTarget.textContent = `${data}` }
    )
    // console.log(`Subscribe to the game with the id ${this.gameIdValue}.`)
  }

  disconnect() {
    console.log("Unsubscribed from the game")
    this.channel.unsubscribe()
  }
}
