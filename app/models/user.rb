class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Userモデルに対して、PostImageモデルが1:Nになるよう関連づける。
  # 1:Nの「1」側に当たるモデルに、has_manyを記載する必要がある。
  has_many :post_images, dependent: :destroy

  # profile_imageという名前でActiveStorageでプロフィール画像を保存できるように設定。
  has_one_attached :profile_image

  def get_profile_image(width, height)
    # 「unless」：もし〜でなければ → もし画像が添付されていなければ
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width,height]).processed
  end

end
