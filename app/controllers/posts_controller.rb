class PostsController < ApplicationController
  before_action :logged_in, only: %i[new create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    flash[:success] = "Heh. That's a good one."
    redirect_to root_path
  end

  def index
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
