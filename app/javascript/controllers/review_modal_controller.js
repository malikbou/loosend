import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="review-modal"
export default class extends Controller {
  static targets = ["form", "rating"]
  connect() {
    // const button = document.getElementById('confirm')


    // const toggle = document.createAttribute('data-bs-toggle')
    // toggle.value = 'modal'
    // const target = document.createAttribute('data-bs-target')
    // target.value = '#exampleModal'

    // button.setAttributeNode(toggle)
    // button.setAttributeNode(target)
  }

  submit(e) {
    e.preventDefault()
    const url = this.element.action
    fetch(url, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.element)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.errors) {
          this.ratingTarget.innerText = data.message
        } else {
          let myModal = new Modal(document.getElementById('exampleModal'), {})
          myModal.show()
        }
      })
  }
}
