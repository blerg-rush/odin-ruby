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
      flash[:success] = 'Yay! A new kitten!'
      redirect_to root_path
    else
      flash[:danger] = 'I think you goofed...'
      render :new
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.save
      flash[:success] = "#{@kitten.name} has evolved into #{@kitten.name}!"
      redirect_to root_path
    else
      flash[:danger] = 'I think you goofed...'
      render :edit
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    flash[:info] = 'You monster!'
    redirect_to root_path
  end

  private

    def kitten_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
