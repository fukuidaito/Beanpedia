document.addEventListener("turbo:load", function() {
    let account = document.querySelector("#account");
    let menu = document.querySelector("#dropdown-menu");
  
    // アカウントボタンがクリックされたときにメニューをトグルする
    account.addEventListener("click", function(event) {
      event.preventDefault();
      menu.classList.toggle("active");
    });
  
    // ドキュメント全体のクリックを監視
    document.addEventListener("click", function(event) {
      // クリックされた要素がアカウントボタンでなく、
      // メニューの子要素でもない場合、メニューを非表示にする
      if (!account.contains(event.target) && !menu.contains(event.target)) {
        menu.classList.remove("active");
      }
    });
  });
  