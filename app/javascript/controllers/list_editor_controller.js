import {Controller} from "@hotwired/stimulus";
import Sortable from "sortablejs"
export default class extends Controller {
    static targets = ["list", "template", "kind"]
    connect(){
        Sortable.create(this.listTarget, {
            handle: ".drag-handle",
            animation: 150,
            revertOnSpill: true,
            onSpill: (event) => this.remove(event.item),
            onEnd: () => this.changed()
        })
    }
    add() {
        const template = this.templateTargets.find((item) => item.dataset.kind === this.kindTarget.value)
        this.listTarget.insertAdjacentHTML("beforeend", template.innerHTML.replaceAll("NEW_RECORD", Date.now()) )
        this.renumber()
    }
    remove(row) {
        row.querySelector("[name$='[_destroy]']").value=1
        row.hidden=true
        this.changed()
    }
    renumber(){
        this.listTarget.querySelectorAll("[name$='[position]']").forEach((input, index) => (input.value=index))
    }
    changed() {
        this.renumber()
        this.element.dispatchEvent(new Event("input", {bubbles: true}))
    }
    
}