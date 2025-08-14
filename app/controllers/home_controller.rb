class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def index
    redirect_to dashboard_path if user_signed_in?
  end

  def dashboard
    @user = current_user
    @subscriptions = @user.subscriptions.active if @user.respond_to?(:subscriptions)
  end
end
