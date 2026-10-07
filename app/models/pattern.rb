class Pattern < ApplicationRecord
  belongs_to :category
  has_many :breakdowns, dependent: :destroy
  validates :title, presence: true
end
