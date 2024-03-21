import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quit-modal"
export default class extends Controller {
  static targets = ["button", "popup"]

  connect() {
  }

  toggleQuitMenu() {
    this.popupTarget.classList.toggle("d-none");
  }
}
