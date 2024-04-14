import { Application } from "@hotwired/stimulus"
import Autocomplete from "./autocomplete_controller"

const application = Application.start()
application.register("autocomplete", Autocomplete)