class ProductsController < ApplicationController
  load_and_authorize_resource
  def index
    # authorize! :read, Product
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).filter { |product| product.available_stock > 0 }
  end

  def new
    #    authorize! :create, Product
    #    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    begin
      if @product.save
        flash[:notice] = "Producto creado exitosamente"
        redirect_to products_path
      else
        puts "Errores al guardar:"
        @product.errors.full_messages.each do |error|
          puts error
        end
        render :new, status: :unprocessable_entity
      end
    rescue
      flash[:alert] = "No se pudo guardar el producto"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # authorize! :read, Product
    # @product = Product.find(params[:id])
  end

  def edit
    # authorize! :update, Product
    # @product = Product.find(params[:id])
  end

  def update
    # authorize! :update, Product
    @product = Product.find(params[:id])

    images_to_delete = params[:product][:images_to_delete]&.split(",") || []
    Rails.logger.debug "Imágenes a eliminar: #{images_to_delete}"

    images_to_delete.each do |image_id|
      @product.images.find(image_id).purge
    end

    # Si hay nuevas imágenes, adjúntalas
    if params[:product][:images]
      params[:product][:images].each do |image|
        @product.images.attach(image)
      end
      params[:product].delete(:images) # Delete the images from the params to avoid validation errors
    end

    if @product.update(product_params)
      redirect_to products_path, notice: "Producto actualizado exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end



  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to products_path, notice: "Producto eliminado exitosamente."
    else
      redirect_to products_path, alert: "No se pudo eliminar el producto."
    end
  end

  def delete_image
    @product = Product.find(params[:id])
    @image = @product.images.find(params[:image_id])
    if @image
      @image.purge
      redirect_to edit_product_path(@product), notice: "Imagen eliminada exitosamente"
    else
      redirect_to edit_product_path(@product), alert: "No se pudo eliminar la imagen"
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to edit_product_path(@product), alert: "Imagen no encontrada"
  end

  private
    def product_params
      params.require(:product).permit(:name, :description, :unit_price, :available_stock, :category_id, images: [])
    end
end
