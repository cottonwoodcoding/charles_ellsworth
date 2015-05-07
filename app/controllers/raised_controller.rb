class RaisedController < ApplicationController
  def update
    Raised.first.update_attributes(params[:raised])
    redirect_to :back
  end
end
