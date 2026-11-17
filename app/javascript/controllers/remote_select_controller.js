import {Controller} from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {
  static values = { url: String, create: Boolean };
  connect() {
    this.select = new TomSelect(this.element, {
      create: this.createValue,
      persist: false,
      valueField: "value",
      labelField: "text",
      searchField: ["text"],
      load: (query, callback) => this.load(query, callback),
    });
  }
  disconnect() {
    this.select.destroy()
  }
  async load(query, callback){
    const response = await fetch(`${this.urlValue}?q=${encodeURIComponent(query)}`)
    callback(await response.json())
  }
}
