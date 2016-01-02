class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  before_action :authenticate, except: [:index, :show]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.search(params[:search]).paginate(:page => params[:page], :per_page => 4)
    @categories = Category.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @commentsShow = @article.comments.paginate(:page => params[:page], :per_page => 4)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = current_user.articles.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render action: 'show', status: :created, location: @article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article = current_user.articles.find(params[:id])
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end


  def upvote()
    @article = Article.find(params[:id])
    respond_to do |format|
    if @article.sum != nil  
      @article.sum = @article.sum + params[:upvote].to_i
    else
      @article.sum = params[:upvote].to_i
    end
      if @article.update(:sum => @article.sum)
        format.html { redirect_to root_path, notice: 'Thank you for you upvote.' }
        format.json { head :no_content }
      end
    end
  end

  def downvote()
     @article = Article.find(params[:id])
     respond_to do |format|
      if @article.sum != nil  
        @article.sum = @article.sum + params[:downvote].to_i
      else
        @article.sum = params[:downvote].to_i
      end
      if @article.update(:sum =>  @article.sum)
        format.html { redirect_to root_path, notice: 'Thank you for you downvote.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :location, :excerpt, :body, :published_at, :category_ids => [])
    end
end
