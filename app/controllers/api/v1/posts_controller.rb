class Api::V1::PostsController < ApplicationController
  def index
    posts = Post.offset(params[:offset] || 0).limit(params[:limit] || false)
    render json: posts
  end

  def show
    post = Post.find params[:id]
    render json: post
  end

  def create
    post = Post.create post_params
    if post.valid?
      render json: post
    else
      render json: post.errors
    end
  end

  def update
    post = Post.find params[:id]
    if post.update editable_params
      render json: post
    else
      render json: post.errors
    end
  end

  def destroy
    post = Post.find params[:id]
    if post.destroy
      render :nothing
    end
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :user_id
    )
  end

  def editable_params
    params.require(:post).permit(
      :title
    )
  end
end