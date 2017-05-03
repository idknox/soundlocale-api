class Api::UsersController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :authenticate_user!

  def me
    render json: current_user
  end
end