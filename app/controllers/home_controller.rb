class HomeController < ApplicationController

  def index
    @no_sidebar = true
    @landing = true

    if current_user
      redirect_to apply_path
    end
  end

end
