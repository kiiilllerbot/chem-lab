class ElementsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_element, only: [:show, :update, :destroy]

  def index
    keys = $redis.keys('element_*')
    begin
      results = $redis.mget(keys)
      if results.present?
        return render json: {element: results.sort }
      else
        return render json: {error: "Could not find element."}
      end
      rescue Redis::CommandError => e
        return render json: {error: "Unable to retrieve element list."}
    end
  end

  def show
    render json: @element
  end

  def create
    @element = Element.new(element_params)

    if @element.save
      render json: @element, status: :created, location: @element
    else
      render json: @element.errors, status: :unprocessable_entity
    end
  end

  def update
    if @element.update(element_params)
      render json: @element
    else
      render json: @element.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @element.destroy
  end

  private
    def set_element
      @element = Element.find_by(params[:name])
    end

    def element_params
      params.require(:element).permit(:name, :atomic_number, :atomic_mass, :symbol, :description, :group_id)
    end

    def require_admin
      unless current_user && current_user.admin?
        render json: {error: 'You must be an admin to perform this action.'}
      end
    end
end
