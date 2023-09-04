class User < ApplicationRecord

  validates :name, presence: true, length: { maximum: 250 }
  has_many :recipes, dependent: :destroy

end