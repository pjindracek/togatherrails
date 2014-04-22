class CommentsController < ApplicationController
  before_action :load_group

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.group = @group
    if @comment.save
      redirect_to @group, notice: 'Comment was added successfully'
    else
      render @group
    end
  end

  private

  def load_group
    @group = Group.find(params[:group_id])
  end

  def comment_params
    params.require(:comment).permit(:title, :message)
  end
end
