# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Por defecto, nadie puede hacer nada
    cannot :manage, :all

    # Permisos básicos para todos (incluso usuarios no logueados)
    can :read, Product

    # Retornar si no hay usuario logueado
    return unless user.present?

    if user.administrador?
      can :manage, :all
    elsif user.supervisor?
      # Permisos de supervisor
      can :manage, [ Category, Sale, Product, SaleItem ]
      can [ :create, :update, :destroy ], Client

      # Permisos específicos para User
      can :read, User
      can :create, User, role: "supervisor"

      # Puede editar/actualizar usuarios que no sean administradores o a sí mismo
      can [ :edit, :update ], User do |u|
        u.id == user.id || !u.administrador?
      end

      # Puede realizar acciones sobre usuarios que no sean administradores
      can [ :destroy, :block, :unblock ], User do |u|
        !u.administrador?
      end
    elsif user.empleado?
      # Permisos de empleado
      can :manage, [ Product, Category, Sale ]
      can [ :create, :update, :destroy ], [ Client, SaleItem ]

      # Un empleado puede editar su propio perfil
      can [ :edit, :update ], User, id: user.id
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
