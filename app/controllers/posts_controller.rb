class PostsController < ApplicationController
  def index
    @posts = Post.all.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @post = Post.new
  end

  def create
    #binding.pry
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:alert] = 'もふの投稿が成功しました！'
      redirect_to posts_path
    else
      flash[:alert] = '投稿が失敗しました。人間が写ってませんか？'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:name, :body, :post_image, :post_image_cache)
  end
end