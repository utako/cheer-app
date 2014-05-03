class CommentsController < ApplicationController

  def comment
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.commenter = current_user
    if @comment.save
      redirect_to commented_item
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to root_url
    end
  end

  def destroy
    # @comment =
    # @comment.destroy
    # redirect_to
  end

  private

  def commented_item
    if comment_params[:commentable_type] == "Goal"
      Goal.find(comment_params[:commentable_id])
    elsif comment_params[:commentable_type] == "User"
      User.find(comment_params[:commentable_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end

end
