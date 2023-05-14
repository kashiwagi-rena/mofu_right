class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
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
              name: image.filename
            }
          }
        )
  
        # Rekognitionの結果に基づいて、投稿の可否を判断する
        #binding.pry
        if response.labels.any? { |label| label.name.downcase.include?('person') }
          flash[:alert] = '投稿が失敗しました。人間が写っています。'
          @post.destroy
          render :new
        elsif response.labels.any? { |label| label.name.downcase.include?('animal') }
          flash[:alert] = 'もふもふの投稿が成功しました！'
          redirect_to posts_path
        else
          @post.destroy
          flash[:alert] = '投稿が失敗しました。もふ以外が写っています。'
          render :new
        end
      else
        flash[:alert] = '投稿が失敗しました。画像を選択してください。'
        render :new
      end
    else
      flash[:alert] = '投稿が失敗しました。タイトルと本文は必須です。'
      render :new
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