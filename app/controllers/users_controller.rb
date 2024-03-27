class UsersController < ApplicationController

  def index
    @users = User.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name])
    if @user.save
      @users = User.order(created_at: :desc)
      render turbo_stream: turbo_stream.append('users_list', partial: 'users/users_form', users: @users)
    else
      render turbo_stream: turbo_stream.replace('users_list', partial: 'error_form')
    end
  end

  def search
    search_query = params[:any][:search]
    if search_query.present?
      @users = User.where("name ILIKE ?", "%#{search_query}%")&.order(created_at: :desc)
      render turbo_stream: turbo_stream.replace('users_list', partial: 'searched_users', locals: { users: @users })

      # optimize way, and here you can enter inputs continouosly ->
      # render turbo_stream: turbo_stream.replace('users_list', partial: 'users/users_form', users: @users)
    else
      render turbo_stream: turbo_stream.replace('users_list', partial: 'error_form')
    end
  end

end
