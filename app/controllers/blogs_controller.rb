# frozen_string_literal: true
class BlogsController < ApplicationController
  before_action :set_blog, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :authenticate_admin!, only: [:destroy]

  #Index page displaying all the blogs 
  def index
    @blogs = Blog.all
  end

  #Display a particular blog
  def show
  end

  # Create a new blog
  def new
    @blog = Blog.new
  end

  #Selects a blog to edit 
  def edit
  end

  # Creates a new blog and saves it
  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to @blog
    else
      render 'new'
    end
  end

  # Updates a blog 
  def update
    if @blog.update(blog_params)
      redirect_to @blog
    else
      render 'edit'
    end
  end

  # Deletes a blog
  def destroy
    @blog.destroy
    redirect_to blogs_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :text)
    end

    # Authenticate admin access for a user for special previliges
    def authenticate_admin!
      unless current_user.admin?
          redirect_to blogs_path
      end
  end  
end
