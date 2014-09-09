class NewsController < ApplicationController

  TUMBLR = File.expand_path(File.dirname(__FILE__) + '../../../config/tumblr.yml')

  if File.exists? TUMBLR
    config = YAML.load_file(TUMBLR)
    config.each { |key, value| ENV[key] || ENV[key] = value.to_s }
  end

  def index
    client = Tumblr::Client.new({
      consumer_key: ENV['KEY'],
      consumer_secret: ENV['SECRET'],
      oauth_token: ENV['TOKEN'],
      oauth_token_secret: ENV['TOKEN_SECRET']
    })
    blog = ENV['BLOG']
    recent_posts = client.posts(ENV['BLOG'], limit: 10)
  end
end
