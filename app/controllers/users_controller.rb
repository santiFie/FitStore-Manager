class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users
  def index
    authorize! :read, User
    @users = User.all
  end

  # GET /users/new
  def new
    authorize! :create, User
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize! :update, User
  end

  # POST /users
  def create
    authorize! :create, User
    if user_params[:role] == "administrador"
      flash[:alert] = "No puedes crear un usuario con el rol de administrador."
      redirect_to new_user_path and return
    end

    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: "Usuario creado correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    authorize! :update, User

    if @user.role == "administrador" && current_user.role != "administrador"
      Rails.logger.info("Rol del usuario: #{@user[:role]}")
      Rails.logger.info("Rol del usuario a cambiar: #{current_user.role}")
      redirect_to users_path, alert: "No puedes cambiar el rol de un usuario administrador." and return
    end

    if @user.update(user_params)
      flash[:notice] = "Usuario actualizado correctamente."
      redirect_to users_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    authorize! :destroy, User
    @user.destroy!

    flash[:notice] = "Usuario eliminado correctamente."
    redirect_to users_path, status: :see_other and return
  end

  # GET /users/1/block
  def block
    authorize! :block, User
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to users_path, alert: "No puedes bloquearte a ti mismo."
    end
      @user.block

    redirect_to users_path, notice: "Usuario bloqueado correctamente."
  end

  # GET /users/1/unblock
  def unblock
    authorize! :unblock, User
    @user = User.find(params[:id])
    @user.unblock

    redirect_to users_path, notice: "Usuario desbloqueado correctamente."
  end

  private
    def set_user
      @user = User.find(params.expect(:id))
    end

    def user_params
      params.expect(user: [ :username, :email, :phone, :role, :start_date, :password, :password_confirmation ])
    end
end
