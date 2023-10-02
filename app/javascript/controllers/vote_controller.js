import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vote"
export default class extends Controller {
  static targets = ["vote"];
  connect() {
    console.log("coucou");
  }

  upvote(event) {
    event.prevent.default();
    console.log(this.voteTarget);

  }
}
