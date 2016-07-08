class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, Subject
      can [:create, :show, :read, :update], Exam
      can [:read], Question
    end
  end
end
