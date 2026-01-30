import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "icon"]

  toggle() {
    console.log("hoge")
    const icon = this.iconTarget.querySelector("i")

    if (this.inputTarget.type === "password") {
      this.inputTarget.type = "text"
      icon.classList.remove("fa-eye")
      icon.classList.add("fa-eye-slash")} 
    else {
      this.inputTarget.type = "password"
      icon.classList.remove("fa-eye-slash")
      icon.classList.add("fa-eye")} 
  }
}
