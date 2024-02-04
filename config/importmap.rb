# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/custom",      under: "custom"
pin "custom/menu", to: "menu.js", preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true
pin "popper", to: 'popper.js', preload: true
