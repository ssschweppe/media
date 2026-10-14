class Ability
  include CanCan::Ability

  def initialize(user)
    # Здесь будут права для трёх видов доступа: гость, user, admin.
    # Добавим, когда появятся таблицы.
  end
end