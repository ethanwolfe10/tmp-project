class StaticController < ApplicationController
  def home
    if !current_user
      redirect_to new_user_session_path
    else
      redirect_to user_path(current_user)
    end
  end
end
