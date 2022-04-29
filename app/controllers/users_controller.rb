class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # 以下はアソシエーションを持っているモデル同士の記述方法。
    # 特定のユーザ(@user)に関連付けられた投稿全て(.post_images)を取得し、
    # @post_imagesに渡すという処理を行うことができる。
    @post_images = @user.post_images
  end

  def edit
  end
end
