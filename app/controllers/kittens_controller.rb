# frozen_string_literal: true

class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
  end

  def show
    @kitten = Kitten.find(params[:id])
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
  end

  private

    def kitten_params
      require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
