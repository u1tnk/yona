class ArticlesController < ApplicationController

  def index(feed_id)
    @feed = Feed.find(feed_id)
    @articles = @feed.articles.unread(current_user)
    respond_to do |format|
      format.html { render layout: false }
      format.json { render json: @articles, root: false}
    end
  end

  def show(id)
    @article = Article.find(id)
    ArticleReadLog.where(user: current_user, article: @article, feed: @article.feed).first_or_create
    respond_to do |format|
      format.html { render layout: false }
      format.json
    end
  end
end
