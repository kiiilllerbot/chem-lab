class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_group, only: [:show, :update, :destroy]

  def index
    @groups = Group.all

    render json: @groups
  end

  def show
    render json: @group
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      render json: @group, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def update
    if @group.update(group_params)
      render json: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @group.destroy
  end

  private
    def set_group
      @group = Group.find_by(params[:slug])
    end

    def group_params
      params.require(:group).permit(:name, :description)
    end

    def require_admin
      unless current_user && current_user.admin?
        render json: {error: 'You must be an admin to perform this action.'}
      end
    end
end
