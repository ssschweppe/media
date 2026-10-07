class Studio < ApplicationRecord
    has_many :examples, dependent: :nullify # разрывает связи с дочерними "примерами", но сами они остаются, просто без ссылки на "студию"
    validates :name, presence: true
end
