class UsersController < ApplicationController
  def show
    @user = current_user
    @alerts = Alert.all
  end
end
