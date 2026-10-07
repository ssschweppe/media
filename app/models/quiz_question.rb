class QuizQuestion < ApplicationRecord
  belongs_to :breakdown
  validates :prompt, presence: true
end
