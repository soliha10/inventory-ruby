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
        const response = await fetch(this.urlValue, {method: "POST", body})
        this.outputTarget.textContent = await response.text()
    }
}