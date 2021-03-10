class Ability
	include CanCan::Ability

	def initialize(user)

		alias_action :index, :create, :update, :destroy, :to => :icud

		user ||= User.new # guest user (not logged in)

		if user.role? :admin
			# can :manage, :all
			can :icud, User
			can :icud, UserRole
			can :icud, UserStatus
			can :icud, Category

		elsif user.role? :user

		end

	end
end