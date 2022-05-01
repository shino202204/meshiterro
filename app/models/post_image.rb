class PostImage < ApplicationRecord
  # PostImageモデルにActiveStorageを使って画像を持たせるため、
  # モデルの設定ファイルに以下を記述する必要がある。
  has_one_attached :image

  # PostImageモデルに対して、Userモデルとの関係性を追加する。
  # has_manyとは逆に、1:Nの「N」側にあたるモデルに、belongs_toを記載する必要がある。
  # PostImageモデルに関連付けられるのは、1つのUserモデル。
  # そのため、単数形の「user」になっている点に注意。
  belongs_to :user

  has_many :post_comments, dependent: :destroy

  # 画像が投稿されていない場合のエラーを回避する
  # PostImageモデルの中に記述することで、カラムを呼び出すように
  # このget_imageメソッドを呼び出すことができるようになる。
  # メソッド内容：画像が設定されない場合はapp/assets/imagesに格納されている
  # no_image.jpgという画像をデフォルト画像としてActiveStorageに格納し、
  # 格納した画像を表示する。
  # → このメソッドであれば、Railsで画像のサイズ変更を行うことができる。
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
  end

  # 引数で渡されたユーザidがFavoriteテーブル内に存在(exists?)するかどうかを調べる
  # 存在していればtrue、存在していなければfalseを返す
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
