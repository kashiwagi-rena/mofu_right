class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :destroy, :edit, :update, :destroy]
  #AWS Rekognition
  require 'aws-sdk-rekognition'

  def index
    @posts = Post.all.includes([:user, :greats]).order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    rekognition_client = Aws::Rekognition::Client.new(region: 'ap-northeast-1', access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])

    if @post.save
      image = @post.post_image
      if image.present?
        # 画像に対してRekognitionを実行し、ラベル情報を取得する
        response = rekognition_client.detect_labels(
          image: {
            s3_object: {
              bucket: ENV['AWS_S3_BUCKET_NAME'],
              name: image.path
            }
          },
          max_labels: 5
        )
        
        #binding.pry

        # Rekognitionの結果に基づいて、投稿の可否を判断する
        #binding.pry
        if response.labels.any? { |label| label.name.downcase.include?('person') }
          flash[:alert] = '投稿が失敗しました。人間が写っています。'
          @post.destroy
          render :new
        elsif ['animal', 'cat', 'dog', 'pet'].any? { |word| response.labels.any? { |label| label.name.downcase.include?(word) } }
          redirect_to posts_path
          flash[:alert] = 'もふもふの投稿が成功しました！'
        else
          @post.destroy
          render :new
          flash[:alert] = 'ﾓﾌｼﾞｬﾅｲ・・・'
        end
      else
        flash[:alert] = '投稿が失敗しました。画像を選択してください。'
        render :new
      end
    else
      render :new
      flash[:alert] = '投稿が失敗しました。タイトルと本文、写真は必須です。'
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def greats
    @great_posts = current_user.great_posts.includes(:user).order(created_at: :desc)
  end 

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      flash[:success] = t('defaults.message.updated', item: @post.name)
      redirect_to @post
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: @post.name)
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path
    flash[:success] = t('defaults.message.deleted', item: @post.name)
  end

  private

  def post_params
    params.require(:post).permit(:name, :body, :post_image, :post_image_cache)
  end

  def rekognition_tags(image, s3)
    # Rekognitionのクライアントを作成
    rekognition_client = Aws::Rekognition::Client.new(region: 'ap-northeast-1', access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
    
    # 画像をS3にアップロード
    obj = s3.bucket(ENV['AWS_S3_BUCKET_NAME']).object(image.filename)
    obj.upload_file(image.tempfile, acl: 'public-read')

    # 画像に対してRekognitionを実行し、ラベル情報を取得する
    response = rekognition_client.detect_labels(
      image: {
        s3_object: {
          bucket: ENV['AWS_S3_BUCKET_NAME'],
          name: image.filename
        }
      },
      max_labels: 5
    )

    # ラベル情報からタグ名の配列を作成して返す
    response.labels.map(&:name)
  end
end