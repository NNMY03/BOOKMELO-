class ApplicationController < ActionController::Base

  # ログインしてない場合
  def authenticate_any!
    if admin_signed_in?
      true
    else
      authenticate_customer!
    end
  end

  def after_sign_in_path_for(resource)
    case resource
      when Customer
        top_path # ログイン後に遷移するpathを設定
    end
  end

  def after_sign_out_path_for(resource)
      top_path # ログアウト後に遷移するpathを設定
  end
end


def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :age, :gender, :password_confirmation])
end