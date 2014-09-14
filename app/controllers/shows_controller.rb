class ShowsController < ApplicationController
  def index
    @shows = Show.find(:all, order: 'date')
  end

  def add_show
    if params['date'] && Chronic.parse(params['date'])
      if params['hidden_id'].blank?
        show = Show.new
      else
        show = Show.find(params['hidden_id'].to_i)
      end
      date = Chronic.parse(params['date'])
      show.date = date if date
      show.venue = params['venue']
      show.location = params['location']
      show.tickets = params['tickets']
      show.purchase_options = params['show_options']
      show.save
    end
    redirect_to controller: 'shows', action: 'index'
  end

  def delete
    show = Show.find(params['id'].to_i)
    show.destroy
    render nothing: true
  end
end
