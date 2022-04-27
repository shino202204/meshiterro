class PostImage < ApplicationRecord
  # PostImageモデルにActiveStorageを使って画像を持たせるため、
  # モデルの設定ファイルに以下を記述する必要がある。
  has_one_attached :image

  # PostImageモデルに対して、Userモデルとの関係性を追加する。
  # has_manyとは逆に、1:Nの「N」側にあたるモデルに、belongs_toを記載する必要がある。
  # PostImageモデルに関連付けられるのは、1つのUserモデル。
  # そのため、単数形の「user」になっている点に注意。
  belongs_to :user
end
