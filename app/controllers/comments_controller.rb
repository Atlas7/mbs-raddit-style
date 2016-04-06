class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!

  # POST /comments
  # POST /comments.json
  def create
    commentable = commentable_type.constantize.find(commentable_id)
    @comment = Comment.build_from(commentable, current_user.id, body)

    respond_to do |format|
      if @comment.save
        make_child_comment

        format.html  { redirect_to(:back, :notice => 'Comment was successfully added.') }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @comment.upvote_by current_user
    respond_to do |format|
      format.js {render :refresh_votes}
    end
  end

  def downvote
    @comment.downvote_by current_user
    respond_to do |format|
      format.js {render :refresh_votes}
    end
  end

  def refresh_votes
    respond_to do |format|
      format.js { }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.

    def comment_params
      #params.require(:comment).permit(:link_id, :user_id, :body, :commentable_id, :commentable_type, :comment_id)
      params.require(:comment).permit(:body, :commentable_id, :commentable_type, :comment_id)
    end

    def commentable_type
      comment_params[:commentable_type]
    end

    def commentable_id
      comment_params[:commentable_id]
    end

    def comment_id
      comment_params[:comment_id]
    end

    def body
      comment_params[:body]
    end

    def make_child_comment
      return "" if comment_id.blank?

      parent_comment = Comment.find(comment_id)
      @comment.move_to_child_of(parent_comment)
    end

end
