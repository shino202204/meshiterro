class ApplicationController < ActionController::Base
  # ログイン認証が済んでいない状態でトップページ以外の画面にアクセスしても、
  # # ログイン画面へリダイレクトするようになる。
  # before_actionメソッド：このコントローラが動作する前に実行される。
  # 今回の場合、app/controllers/application_controller.rbファイルに記述したので、
  # 全てのコントローラで、最初にbefore_actionメソッドが実行される。

  # authenticate_userメソッド：devise側が用意しているメソッド。:authenticate_user!とすることで、
  # 「ログイン認証されていなければ、ログイン画面へリダイレクトする」機能を実装できる。

  # except：指定したアクションをbefore_actionの対象から外す。
  # Meshiterroではトップページのみログイン状態に関わらず、アクセス可能とするために
  # topアクションを指定している。
  before_action :authenticate_user!, except: [:top]

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
