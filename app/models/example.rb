class Example < ApplicationRecord
  belongs_to :studio, optional: true
  has_many :breakdowns, dependent: :destroy
  validates :name, :url, presence: true
end
