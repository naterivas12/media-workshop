class CommentsController < ApplicationController
  before_action :set_comment, only: %i[destroy]

  # POST /articles/:article_id/comments
  def create
    @comment = Comment.new(comment_params)

    @comment.user = current_user
    @article = Article.find(params[:article_id])
    @comment.article = @article

    if @comment.save
      redirect_to @article, notice: "Comment was successfully created."
    else
      render "articles/show", status: :unprocessable_entity
    end
  end

  # DELETE /comments/:id
  def destroy
    authorize(@comment)
    @comment.destroy
    redirect_to @comment.article,
                notice: "Comment was successfully destroyed.",
                status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body)
  end
end
