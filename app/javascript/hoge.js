console.log('Hoge');

window.onload = function() {
  console.log("ページ読み込み完了")
}

document.addEventListener('turbo:load', () => {
  console.log("turbo読み取り完了後");
})