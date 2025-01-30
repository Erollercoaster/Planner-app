class ApplicationController < ActionController::Base
    before_action :set_categories
    before_action :initialize_new_category
    before_action :authenticate_user!
  
    private
  
    def set_categories
      @categories = current_user.categories.all if current_user
    end

    def initialize_new_category
      @new_category = current_user.categories.build if current_user
    end  
  end
  