json.array!(@feeds) do |feed|
  json.extract! feed, :title, :feed_url, :html_url, :type
  json.url feed_url(feed, format: :json)
end