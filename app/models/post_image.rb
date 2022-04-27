class PostImage < ApplicationRecord
  # PostImageモデルにActiveStorageを使って画像を持たせるため、
  # モデルの設定ファイルに以下を記述する必要がある。
  has_one_attached :image
end
