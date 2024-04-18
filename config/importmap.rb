pin "application", preload: true
pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @8.0.4

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
pin "@hotwired/turbo", to: "@hotwired--turbo.js" # @8.0.4
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @7.1.3
pin "@rails/activestorage", to: "@rails--activestorage.js" # @7.1.3
pin "@rails/actioncable", to: "@rails--actioncable.js" # @7.1.3
pin "all" # @0.0.0
