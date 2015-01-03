class PromotionController < ApplicationController
  def index
    @main_videos = Video.where(category: 'main').order('priority')
    @first_main = Video.where(category: 'main', priority: 1).first
    @vlog_videos = Video.where(category: 'vlog').order('priority')
    @first_vlog = Video.where(category: 'vlog', priority: 1).first
    @live_videos = Video.where(category: 'live').order('priority')
    @first_live = Video.where(category: 'live', priority: 1).first
  end

  def add_video
    video = Video.new
    video.url = params['url']
    video.category = params['type']
    video.description = params['description']
    videos = Video.where(category: params['type']).order('priority')
    if videos.any?
      last_order = videos.last.priority
    else
      last_order = 0
    end
    video.priority = last_order + 1
    video.save
    redirect_to not_a_kickstarter_path
  end
end
