class FeedsController < ApplicationController
  def rss
    @episodes = Episode.all

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end
