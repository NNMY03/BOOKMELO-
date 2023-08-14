class Public::FavoritesController < ApplicationController
  
  def create
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: post.id)
    # binding.irb
     favorite.save
     redirect_to books_path
  end
  
  def destroy
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: post.id)
     favorite.destroy
     redirect_to books_path
  end
  
end
