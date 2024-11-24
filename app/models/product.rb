class Product < ApplicationRecord
  # Validations
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: { greater_than: 0 }
  validates :available_stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :entry_date, presence: true

  # Associations (if you have an Image model)
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize: "350x350"
  end

  def self.ransackable_attributes(auth_object = nil)
    # List of attributes that can be searched
    ["name", "description", "unit_price", "available_stock", "entry_date"]
  end

  # Allows to search by associations
  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  belongs_to :category
end
