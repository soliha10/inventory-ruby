import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static values = {interval: {type: Number, default: 8000}}
    connect() {
        this.timer = setInterval(() => this.save(), this.intervalValue )
    }
    disconnect() {
        clearInterval(this.timer)
    }
    markDirty() {
        this.dirty = true
    }
    reset() {
        this.dirty = false
    }
    clearFiles() {
        this.element.querySelectorAll("input[type=file]").forEach((input) => (input.value = ""))
    }
    save() {
        if (!this.dirty) return 
        this.dirty =false
        this.element.requestSubmit()
    }
}