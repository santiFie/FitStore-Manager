class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { admin: 0, supervisor: 1, employee: 2 }


  # Callback to set the default role
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :employee
  end

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
  validates :start_date, presence: true
  validates :phone, presence: true
end
