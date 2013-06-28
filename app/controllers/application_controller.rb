class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # セッション有効期限延長
  before_filter :reset_session_expires

  # 未ログインリダイレクト
  before_filter :authorize

  private

  #-----------------------#
  # reset_session_expires #
  #-----------------------#
  # セッション期限延長
  def reset_session_expires
    request.session_options[:expire_after] = 2.weeks
  end

  #--------------#
  # current_user #
  #--------------#
  def current_user
    @current_user ||= User.where( id: session[:user_id] ).first
  end

  helper_method :current_user

  #-----------#
  # authorize #
  #-----------#
  # ログイン認証
  def authorize
    if params[:controller] != "top" and params[:controller] != "sessions"
      # トップページ以外で未ログインであればトップヘリダイレクト
      if session[:user_id].blank?
        redirect_to :root and return
      end
    end
  end
end
