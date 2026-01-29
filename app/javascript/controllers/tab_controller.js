import { Controller } from "@hotwired/stimulus"

export default class Tabchenge extends Controller {
  static targets = ["panel", "content"]

  switch(event) {
    console.log("event: ", event)
    
    const target = event.currentTarget.dataset.target
    console.log("target: ", target)
    console.log("target: ", event.currentTarget)

    // タブの active 切り替え
    this.panelTargets.forEach(panel => {
      panel.classList.toggle("is-active", panel.dataset.target === target)
    })

    // コンテンツ切り替え
    this.contentTargets.forEach(content => {
      content.classList.toggle("is-hidden", content.id !== target)
    })
  }
}
