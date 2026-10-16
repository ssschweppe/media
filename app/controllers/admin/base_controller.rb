class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  private

  def require_admin!
    raise CanCan::AccessDenied unless current_user.admin?
  end
end