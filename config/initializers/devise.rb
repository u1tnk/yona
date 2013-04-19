pit = Pit.get('yona', require: {
  github_id: "",
  github_secret: "",
})
# for heroku
pit["github_id"] ||= ENV["github_id"]
pit["github_secret"] ||= ENV["github_secret"]

Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :developer unless Rails.env.production?
  provider :github, pit["github_id"], pit["github_secret"]
end

