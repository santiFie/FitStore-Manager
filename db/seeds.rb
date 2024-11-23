# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "date"

# Borra todos los datos con Rails
Product.destroy_all
Category.destroy_all

# Reinicia los autoincrementos
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='products'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='categories'")


# Create categories
Category.find_or_create_by!(name: "Ropa femenina")
Category.find_or_create_by!(name: "Ropa masculina")
Category.find_or_create_by!(name: "Ropa infantil")
Category.find_or_create_by!(name: "Accesorios")

# Create products
# Create products
products = [
  { name: "Blusa", description: "Blusa de algodón", unit_price: 100, available_stock: 50, size: "M", color: "Rojo", entry_date: Date.today, last_modified_at: DateTime.now, category_id: 1, images: [File.open("/home/santiago/Documentos/Tercero/Ruby/Images/Blusa.webp")] },
  { name: "Pantalón", description: "Pantalón de mezclilla", unit_price: 200, available_stock: 30, size: "L", color: "Azul", entry_date: Date.today, last_modified_at: DateTime.now, category_id: 2, images: [File.open("/home/santiago/Documentos/Tercero/Ruby/Images/Pantalon.webp")] },
  { name: "Vestido", description: "Vestido de verano", unit_price: 150, available_stock: 20, size: "S", color: "Amarillo", entry_date: Date.today, last_modified_at: DateTime.now, category_id: 1, images: [File.open("/home/santiago/Documentos/Tercero/Ruby/Images/Vestido.webp")] },
  { name: "Camisa", description: "Camisa formal", unit_price: 120, available_stock: 40, size: "M", color: "Blanco", entry_date: Date.today, last_modified_at: DateTime.now, category_id: 2, images: [File.open("/home/santiago/Documentos/Tercero/Ruby/Images/Camisa.webp")] },
  { name: "Falda", description: "Falda corta", unit_price: 80, available_stock: 25, size: "S", color: "Negro", entry_date: Date.today, last_modified_at: DateTime.now, category_id: 1, images: [File.open("/home/santiago/Documentos/Tercero/Ruby/Images/Falda.webp")] },
  { name: "Chaqueta", description: "Chaqueta de cuero", unit_price: 300, available_stock: 15, size: "L", color: "Marrón", entry_date: Date.today, last_modified_at: DateTime.now, category_id: 2, images: [File.open("/home/santiago/Documentos/Tercero/Ruby/Images/Campera.webp")] },
  { name: "Sombrero", description: "Sombrero de paja", unit_price: 50, available_stock: 60, size: "Único", color: "Beige", entry_date: Date.today, last_modified_at: DateTime.now, category_id: 4, images: [File.open("/home/santiago/Documentos/Tercero/Ruby/Images/Sombrero.webp")] },
  { name: "Bufanda", description: "Bufanda de lana", unit_price: 70, available_stock: 35, size: "Único", color: "Gris", entry_date: Date.today, last_modified_at: DateTime.now, category_id: 4, images: [File.open("/home/santiago/Documentos/Tercero/Ruby/Images/Bufanda.webp")] },
  { name: "Zapatos", description: "Zapatos deportivos", unit_price: 250, available_stock: 45, size: "42", color: "Negro", entry_date: Date.today, last_modified_at: DateTime.now, category_id: 2, images: [File.open("/home/santiago/Documentos/Tercero/Ruby/Images/Zapatos.webp")] },
  { name: "Cinturón", description: "Cinturón de cuero", unit_price: 90, available_stock: 55, size: "Único", color: "Negro", entry_date: Date.today, last_modified_at: DateTime.now, category_id: 4, images: [File.open("/home/santiago/Documentos/Tercero/Ruby/Images/Cinturon.webp")] }
]

# Insert the products into the database
products.each do |product|
  Product.create!(product)
end
