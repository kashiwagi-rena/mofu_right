class PostsController < ApplicationController
  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    #@post = Post.new(post_params)
    if @post.save
      redirect_to posts_path flash[:alert] = 'もふの投稿が成功しました！'
    else
      flash[:alert] = '投稿が失敗しました。人間が写ってませんか？'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :body, :post_image, :post_image_cache)
  end
end