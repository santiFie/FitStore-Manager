# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    cannot :manage, :all

    can :read, Product # Allow anyone to read products

    return unless user.present?

    if user.administrador?
      can :manage, :all
    end

    if user.supervisor?
      can :manage, Category
      can :manage, Sale
      can :manage, Product
      can :create, Client
      can :update, Client
      can :destroy, Client
      can :create, SaleItem
      can :update, SaleItem
      can :destroy, SaleItem
      can :create, User, role: "supervisor"
      can :update, User do |u|
      !u.administrador?
      end
      can :destroy, User do |u|
      !u.administrador?
      end
      can :block, User do |u|
      !u.administrador?
      end
      can :unblock, User do |u|
      !u.administrador?
      end
      can :read, User
    end

    if user.empleado?
      can :manage, Product
      can :manage, Category
      can :manage, Sale
      can :create, Client
      can :update, Client
      can :destroy, Client
      can :create, SaleItem
      can :update, SaleItem
      can :destroy, SaleItem
    end
  end
end
# Define abilities for the user here. For example:
#
#   return unless user.present?
#   can :read, :all
#   return unless user.admin?
#   can :manage, :all
#
# The first argument to `can` is the action you are giving the user
# permission to do.
# If you pass :manage it will apply to every action. Other common actions
# here are :read, :create, :update and :destroy.
#
# The second argument is the resource the user can perform the action on.
# If you pass :all it will apply to every resource. Otherwise pass a Ruby
# class of the resource.
#
# The third argument is an optional hash of conditions to further filter the
# objects.
# For example, here the user can only update published articles.
#
#   can :update, Article, published: true
#
# See the wiki for details:
# https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
