Rails.application.routes.draw do
    # deviseのモデルを作成したことで、ルーティングが自動的に追加されている。
    # devise_for :usersは、deviseを使用する際にURLとしてusersを含むことを示している。
    devise_for :users

    root to: "homes#top"

    get 'homes/about' ,as: 'about'
end
