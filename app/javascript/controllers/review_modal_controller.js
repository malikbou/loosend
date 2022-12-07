import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="review-modal"
export default class extends Controller {
  connect() {
    const button = document.getElementById('confirm')

    const toggle = document.createAttribute('data-bs-toggle')
    toggle.value = 'modal'
    const target = document.createAttribute('data-bs-target')
    target.value = '#exampleModal'

    button.setAttributeNode(toggle)
    button.setAttributeNode(target)
  }
}
