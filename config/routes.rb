Rails.application.routes.draw do
  # deviseのモデルを作成したことで、ルーティングが自動的に追加されている。
  # devise_for :usersは、deviseを使用する際にURLとしてusersを含むことを示している。
  devise_for :users

  root to: "homes#top"

  get 'homes/about' ,as: 'about'

  # get 'users/show'
  # get 'users/edit'
  # get 'post_images/new'
  # get 'post_images/index'
  # get 'post_images/show'

  # 上記をresourcesの記述に変更
  # resourcesメソッド：ルーティングを一括して自動生成してくれる機能
  # onlyオプション：生成するルーティングを限定することができる
  # この場合、onlyの後に配列で記述されている"new","index","show"のアクション以外は、
  # ルーティングが行われない。

  # resources :post_images, only: [:new, :create, :index, :show, :destroy]
  # post_commentsはpost_imagesに結びつくため、以下のように親子関係になる。
  # 親のresourcesで指定したコントローラ名に、子のresourcesで指定したコントローラ名が
  # 続くURLが生成される　→ 「post_image_post_comments」
  # このような親子関係を「ネストする」と言う。このようなネストしたURLを作成することで
  # params[:post_image_id]でPostImageのidが取得できるようになる。
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resources :post_comments, only: [:create]
  end
  resources :users, only: [:show, :edit, :update]

end
