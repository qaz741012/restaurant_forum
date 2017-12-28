class RestaurantsController < ApplicationController


  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new(content: params[:content], score: params[:score])
  end

  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  def dashboard
    @restaurant = Restaurant.find(params[:id])
  end

  def favorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant.favorites.create!(user: current_user)
    @restaurant.update_favorites_count
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    @restaurant = Restaurant.find(params[:id])
    favorite = Favorite.where(restaurant: @restaurant, user: current_user)
    favorite.destroy_all
    @restaurant.update_favorites_count
    redirect_back(fallback_location: root_path)
  end

  def ranking
    @top10_restaurants = Restaurant.order(favorites_count: :desc).limit(10)
  end

end
