import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert-dialog"
export default class extends Controller {
  static targets = ["overlay", "content"]

  connect() {
    // Listen for custom show event
    this.element.addEventListener("alert-dialog:show", this.show.bind(this))
    
    // Focus trap elements
    this.focusableElements = 'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
  }

  disconnect() {
    this.element.removeEventListener("alert-dialog:show", this.show.bind(this))
  }

  show(event) {
    if (event) event.preventDefault()
    
    this.element.classList.remove("hidden")
    document.body.style.overflow = "hidden"
    
    // Focus first focusable element
    this.focusFirstElement()
    
    // Dispatch shown event
    this.dispatch("shown")
  }

  close(event) {
    if (event) event.preventDefault()
    
    this.element.classList.add("hidden")
    document.body.style.overflow = ""
    
    // Dispatch closed event
    this.dispatch("closed")
  }

  closeOnOverlay(event) {
    // Only close if clicking on the overlay itself, not the content
    if (event.target === this.overlayTarget) {
      this.close(event)
    }
  }

  closeOnEscape(event) {
    if (event.key === "Escape" && !this.element.classList.contains("hidden")) {
      this.close(event)
    }
  }

  focusFirstElement() {
    const focusableContent = this.contentTarget.querySelectorAll(this.focusableElements)
    if (focusableContent.length > 0) {
      focusableContent[0].focus()
    }
  }

  // Focus trap - keep focus within dialog
  trapFocus(event) {
    if (this.element.classList.contains("hidden")) return

    const focusableContent = this.contentTarget.querySelectorAll(this.focusableElements)
    const firstElement = focusableContent[0]
    const lastElement = focusableContent[focusableContent.length - 1]

    if (event.key === "Tab") {
      if (event.shiftKey) {
        if (document.activeElement === firstElement) {
          lastElement.focus()
          event.preventDefault()
        }
      } else {
        if (document.activeElement === lastElement) {
          firstElement.focus()
          event.preventDefault()
        }
      }
    }
  }
}