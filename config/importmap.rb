pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true

pin "custom/menu", to: "menu.js", preload: true
pin "custom", to: "custom.js", preload: true

# BootstrapをCDNからピン留めする場合の例（BootstrapとPopperを含むバンドル版）
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js", preload: true
