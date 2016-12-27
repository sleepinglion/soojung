class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin? # Admin user
      can :manage, :all
    else # Non-admin user
      can :manage, [Question,GuestBook]
    end
  end
end