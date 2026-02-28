import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["window"]

  open() {
    this.windowTarget.classList.add("is-active")
    document.documentElement.classList.add("is-clipped")
  }

  close() {
    this.windowTarget.classList.remove("is-active")
    document.documentElement.classList.remove("is-clipped")
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