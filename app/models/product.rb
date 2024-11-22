class Product < ApplicationRecord
  # Validaciones
  validates :nombre, presence: true
  validates :descripcion, presence: true
  validates :precio_unitario, presence: true, numericality: { greater_than: 0 }
  validates :stock_disponible, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :categoria, presence: true
  validates :fecha_ingreso, presence: true

  # Asociaciones (si tienes un modelo Imagen)
  has_many_attached :imagenes # Para Active Storage
end
