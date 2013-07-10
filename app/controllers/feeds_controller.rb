class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  def default_serializer_options
    {root: false}
  end

  def index
    @unreads = []

    # TODO モデルへ
    @unread_user_feeds = UserFeed.unreads(current_user)
    current_user.tags.map do |tag|
      user_feeds = UserFeed.select_by_tag(@unread_user_feeds, tag)
      next if user_feeds.empty?
      uc = UnreadsContainer.new
      uc.tag = tag
      uc.user_feeds = user_feeds
      @unreads << uc
    end

    respond_to do |format|
      format.html { render layout: false}
      format.json { render json: @unreads, each_serializer: UnreadsContainerSerializer }
    end
  end

  def show
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new(feed_params)

    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        format.json { render action: 'show', status: :created, location: @feed }
      else
        format.html { render action: 'new' }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url }
      format.json { head :no_content }
    end
  end

  def upload
    if request.method == "POST"
      Feed.import current_user, request.params[:opml_file].read
      Feed.fetch_all
      redirect_to :root
    end
  end

  def fetch
    current_user.feeds.each{|f| f.fetch}
    render json: 'success'
  end

  private
    def set_feed
      @feed = Feed.find(params[:id])
    end

    def feed_params
      params.require(:feed).permit(:title, :url, :html_url, :kind)
    end
end
