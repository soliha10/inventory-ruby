import { Controller } from "@hotwired/stimulus";
import {Popover, Tooltip} from "bootstrap"

export default class extends Controller {
    static values = {type: {type: String, default : "tooltip"}}
  connect() {
    const Widget = this.typeValue === "popover" ? Popover : Tooltip
    this.widget = new Widget(this.element, {html: true , trigger: "hover focus",})
  }
  disconnect() {
    this.widget.dispose()
  }
}