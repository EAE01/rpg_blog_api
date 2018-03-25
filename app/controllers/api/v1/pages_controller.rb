class Api::V1::PagesController < ApplicationController
  before_action :set_post

  def index
    pages = @post.pages.order(:number)
    render json: pages
  end

  def show
    page = @post.pages.find params[:id]
    render json: page
  end

  def create
    page = @post.pages.create page_params
    if page.valid?
      render json: page
    else
      render json: page.errors
    end
  end

  def update
    page = @post.pages.find params[:id]
    if page.update editable_params
      render json: page
    else
      render json: page.errors
    end
  end

  def destroy
    page = @post.pages.find params[:id]
    if page.destroy
      render :nothing
    end
  end

  private

  def page_params
    params.require(:page).permit(
      :number,
      :content
    )
  end

  def editable_params
    page_params
  end

  def set_post
    @post = Post.includes(:pages).find params[:post_id]
  end
end