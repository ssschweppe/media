import { Controller } from "@hotwired/stimulus"

// Форма подписки: кнопка отправки активна, только когда введена почта и отмечено согласие
export default class extends Controller {
  static targets = [ "email", "consent", "submit" ]
  static values = { sent: Boolean }

  connect() {
    this.toggle()
  }

  toggle() {
    const ready = this.consentTarget.checked && this.emailTarget.value !== "" && this.emailTarget.validity.valid
    this.submitTarget.disabled = this.sentValue || !ready
  }
}
