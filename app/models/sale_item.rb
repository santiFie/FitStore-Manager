class SaleItem < ApplicationRecord
  belongs_to :sale
  belongs_to :product

  before_save :calculate_subtotal

  def calculate_subtotal
    self.subtotal = quantity * unit_price
  end

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
