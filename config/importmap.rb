pin "@hotwired/turbo-rails", to: "https://cdn.skypack.dev/@hotwired/turbo@7.0.1/dist/turbo.min.js", preload: true

pin "custom/menu", to: "menu.js", preload: true
pin "custom", to: "custom.js", preload: true

pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js", preload: true

# application.js は通常のエントリポイントなので、特別な指定は不要ですが、プリロードを有効にします
pin "application", preload: true