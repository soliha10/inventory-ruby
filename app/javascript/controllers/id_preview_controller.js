import {Controller} from "@hotwired/stimulus"
export default class extends Controller {
    static targets = ["output"]
    static values = {url: String}
  connect(){
    this.refresh()
  }
  refresh(){
    clearTimeout(this.timer)
    this.timer=setTimeout(()=>this.load(), 300)
  }
      async load(){
        const body = new FormData(this.element.closest("form"))
        body.delete("_method")
        const headers = {"X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content}
        const response = await fetch(this.urlValue, {method: "POST", body, headers})
        this.outputTarget.textContent = await response.text()
    }
}