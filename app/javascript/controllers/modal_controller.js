import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["window"]

  open() {
    this.windowTarget.classList.add("is-active")
  }

  close() {
    this.windowTarget.classList.remove("is-active")
  }

  backgroundClose(event) {
    // 背景クリックのみ閉じる
    if (event.target.classList.contains("modal-background")) {
      this.close()
    }
  }

  escClose(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }
}