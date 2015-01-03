class HomeController < ApplicationController

  def index
  end

  def update_latest
    @width = params['width']
    tumblr = File.expand_path(File.dirname(__FILE__) + '../../../config/tumblr.yml')

    if File.exists? tumblr
      config = YAML.load_file(tumblr)
      config.each { |key, value| ENV[key] || ENV[key] = value.to_s }
    end

    client = Tumblr::Client.new({
      consumer_key: ENV['TUMBLR_KEY'],
      consumer_secret: ENV['TUMBLR_SECRET'],
      oauth_token: ENV['TUMBLR_TOKEN'],
      oauth_token_secret: ENV['TUMBLR_TOKEN_SECRET']
    })
    blog = ENV['TUMBLR_BLOG']
    @recent_posts = client.posts(blog, limit: 20)['posts']

    twitter = File.expand_path(File.dirname(__FILE__) + '../../../config/twitter.yml')

    if File.exists? twitter
      config = YAML.load_file(twitter)
      config.each { |key, value| ENV[key] || ENV[key] = value.to_s }
    end

    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_API_KEY']
      config.consumer_secret = ENV['TWITTER_API_SECRET']
      config.access_token = ENV['TWITTER_TOKEN']
      config.access_token_secret = ENV['TWITTER_SECRET']
    end

    @tweets = twitter_client.user_timeline(twitter_client.user, {count: 200, incude_rts: true})
    respond_to do |format|
      format.html { render partial: 'layouts/latest' }
    end
  end

end
