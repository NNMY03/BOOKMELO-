class ApplicationController < ActionController::Base

  # ログインしてない場合
  # before_action :authenticate_customer!, except: [:top]

  def after_sign_in_path_for(resource)
    case resource
      when Customer
        root_path # ログイン後に遷移するpathを設定
    end
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end
end
