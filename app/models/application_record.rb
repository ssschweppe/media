class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Slug у рубрик, категорий и постов: строчная латиница и цифры, слова через дефис
  SLUG_FORMAT = /\A[a-z0-9]+(-[a-z0-9]+)*\z/
end
