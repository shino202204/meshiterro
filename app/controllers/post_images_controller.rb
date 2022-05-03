class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  # 投稿データの保存
  def create
    @post_image = PostImage.new(post_image_params)
    # 「current_user」:ヘルパーメソッドの一種。deviseをインストールすることで使えるようになる。
    # current_userは、コードに記述するだけで、ログイン中のユーザーの情報を取得できる。
    # つまり以下では、投稿データのuser_idを、現在ログインしているユーザーのIDに指定している。
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path
    else
      render:new
    end
  end

  def index
    # post_imagesデーブル内に存在する全てのレコードのインスタンスを代入
    # @post_images = PostImage.all

    # １ページ分の決められた数のデータだけを、新しい順に取得するように変更している。
    # pageメソッド：kaminariをインストールしたことで使用可能になったメソッド。
    @post_images = PostImage.page(params[:page])
  end

  def show
    @post_image = PostImage.find(params[:id])
    # コメント投稿用
    @post_comment = PostComment.new
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end

  # 投稿データのストロングパラメータ
  private

  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end
end
