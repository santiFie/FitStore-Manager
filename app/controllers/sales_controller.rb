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
    @sale.prepare_sale_items # Crea un ítem de venta vacío
  end

  # GET /sales/1/edit
  def edit
    @sale = Sale.find(params[:id])
    Rails.logger.info(@sale.sale_items.inspect)
  end


  def create
    @sale = Sale.new(create_sale_params)
    begin
      ActiveRecord::Base.transaction do
        # Primero, valida el cliente
        client_attributes = create_sale_params[:client_attributes]
        @client = Client.new(client_attributes)


        Rails.logger.info("Estos son los parametros: #{@sale_items_data}")

        # Si el cliente no es válido, lanza una excepción
        unless @client.valid?
          @client.errors.full_messages.each do |message|
            @sale.errors.add(:base, message)
          end
          raise ActiveRecord::RecordInvalid.new(@client)
        end


        # Si el cliente es válido, encuentra o crea
        @client = Client.find_or_create_by!(dni: @client.dni) do |client|
          client.assign_attributes(create_sale_params[:client_attributes])
        end

        @sale.user = current_user
        @sale.client_id = @client.id

        # Valida la venta antes de guardar
        unless @sale.valid?
          @sale.errors.full_messages.each do |message|
            Rails.logger.info("Sale Error: #{message}")
          end
          raise ActiveRecord::RecordInvalid.new(@sale)
        end

        @sale.save!

        redirect_to @sale, notice: "Venta creada exitosamente."
      end
    rescue ActiveRecord::RecordInvalid
      render :new, status: :unprocessable_entity
    end
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
    if @sale.update(update_sale_params)
      redirect_to @sale, notice: "Sale was successfully updated."
    else
      Rails.logger.info(@sale.errors.full_messages)
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

    def update_sale_params
      params.require(:sale).permit(
        :sale_date,
        :total,
        client_attributes: [ :id, :first_name, :last_name, :email, :birth_date ],
        sale_items_attributes: [ :id, :product_id, :quantity, :subtotal ]
      )
    end

    def create_sale_params
      params.require(:sale).permit(
        :sale_date,
        :total,
        client_attributes: [ :dni, :first_name, :last_name, :email, :birth_date ],
        sale_items_attributes: [ :id, :product_id, :quantity, :subtotal, :_destroy ]
      )
    end
end
