class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_customer.favorites.create(post_id: @post.id)
     @favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_customer.favorites.find_by(post_id: @post.id)
     @favorite.destroy
  end

end
