class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, [Category, Pattern]

    can :read, Breakdown, Breakdown.published do |breakdown|
      breakdown.published_at.present?
    end

    # если пользователь не админ, правила закагчиваются
    return unless user&.admin? # админ может

    can :manage, :all
  end
end
