class Breakdown < ApplicationRecord
  belongs_to :pattern
  belongs_to :example
  has_many :card_items, -> { order(:kind, :position) }, dependent: :destroy #сортировка внутри карточки по типу отклонения
  has_many :quiz_questions, dependent: :destroy

  scope :published, -> { where.not(published_at: nil) } # фильтр :published отсеивает статьи без даты публикации (черновики)
  validates :title, presence: true
end
