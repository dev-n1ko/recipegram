import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "content"]

  switch(event) {
    // console.log("event: ", event)

    const target = event.currentTarget.dataset.target
    // console.log("target: ", target)

    // タブの active 切り替え
    this.tabTargets.forEach(tab => {
      tab.classList.toggle("is-active", tab.dataset.target === target)
    })

    // コンテンツ切り替え
    this.contentTargets.forEach(content => {
      content.classList.toggle("is-hidden", content.id !== target)
    })
  }
}
