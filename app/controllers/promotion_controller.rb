class PromotionController < ApplicationController
  def index
    @main_videos = Video.where(category: 'main').order('priority')
    @first_main = Video.where(category: 'main', priority: 1).first
    @vlog_videos = Video.where(category: 'vlog').order('priority')
    @first_vlog = Video.where(category: 'vlog', priority: 1).first
    @live_videos = Video.where(category: 'live').order('priority')
    @first_live = Video.where(category: 'live', priority: 1).first
    @header_text = PromotionText.first.header_content
    @footer_text = PromotionText.first.footer_content
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

  def contribute
    @contribution_text = PromotionText.first.contribution_text
    @albums = JSON.parse(ENV['ALBUMS'])
  end

  def update_contribution_text
    PromotionText.first.update_attributes!(contribution_text: params[:contribution_text])
    render nothing: true
  end

  def send_contribution
    payment_request = Paypal::Payment::Request.new(
      :description   => 'Charles Ellsworth Not A Kickstarter Contribution', # item description
      :quantity      => 1, # item quantity
      :amount        => params[:contribution_amount]
    )

    response = paypal_request.setup(
      payment_request,
      ENV['contribution_paypal_success_redirect'], # success redirect url
      ENV['contribution_paypal_error_redirect'], # error redirect url
    )
    redirect_to response.redirect_uri
  end

  def accept_contribution
    token = params[:token]
    begin
      details = paypal_request.details(token)
      payment_request = Paypal::Payment::Request.new(
        :description   => details.description,    # item description
        :quantity      => 1,      # item quantity
        :amount        => details.amount.total)
      payment_response = paypal_request.checkout!(token, params[:PayerID], payment_request)

      if payment_response.ack == 'Success'
        Curl.post("http://#{ENV['DIGITAL_OCEAN_IP']}/music/create_download_file", {email: details.payer.email})
      end
    rescue => e
      logger.error e
      flash[:error] = "Your contribution was not successful. Please try again."
      redirect_to action: :contribute and return
    end
    flash[:notice] = 'Your contribution was successful! Please check your paypal email address if your donation amount was over 10 dollars.'
    redirect_to action: :contribute
  end

  private

  def paypal_request
    @paypal_request ||= Paypal::Express::Request.new(
                                       :username   => ENV['paypal_username'],
                                       :password   => ENV['paypal_password'],
                                       :signature  => ENV['paypal_signature'])
  end

  def update_header
    f = PromotionText.first
    f.header_content = params['header_text']
    f.save
    render nothing: true
  end

  def update_footer
    f = PromotionText.first
    f.footer_content = params['footer_text']
    f.save
    render nothing: true
  end
end
