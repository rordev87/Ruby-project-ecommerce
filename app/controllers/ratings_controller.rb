class RatingsController < ApplicationController

  def update
    @rating = Rating.get_rating_record(current_user.id, params[:product_id])
    if @rating.nil?
      if Rating.create(user_id: current_user.id, product_id: params[:product_id],
        rate: params[:score])
        respond_to do |format|
          format.js
        end
      end
    else
      if @rating.update_attributes(rate: params[:score])
        respond_to do |format|
          format.js
        end
      end
    end
  end

end
