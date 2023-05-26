source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"


# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  #でバッカー
  gem 'pry-byebug'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails'

#画像アップロード用gem
gem 'carrierwave', '>= 3.0.0.beta', '< 4.0'
#ファイルの保存先を外部のストレージする際にサポートしてくれるgem
gem 'fog-aws'

#ログイン認証
gem 'devise'
#ログイン認証の日本語表示 公式：https://github.com/tigrish/devise-i18n　記事：https://karlley.hatenablog.jp/entry/2022/09/23/060408
gem 'devise-i18n'

#環境変数の設定（openするべきではないものを入れるところ https://pikawaka.com/rails/dotenv-rails）
gem 'dotenv-rails'

#google_loginようにgem　公式：https://github.com/zquestz/omniauth-google-oauth2 参考：https://qiita.com/akioneway94/items/35641ad30c2acb23b562　
gem 'omniauth-google-oauth2'

#aws
gem 'aws-sdk-rekognition'
gem 'aws-sdk-s3'
#ページネーション 公式：https://github.com/kaminari/kaminari　ピカワカ：https://pikawaka.com/rails/kaminari
gem 'kaminari'

gem "dockerfile-rails", ">= 1.2", :group => :development

gem "redis", "~> 5.0"
#i18n　公式：https://github.com/svenfuchs/rails-i18n　
gem 'rails-i18n', '~> 7.0.0'

#OGP 参考記事：https://zenn.dev/yoshiki105/articles/eb093bf603e728
gem "meta-tags"

#にくきゅう文字：https://rubygems.org/gems/pad_character
gem "pad_character"