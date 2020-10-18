class Api::V1::RatingsController < ApplicationController

  def create
    ActiveRecord::Base.transaction do
      create_store
      create_rating

      render json: @rating
    end
  end

  private 

  def create_rating
    @rating = Rating.new(ratings_params)

    @rating.store_id = @store.id
    @rating.save!
  end

  def create_store
    @store = Store.find_or_create_by!(
      lonlat: "POINT(#{params[:store][:longitude].to_f} #{params[:store][:latitude].to_f})",
      name: params[:store][:name],
      address: params[:store][:address],
      google_place_id: params[:store][:google_place_id],
    )
  end

  def ratings_params
    params.require(:rating).permit(:value, :opinion, :user_name)
  end
end
