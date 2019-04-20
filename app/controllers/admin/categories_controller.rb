class Admin::CategoriesController < ApplicationController
  
  def index
   # @categories = Category.list_users_desc.paginate page: params[:page],
    #  per_page: Settings.per_page
     @categories = Category.get_root_categories
  end

end
