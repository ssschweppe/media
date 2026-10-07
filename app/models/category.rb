class Category < ApplicationRecord
    has_many :patterns, dependent: :destroy # если удаляется категория, то сначала удаляются все связанные паттерны, а потом она сама
    validates :name, presence: true # проверка на то, заполнено ли в бд поле названия
end
