class Example < ApplicationRecord
  belongs_to :studio
  has_many :breakdowns, dependent: :destroy
  validates :name, :url, presence: true
end
