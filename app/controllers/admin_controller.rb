class AdminController < ApplicationController

  def mass_signup
    render(:mass_signup, layout: 'no_header')
  end
end
