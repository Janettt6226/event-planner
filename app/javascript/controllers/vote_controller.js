import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vote"
export default class Vote extends Controller {
  static targets = ["vote"];
  static values = { plusone: Number };
  connect() {
  }

  upvote(event) {
    event.preventDefault();
    this.plusoneValue += 1;
    this.voteTarget.innerText = this.plusoneValue;
  }
}
