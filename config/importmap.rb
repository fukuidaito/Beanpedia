pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true

pin "custom/menu", to: "menu.js", preload: true
pin "custom", to: "custom.js", preload: true
pin "bootstrap" # @5.3.3
pin "top", to: "top.js"
pin "stars", to: "stars.js"
pin "jquery" # @3.7.1
pin "raty", to: "raty.js", preload: true
pin "@rails/ujs", to: "@rails--ujs.js" # @7.1.3
pin "preview", to: "preview.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus-autocomplete"
