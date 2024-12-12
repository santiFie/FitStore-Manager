class SalesController < ApplicationController
  before_action :set_sale, only: %i[ show edit update destroy ]

  # GET /sales or /sales.json
  def index
    authorize! :read, Sale
    @sales = Sale.all.filter { |sale| sale.canceled == false }
  end

  # GET /sales/1 or /sales/1.json
  def show
    authorize! :read, Sale
  end

  # GET /sales/new
  def new
    authorize! :create, Sale
    @sale = Sale.new
    @sale.build_client  # Crea un cliente vacío para el formulario
    @sale.prepare_sale_items # Crea un ítem de venta vacío
  end

  # GET /sales/1/edit
  def edit
    authorize! :update, Sale
    @sale = Sale.find(params[:id])
    Rails.logger.info("Parámetros recibidor: #{@sale.sale_items.inspect}")
  end


  def create
    authorize! :create, Sale
    Rails.logger.info("Parámetros recibidos: #{create_sale_params.inspect}")
    @sale = Sale.new(create_sale_params)
    Rails.logger.info("Parámetros recibidos: #{create_sale_params.inspect}")

    @sale.user = current_user

    # Configura el cliente antes de validar y guardar
    @sale.client = Client.find_or_initialize_by(dni: create_sale_params[:client_attributes][:dni])
    @sale.client.assign_attributes(create_sale_params[:client_attributes])

    if @sale.valid? && @sale.client.valid?
      ActiveRecord::Base.transaction do
        @sale.client.save!
        @sale.client_id = @sale.client.id
        @sale.save!
        redirect_to @sale, notice: "Venta creada exitosamente."
      end
    else
      # Renderiza el formulario nuevamente con los errores
      render :new, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid
    # Captura cualquier error de validación durante la transacción
    render :new, status: :unprocessable_entity
  end

  #  # POST /sales or /sales.json
  # def create
  #   @sale = Sale.new(create_sale_params)

  #   ActiveRecord::Base.transaction do
  #     @client = Client.find_or_create_by!(create_sale_params[:client_attributes])

  #     @sale.user = current_user
  #     @sale.client_id = @client.id

  #     @sale.save!

  #     redirect_to @sale, notice: "Sale was successfully created."
  #   render :new, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /sales/1 or /sales/1.json
  def update
    authorize! :update, Sale

    Rails.logger.info("Parámetros recibidos: #{update_sale_params.inspect}")
    if @sale.update(update_sale_params)
      redirect_to @sale, notice: "Venta actualizada correctamente"
    else
      Rails.logger.info(@sale.errors.full_messages)
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /sales/1 or /sales/1.json
  def destroy
    authorize! :destroy, Sale

    @sale.cancel
    redirect_to sales_path, status: :see_other, notice: "Venta cancelada correctamente"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params.fetch(:id))
    end

    def create_sale_params
      params.require(:sale).permit(
        :sale_date,
        :total,
        client_attributes: [ :dni, :first_name, :last_name, :email, :birth_date ],
        sale_items_attributes: [ :id, :product_id, :quantity, :subtotal, :_destroy ]
      )
    end


    def update_sale_params
      params.require(:sale).permit(
        :sale_date,
        :total,
        client_attributes: [ :id, :dni, :first_name, :last_name, :email, :birth_date ],
        sale_items_attributes: [ :id, :product_id, :quantity, :subtotal, :_destroy ]
      )
    end
end
