source 'https://rubygems.org'

ruby '2.0.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc2'

gem 'settingslogic'
gem 'enumerated_attribute'
gem 'hashie'
gem 'action_args'
gem 'pit'

gem 'mysql2'

gem 'omniauth'
gem 'omniauth-github'

gem 'feedzirra', :git => 'git://github.com/pauldix/feedzirra.git', :ref => '71721ddaeba18383ae283600b6a2eb8a717d7b58'

gem 'commands'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0.beta1'
  gem 'bootstrap-sass', '~> 2.3.1.0'
  gem 'coffee-rails', '~> 4.0.0.beta1'
  gem 'haml-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', group: :development

# To use debugger
# gem 'debugger'

group :development do
  # png圧縮
  gem 'tinypng'
  # n+1検知
  gem 'bullet'

  # guard実行でファイル更新を検知して色々やる
  gem "guard"
  gem 'guard-pow'
  gem 'guard-bundler'
  gem 'guard-livereload'
end

group :development, :test do
  gem 'rack-maintenance'

  gem 'rspec-rails'

  gem 'pry-rails'
  gem 'pry-remote'
  gem 'pry-nav'
  gem 'pry-doc'
  # ruby-2.0.0-p0だと依存関係の関係で動かない
#   gem 'pry-coolline'
  # hoge.tapp.fuga…とチェーン中にデバッグプリント
  gem "tapp"
  # ActiveRecordのデータログを見やすく
  gem 'hirb'
  gem 'hirb-unicode'

  gem 'fabrication'
  gem 'ffaker'

  gem "rails_best_practices"
  gem 'annotate'
  gem 'database_cleaner'

  gem 'spring'

  gem 'terminal-notifier-guard'
end

group :test do
  gem 'rb-fsevent', '~> 0.9'
  gem 'guard-rspec'
  gem 'webmock'
  # テスト時時間いじり用
  gem 'timecop'
end

