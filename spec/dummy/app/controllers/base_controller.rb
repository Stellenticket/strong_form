class BaseController < ApplicationController
  def basic_form
    @user = User.new
  end

  def nested_form
    @user = User.new
    @user.addresses.build
    @user.build_tag
  end

  def deeply_nested_form
    @user = User.new
    (@user.addresses.build).tags.build
    @user.build_tag
  end
end
