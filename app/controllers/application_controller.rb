class ApplicationController < ActionController::Base
  # deviseのストロングパラメータを編集する場合、ApplicationControllerに記述する。
  # deviseのコントローラは直接修正できないため、全てのコントローラに対する処理を行える
  # 権限を持つ、ApplicationControllerに記述する必要がある。

  # 以下の記述があることで、devise利用の機能（ユーザ登録、ログイン認証など）が使われる前に
  # configure_permitted_parametersメソッドが実行される。
  before_action :configure_permitted_parameters, if: :devise_controller?

  # after_sign_in_path_forはDeviseが用意しているメソッドで、
  # サインイン後にどこに遷移するかを設定しているメソッド。
  # 初期設定ではroot_pathになっているが、下記のような記述をすることで上書きすることができる。
  def after_sign_in_path_for(resource)
    # ログイン後の遷移先を一覧画面へ変更
    # about_path
    post_images_path

  end

  # 上のメソッドのサインアウト版
  def after_sign_out_path_for(resource)
    about_path
  end

  # privateは記述をしたコントローラ内でしか参照できない。
  # 一方、protectedは呼び出された他のコントローラからも参照することができる。
  protected

  # configure_permitted_parametersメソッドでは、devise_parameter_sanitizer.permitメソッドを
  # 使うことでユーザ登録（sign_up）の際に、ユーザ名（name）のデータ操作を許可している。
  # これはストロングパラメータと同様の機能。
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
