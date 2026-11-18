import {Controller} from "@hotwired/stimulus"
import {Turbo} from "@hotwired/turbo-rails"

export default class extends Controller {
    static values = {url: String  }
    
    open(event) {
        if(event.target.closest("input, a, label")) return 
        Turbo.visit(this.urlValue)
    }
}