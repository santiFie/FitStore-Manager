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
  
  belongs_to :category
end
