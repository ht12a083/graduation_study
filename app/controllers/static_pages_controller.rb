class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      @labomem = User.all
      @laboratory = current_user.labo
      @calendar_all = Calendar.all
      @user = current_user
		  @micropost = current_user.microposts.build
      @calendar = current_user.calendars.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @year = Date.today.to_s.gsub('-','')[0,4]
      @month = Date.today.to_s.gsub('-','')[4,2]
      @day = Date.today.to_s.gsub('-','')[6,2]
      @signed_in_user = current_user.id
	  end
  end

  def help
  end

  def about
  end

  def contact
  end

  def calendar
  end

  def micropost
    if signed_in?
      @signed_in_user = current_user.id
      @calendar = Calendar.all
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @timer = Micropost.all
    end
  end

  def show
    render :text => "id = #{params[:id]}"
    render :text => " #{params[:title]}, #{params[:num]}"
  end
end
