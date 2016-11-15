class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @errors = flash[:errors]
  end

  def create
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])

    if @user.valid?
      @user.save
      redirect_to '/'
    else

      errors = @user.errors
      flash[:first_name_error] = errors['first_name'].join(", ").capitalize
      flash[:last_name_error] = errors['last_name'].join(", ").capitalize
      flash[:email_error] = errors['email'].join(", ").capitalize
      flash[:password_error] = errors['password'].join(", ").capitalize

      redirect_to '/new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.email = params[:email]

    if @user.save
      redirect_to "/users/#{params[:id]}"
    else
      errors = @user.errors
      flash[:first_name_error] = errors['first_name'].join(", ").capitalize
      flash[:last_name_error] = errors['last_name'].join(", ").capitalize
      flash[:email_error] = errors['email'].join(", ").capitalize
      redirect_to "/users/#{params[:id]}/edit"
    end
  end

  def destroy
    @destroy = User.find(params[:id]).destroy
    redirect_to '/'
  end

end
