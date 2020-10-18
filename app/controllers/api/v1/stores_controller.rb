class Api::V1::StoresController < ApplicationController
  before_action :set_store, only: [:show]

  def index
    @stores = Store.within(params[:longitude].to_f, params[:latitude].to_f)
      .sort_by { |store| store.ratings_average }
      .reverse
  end

  def show
  end

  private 

  def set_store
    @store = Store.find_by!(google_place_id: params[:id])
  end
end
