class SaleItem < ApplicationRecord
  belongs_to :sale
  belongs_to :product

  before_save :calculate_subtotal

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def calculate_subtotal
    self.subtotal = quantity * product.unit_price if quantity.present? && product.present?
  end
end
