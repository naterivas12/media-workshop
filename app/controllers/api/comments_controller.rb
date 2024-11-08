module Api
  class CommentsController < ApiController
    before_action :set_comment, only: %i[destroy]

    # POST /articles/:article_id/comments
    def create
      @comment = Comment.new(comment_params)

      @comment.user = current_user
      @article = Article.find(params[:article_id])
      @comment.article = @article

      if @comment.save
        render json: @comment
      else
        render json: { errors: @comment.errors }, status: :unprocessable_entity
      end
    end

    # DELETE /comments/:id
    def destroy
      authorize(@comment)
      @comment.destroy
      head :no_content
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
end
