class Client < ApplicationRecord
  validates :dni, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true

  has_many :sales
end
