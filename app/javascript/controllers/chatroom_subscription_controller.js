import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chatroom-subscription"
export default class extends Controller {
  static values = { chatroomId: Number, currentUserId: Number, currentUserPictureKey: String, opponentPictureKey: String}
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: (data) => this.#insertMessageAndScrollDown(data) }
    )
  }

  #insertMessageAndScrollDown(data) {
    const currentUserIsSender = this.currentUserIdValue === data.sender_id;
    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message, data.picture_key);

    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement);
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
  }

  #buildMessageElement(currentUserIsSender, message, pictureKey) {
    return `
      <div class="message-row d-flex ${this.#justifyClass(currentUserIsSender)}">
        ${this.#showOpponentProfilePicture(currentUserIsSender, pictureKey)}
        <div class="${this.#userStyleClass(currentUserIsSender)}">
        ${message}
        </div>
        ${this.#showCurrentUserProfilePicture(currentUserIsSender)}
      </div>
    `
  }

  #showCurrentUserProfilePicture(currentUserIsSender) {
    return currentUserIsSender ? `<img width="40" height="40" class="rounded-circle" alt="profile picture" src="http://res.cloudinary.com/dy3qbninr/image/upload/c_fill,h_40,w_40/v1/development/${this.currentUserPictureKeyValue}"></img>` : ""
  }

  #showOpponentProfilePicture(currentUserIsSender, pictureKey) {
    return currentUserIsSender ? "" : `<img width="40" height="40" class="rounded-circle" alt="profile picture" src="http://res.cloudinary.com/dy3qbninr/image/upload/c_fill,h_40,w_40/v1/development/${pictureKey}"></img>`
  }

  #justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  }

  #userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"
  }

  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    this.channel.unsubscribe()
  }
}
