class GreatsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.greats.create!(post_id: @post.id)
    #redirect_back fallback_location: root_path, warning: 'いいねしました'

    render turbo_stream: turbo_stream.replace(
      'great-button',
      partial: 'posts/great_button',
      locals: { product: @product, liked: true },
    )
  end

  def destroy
    @post = Post.find(params[:post_id])
    greats = current_user.greats.find_by!(post_id: @post.id)
    greats.destroy!
    #redirect_back fallback_location: root_path, warning: 'いいねを解除しました'
    
    render turbo_stream: turbo_stream.replace(
      'great-button',
      partial: 'posts/great_button',
      locals: { product: @product, liked: false },
    )
  end
end
