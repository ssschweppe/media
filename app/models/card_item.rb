class CardItem < ApplicationRecord
  belongs_to :breakdown
  belongs_to :source, optional: true

  # создание словаря для карточек со значениями порядка их вывода на страницу
  enum :kind, { gain: 0, cost_user: 1, cost_business: 2, cost_team: 3, cost_studio: 4, condition: 5 } 
  validates :text, presence: true

  # метод hypothesis? проверяет, указан ли источник и возвращает true, если нет и false, если есть
  def hypothesis?
    source.nil?
  end
end
