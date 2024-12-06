class Sale < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :sale_items, dependent: :destroy

  validates :total, presence: true
  validates :sale_date, presence: true

  accepts_nested_attributes_for :sale_items, allow_destroy: true, reject_if: lambda { |attributes| attributes["product_id"].blank? }
  accepts_nested_attributes_for :client
end
