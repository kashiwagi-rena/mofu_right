class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  private

  def after_sign_in_path_for(resource)
    if current_user
      #alert:"ログインに成功しました"
      posts_path
    else
      flash[:notice] = "新規登録が完了しました。次にプロフールを入れてください。"
    end
  end
end
