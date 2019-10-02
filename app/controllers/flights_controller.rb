class FlightsController < ApplicationController
  def index
    @flight = Flight.new
  end

  def show
    if Flight.exists? id: flight_params[:id]
      @flight = Flight.find(flight_params[:id])
    else
      flash[:info] = 'Sorry, that flight does not exist'
      redirect_to root_path
    end
  end

  def new
    @flight = Flight.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def flight_params
      params.require(:flight).permit(:id, :from_id, :to_id)
    end
end
