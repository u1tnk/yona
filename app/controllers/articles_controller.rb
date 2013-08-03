class ArticlesController < ApplicationController

  def index(feed_id)
    @feed = Feed.find(feed_id)
    @articles = @feed.articles.unread(current_user)
    respond_to do |format|
      format.html { render partial: 'articles' }
      format.json { render json: @articles, root: false}
    end
  end

  def show(id)
    @article = Article.find(id)
    ArticleReadLog.where(user: current_user, article_id: @article, feed: @article.feed).first_or_create
    head :ok
  end
end
