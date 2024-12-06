class SalesController < ApplicationController
  before_action :set_sale, only: %i[ show edit update destroy ]

  # GET /sales or /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1 or /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
    @sale.build_client  # Crea un cliente vacío para el formulario
    @sale.sale_items.build  # Crea un ítem de venta vacío
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales or /sales.json
  def create
    @sale = Sale.new(sale_params)

    begin
      ActiveRecord::Base.transaction do
        Rails.logger.info("Creating sale...")
        Rails.logger.info("Este es el usuario current #{current_user.inspect}")

        @client = Client.find_or_create_by!(sale_params[:client_attributes])
        Rails.logger.info("Client created")
        Rails.logger.info(@client.inspect)

        @sale.user = current_user
        @sale.client_id = @client.id

        @sale.save!

        redirect_to @sale, notice: "Sale was successfully created."
      end
    rescue
      flash.now[:alert] = "Hubo un error al crear la venta."
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sales/1 or /sales/1.json
  def update
    if @sale.update(sale_params)
      redirect_to @sale, notice: "Sale was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /sales/1 or /sales/1.json
  def destroy
    @sale.destroy!
    redirect_to sales_path, status: :see_other, notice: "Sale was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params.expect(:id))
    end

    def sale_params
      params.require(:sale).permit(
        :sale_date,
        :total,
        client_attributes: [ :first_name, :last_name, :email, :phone, :dni, :birth_date ],
        sale_items_attributes: [ :product_id, :quantity, :subtotal ]
      )
    end
end
