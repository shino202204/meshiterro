Rails.application.routes.draw do
    # get 'post_images/new'
    # get 'post_images/index'
    # get 'post_images/show'
    # 上記をresourcesの記述に変更
    # resourcesメソッド：ルーティングを一括して自動生成してくれる機能
    # onlyオプション：生成するルーティングを限定することができる
    # この場合、onlyの後に配列で記述されている"new","index","show"のアクション以外は、
    # ルーティングが行われない。
    resources :post_images, only: [:new, :create, :index, :show]

    # deviseのモデルを作成したことで、ルーティングが自動的に追加されている。
    # devise_for :usersは、deviseを使用する際にURLとしてusersを含むことを示している。
    devise_for :users

    root to: "homes#top"

    get 'homes/about' ,as: 'about'
end
