class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  
  #Create a new comment for a blog
  def create
      @blog = Blog.find(params[:blog_id])
      @comment = @blog.comments.create(comment_params)
      redirect_to blog_path(@blog)
  end

  #Add a new comment for a blog
  def new
      @blog = Blog.find(params[:blog_id])
  end

  #Edit existing comment on a blog
  def edit
      @blog = Blog.find(params[:blog_id])
      @comment = @blog.comments.find(params[:id])
  end

  #Update a comment on a blog
  def update
      # @blog = Blog.find(params[:blog_id])
      # @comment = Comment.find(params[:id])
      if @comment.update(comment_params)
        redirect_to @blog
      else
        render 'edit'
      end
  end

  # Delete a comment on a blog
  def destroy
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    redirect_to blogs_path
  end

  private
    #Allow only permited parameters to save into the database
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
