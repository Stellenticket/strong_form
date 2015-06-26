class BaseController < ApplicationController
  def basic_form
    @user = User.new
  end
end
