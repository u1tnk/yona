json.array!(@feeds) do |feed|
  json.extract! feed, :title, :url, :html_url, :kind
  json.url url(feed, format: :json)
end
