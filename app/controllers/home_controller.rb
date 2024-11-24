class HomeController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    Rails.logger.debug "Parámetros de búsqueda: #{params[:q]}"  # Para ver qué parámetros llegan
    @products = @q.result(distinct: true)
    Rails.logger.debug "SQL generado: #{@products.to_sql}"      # Para ver la consulta SQL
  end
end