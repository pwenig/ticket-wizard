# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.event_id = params[:event_id]
    if @comment.save
      redirect_to event_path(params[:event_id])
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to events_path
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
