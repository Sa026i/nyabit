import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bubble"
export default class extends Controller {
  connect() {
    // 必要ならフォーム送信など止めたいときだけ
    this.runAnimation()
  }
    // クリックでも動かしたい場合用（今までのやつ）
  animate(event) {
    if (event) event.preventDefault()
    this.runAnimation()
  }

  runAnimation() {
    // 一旦クラスを外して強制リフロー
    this.element.classList.remove("animate")
    void this.element.offsetWidth

    // 再度付与してアニメーション発火
    this.element.classList.add("animate")

    // タイマーを覚えておいて、次回のために一応クリア
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.classList.remove("animate")
    }, 700)
  }

  disconnect() {
    // 念のためクリーンアップ
    if (this.timeout) clearTimeout(this.timeout)
  }
}
