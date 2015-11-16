class BaseController < ApplicationController
  helper_method :permitted_attributes

  def basic_form
    @user = User.new
  end

  def fields_for
    @user = User.new
    @user.addresses.build
    @user.build_tag
  end

  def fields_for_explicit
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
    @user.addresses.build
  end

  private

  def permitted_attributes
    {
      bla: :blub
    }
  end
end
