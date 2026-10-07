class Source < ApplicationRecord
    has_many :card_items, dependent: :nullify
    enum :kind, { research: 0, ab_test: 1, interview: 2, article: 3 }
    validates :title, presence: true
end
