import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  // turbo:submit-end イベントが飛んできたら呼ばれる
  closeOnSuccess(event) {
    if (event.detail.success) {
      // this.element は data-controller="modal" が付いている要素（= <dialog>）になる
      if (this.element.open) {
        this.element.close()
      }
    }
  }
}
//習慣登録ボタン押下後に自動でモーダルを閉じる！