class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if (user)
      log_in(user)
      redirect_to user
    else
      flash.now[:danger] = "Invalide email"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to(root_path)
  end

  def toto
    return true
  end
  
end
