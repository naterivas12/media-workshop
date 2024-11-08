module Api
  class ArticlesController < Api::ApiController
    before_action :set_article, only: %i[show update destroy]

    # GET api/articles
    def index
      @articles = Article.all
      render json: @articles, status: :ok
    end

    # GET api/articles/:id
    def show
      render json: @article, status: :ok
    end

    # POST api/articles
    def create
      @article = Article.new(article_params)
      @article.user = current_user

      if @article.save
        render json: @article, status: :created
      else
        render json: { errors: @article.errors }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT api/articles/1
    def update
      authorize(@article)
      if @article.update(article_params)
        render json: @article, status: :ok
      else
        render json: { errors: @article.errors }, status: :unprocessable_entity
      end
    end

    # DELETE api/articles/1
    def destroy
      authorize(@article)
      @article.destroy
      head :no_content
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :cover, :body)
    end
  end
end
