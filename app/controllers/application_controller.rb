class ApplicationController < ActionController::Base
  # deviseのストロングパラメータを編集する場合、ApplicationControllerに記述する。
  # deviseのコントローラは直接修正できないため、全てのコントローラに対する処理を行える
  # 権限を持つ、ApplicationControllerに記述する必要がある。

  # 以下の記述があることで、devise利用の機能（ユーザ登録、ログイン認証など）が使われる前に
  # configure_permitted_parametersメソッドが実行される。
  before_action :configure_permitted_parameters, if: :devise_controller?

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
