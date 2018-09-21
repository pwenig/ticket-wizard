# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @event = Event.find(params[:event_id])
    @comment.event_id = @event.id
    if @comment.save
      redirect_to event_path(params[:event_id], key: @event.event_guid)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to event_path(@comment.event_id, key: @comment.event.event_guid)
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
