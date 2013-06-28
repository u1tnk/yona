class TopController < ApplicationController
  def index
    if current_user
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
    end

    respond_to do |format|
      format.html
      format.json { render json: @unreads, each_serializer: UnreadsContainerSerializer }
    end
  end
end
