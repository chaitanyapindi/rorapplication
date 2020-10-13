# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_blog, only: %i[new edit update destroy]
  before_action :authenticate_user!, except: [ :show ]
  
  #Create a new comment for a blog
  def create
      @comment = @blog.comments.create(comment_params)
      redirect_to blog_path(@blog)
  end

  #Add a new comment for a blog
  def new
  end

  #Edit existing comment on a blog
  def edit
      @comment = @blog.comments.find(params[:id])
  end

  #Update a comment on a blog
  def update
    @comment = @blog.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @blog
    else
      render 'edit'
    end
  end

  # Delete a comment on a blog
  def destroy
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    redirect_to blogs_path
  end

  private
    #Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:blog_id])
    end
    #Allow only permited parameters to save into the database
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
