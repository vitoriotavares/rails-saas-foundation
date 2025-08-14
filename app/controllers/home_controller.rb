class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def index
    redirect_to dashboard_path if user_signed_in?
  end

  def dashboard
    @user = current_user
    @subscriptions = begin
      if @user.respond_to?(:subscriptions) && defined?(Pay)
        @user.subscriptions.active
      else
        []
      end
    rescue => e
      Rails.logger.error "Error loading subscriptions: #{e.message}"
      []
    end
  end
end
