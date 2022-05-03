class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # 以下はアソシエーションを持っているモデル同士の記述方法。
    # 特定のユーザ(@user)に関連付けられた投稿全て(.post_images)を取得し、
    # @post_imagesに渡すという処理を行うことができる。

    # ページネーションのため修正
    # @post_images = @user.post_images
    @post_images = @user.post_images.page(params[:page])
  end

  def edit
    # URLを参考に特定のidを持ったレコードを取得する
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
