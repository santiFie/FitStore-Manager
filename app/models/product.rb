class Product < ApplicationRecord
  # Validations
  before_validation :set_entry_date, on: :create
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: { greater_than: 0 }
  validates :available_stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :entry_date, presence: true

  # Associations (if you have an Image model)
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize: "350x350"
  end

  validate :acceptable_images, :must_have_at_least_one_image

  def self.ransackable_attributes(auth_object = nil)
    # List of attributes that can be searched
    [ "name", "description", "unit_price", "available_stock", "entry_date", "category_id" ]
  end

  # Allows to search by associations
  def self.ransackable_associations(auth_object = nil)
    [ "category" ]
  end

  belongs_to :category

  private
  def set_entry_date
    self.entry_date ||= Date.current
  end

  def acceptable_images
    return unless images.attached?

    images.each do |image|
      # Validate the content type
      unless image.blob.content_type.in?([ "image/png", "image/jpeg", "image/jpg", "image/gif", "image/webp" ])
        errors.add(:images, "Las imagenes deben ser archivos PNG, JPEG, WEBP, JPG o GIF")
      end

      if image.blob.byte_size > 5.megabytes
        errors.add(:images, "Las imagenes deben ser menores a 5MB")
      end
    end
  end

  def must_have_at_least_one_image
    if images.blank?
      errors.add(:images, "Debe existir al menos una imagen adjunta.")
    end
  end
end
