class BaseController < ApplicationController
  def basic_form
    @user = User.new
  end

  def fields_for
    @user = User.new
    @user.addresses.build
    @user.build_tag
  end

  def deep_fields_for
    @user = User.new
    (@user.addresses.build).tags.build
    @user.build_tag
  end

  def nested_form_gem
    @user = User.new
  end
end
