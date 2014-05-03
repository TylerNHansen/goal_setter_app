class CommentsController < ApplicationController


  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    unless @comment.save
      flash[:errors] = @comment.errors.full_messages
    end
    if @comment.commentable.class == User
      redirect_to @comment.commentable
    else
      user = @comment.commentable.user
      redirect_to url_for([user, @comment.commentable])
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    object = @comment.commentable
    @comment.delete
    if object.class == User
      redirect_to object
    else
      user = object.user
      redirect_to url_for([user, object])
    end
  end


  private

  def comment_params
    params.require(:comment)
    .permit(:body, :commentable_id, :commentable_type)
  end

end
