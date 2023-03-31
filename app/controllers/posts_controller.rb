class PostsController < ApplicationController
  def index
    #@posts = Post.all.includes(:user).order(created_at: :desc)
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    #@post = current_user.posts.build(post_params)
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, success: t('もふの投稿が成功しました！')
    else
      flash.now['danger'] = t('投稿が失敗しました。人間が写ってませんか？')
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :body, :photo)
  end
end