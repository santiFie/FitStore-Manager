class Sale < ApplicationRecord
  belongs_to :client
  belongs_to :employee, class_name: "User"
  has_many :sale_items, dependent: :destroy

  validates :total, presence: true
  validates :sale_date, presence: true

  accepts_nested_attributes_for :sale_items, allow_destroy: true
  accepts_nested_attributes_for :client
end
