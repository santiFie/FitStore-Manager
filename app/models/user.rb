class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { admin: 0, supervisor: 1, employee: 2 }


  # Callback to set the default role
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :employee
  end

  def blocked?
    self.blocked
  end

  def block
    self.blocked = true
    self.password = Devise.friendly_token(8)
    self.save
  end

  def unblock
    self.blocked = false
    self.password = "password"
    self.save
  end

  # Validations
  validates :username, presence: true, uniqueness: { message: "ya ha sido tomado" }
  validates :email, presence: true, uniqueness: { message: "ya ha sido tomado" }
  validates :role, presence: true
  validates :start_date, presence: true
  validates :phone, presence: true
end
