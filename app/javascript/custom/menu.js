document.addEventListener("turbo:load", function() {
    let account = document.querySelector("#account");
    let menu = document.querySelector("#dropdown-menu");
    let hamburger = document.querySelector("#hamburger");
    let navbarMenu = document.querySelector("#navbar-menu");
  
    account.addEventListener("click", function(event) {
      event.preventDefault();
      menu.classList.toggle("active");
    });
  
    hamburger.addEventListener("click", function(event) {
      event.preventDefault();
      navbarMenu.classList.toggle("collapse");
    });
  
    document.addEventListener("click", function(event) {
      // アカウントメニュー以外がクリックされた場合、メニューを閉じる
      if (!account.contains(event.target) && !menu.contains(event.target)) {
        menu.classList.remove("active");
      }
  
      // ハンバーガーメニュー以外がクリックされた場合、メニューを閉じる
      if (!hamburger.contains(event.target) && !navbarMenu.contains(event.target) && navbarMenu.classList.contains("collapse")) {
        navbarMenu.classList.remove("collapse");
      }
    });
  });
  
