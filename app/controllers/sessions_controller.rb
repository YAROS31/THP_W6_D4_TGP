class SessionsController < ApplicationController
  def new
    #redirect_to sessions_create_path
    puts "Entering in the session#new"
  end

  def create
    user = User.find_by(email: params[:email])
            if user && user.authenticate(params[:password])
                session[:user_id] = user.id
            redirect_to gossips_path, flash: {success: "Welcome back" }
        else
            render 'new'
        end
    # sessions[:user_id] = 1
    # redirect_to gossips_path, notice: "You are now logged into TGP. Welcome"
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "Deconnexion réussie"
    render "sessions/new"
  end
end
