class Admin::ApplicationController < ApplicationController
  before_filter :check_admin

  private

  def check_admin
    if current_user && current_user.admin
      Rails.logger.info('---- Checking for admin rights!')
    else
      flash[:notice] = 'Go AWAY!!'
      redirect_to movies_path
    end
  end
end
