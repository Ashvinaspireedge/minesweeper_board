class User < ApplicationRecord
  has_many :boards, dependent: :destroy

  accepts_nested_attributes_for :boards

  validates :email, presence: true
end
