class HomeController < ApplicationController
  def index
    @title = "Rsnap"
  end

  def about
    @title = "A propos"
  end

  def after_missions_form
    @title = "Formulaire"
  end
end
