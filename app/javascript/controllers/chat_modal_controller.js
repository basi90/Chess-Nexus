import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat-modal"
export default class extends Controller {
  static targets = ["button", "popup"]

  connect() {
  }

  openChat() {
    this.popupTarget.classList.toggle("d-none");
  }
}
