class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { administrador: 0, supervisor: 1, empleado: 2 }


  # Callback to set the default role
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :empleado
  end

  def blocked?
    self.blocked
  end

  def block
    update(blocked: true, password: Devise.friendly_token(8))
  end

  def unblock
    update(blocked: false, password: "password")
  end

  validates :username, presence: true, uniqueness: { message: "Este nombre de usuario ya ha sido tomado" }
  validates :email, presence: true, uniqueness: { message: "Este mail ya ha sido tomado" }
  validates :role, presence: true
  validates :start_date, presence: true
  validates :phone, presence: true, length: { is: 10, message: "El teléfono debe tener 10 números" }
end
