class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  SLUG_FORMAT = /\A[a-z0-9]+(-[a-z0-9]+)*\z/
end
