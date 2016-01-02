class CommentsController < ApplicationController
  before_filter :load_article, :except => :destroy
  before_filter :authenticate, :only => :destroy

  def create
    @comment = @article.comments.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html {redirect_to @article, notice: 'Thanks for your comment'}
        render.js 
      end
    else
      redirect_to @article, notice: 'Failed to post comment'
    end
  end

  def destroy
    @article = current_user.articles.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to @article, notice: 'Comment Deleted'
  end

  private
  def load_article
    @article = Article.find(params[:article_id])
  end
  def comment_params
    params.require(:comment).permit(:name, :email, :body)
  end
end
