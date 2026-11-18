import {Controller} from "@hotwired/stimulus"
export default class extends Controller {
    static targets = ["checkbox", "action" ]
    connect(){
    this.update()        
    }

    toggleAll(event) {
        this.checkBoxTargets.forEach((box) => (box.checked = event.target.checked))
        this.update()
    }
    update(){
        const nothingChecked = !this.checkboxTargets.some((box) => box.checked)
        this.actionTargets.forEach((button) => (button.disabled = nothingChecked))
    }
}