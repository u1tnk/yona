if Rails.env.production?
  DEFAULT_PROVIDER = "github"
else
  DEFAULT_PROVIDER = "developer"
end
