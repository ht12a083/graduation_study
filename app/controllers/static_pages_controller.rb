class StaticPagesController < ApplicationController
  def home
  	if signed_in?
		  @micropost = current_user.microposts.build
      @calendar = current_user.calendars.build
      @feed_items = current_user.feed.paginate(page: params[:page])
	  end
  end

  def help
  end

  def about
  end

  def contact
  end

  def sample
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def memo
    @calendar = current_user.calendars.build
  end
end
