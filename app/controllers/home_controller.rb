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

  def welcome
    @title = "C'est parti !"
  end

  def thanks
    @title = "Merci!"
  end
end
