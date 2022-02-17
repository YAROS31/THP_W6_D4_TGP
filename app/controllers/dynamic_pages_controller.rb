class DynamicPagesController < ApplicationController

  # JBV - Launched when the 'welcome' action of the 'dynamic_pages' controller is invoked
  #       Corresponds to the '/welcome/:first_name' route
  def welcome
    # puts "*** JBV says: displaying 'welcome.html' for #{@params[:first_name]}***"
  end

end
