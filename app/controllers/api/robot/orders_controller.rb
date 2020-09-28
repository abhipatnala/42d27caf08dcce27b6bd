class Api::Robot::OrdersController < ApplicationController
  before_action :robot
  def create
    render json: robot.process_request(params[:commands])
  end

  private

  def robot
    @robot ||= Toy.where(id:params[:id]).first_or_initialize
  end
end

