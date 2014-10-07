class UsersController < ApplicationController
  before_action :authenticate!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authorize_user!, only: [:edit, :update]

  def index
    if params[:search]
      @pg_search_documents = PgSearch.multisearch(params[:search])
    else
      @users = User.all
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice]= "User profile is updated successfully"
      redirect_to user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user!
    unless @user == current_user
      redirect_to root_url,
        notice: "You need to sign in!"
    end
  end
end