class Sale < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :sale_items, dependent: :destroy

  validates :total, presence: true
  validates :sale_date, presence: true
  validate :sale_date_cannot_be_in_the_future_or_too_old
  validates_associated :client

  accepts_nested_attributes_for :sale_items, allow_destroy: true, reject_if: lambda { |attributes| attributes["product_id"].blank? }
  accepts_nested_attributes_for :client

  validate :validate_sale_items

  def prepare_sale_items
    sale_items.build if sale_items.empty?
  end

  private

  def validate_sale_items
    if sale_items.empty?
      errors.add(:base, "Debe agregar al menos un producto a la venta")
    end
  end

  private

  def sale_date_cannot_be_in_the_future_or_too_old
    Rails.logger.info("Fecha de venta: #{sale_date}")
    Rails.logger.info("Fecha actual: #{Date.today}")
    Rails.logger.info(sale_date.present?)
    if sale_date.present?
      if sale_date > Date.today
        errors.add(:sale_date, "No puede ser en el futuro")
      elsif sale_date < 1.years.ago
        errors.add(:sale_date, "No puede ser tan antigua")
      end
    end
  end
end
