class PostsController < ApplicationController
  before_action :logged_in, only: %i[new create]

  def new
  end

  def create
  end

  def index
  end
end
