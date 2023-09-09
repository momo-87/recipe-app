class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :public_recipes, Recipe
    can :read, Recipe, public: true

    return unless user.persisted?
    can :manage, Recipe, user_id: user.id
    can :manage, RecipeFood

    return unless user.role == 'admin'
    can :manage, :all
  end
end
