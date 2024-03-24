star.addEventListener('click', () => {
    const rating = star.dataset.rating;
    const boardId = star.dataset.boardId;
    fetch(`/boards/${boardId}/rate?rating=${rating}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': Rails.csrfToken()
      }
    })
    .then(response => {
      if (response.ok) {
        stars.forEach((s, i) => {
          if (i <= index) {
            s.classList.add('gold');
          } else {
            s.classList.remove('gold');
          }
        });
        // レビューが正常に保存された場合の処理
      } else {
        // エラーが発生した場合の処理
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
  });
