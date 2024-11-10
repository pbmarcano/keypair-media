class FeedsController < ApplicationController
  def rss
    @episodes = Episode.all.order(created_at: :desc)

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end
