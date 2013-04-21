class ArticlesController < ApplicationController

  def index(feed_id)
    @feed = Feed.find(feed_id)
    @articles = @feed.articles
    respond_to do |format|
      format.html { render layout: false }
      format.json
    end
  end

  def show(id)
    @article = Article.find(id)
    respond_to do |format|
      format.html { render layout: false }
      format.json
    end
  end
end
