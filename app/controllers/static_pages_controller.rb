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
      @today = Time.zone.now
      @year = @today.year
      @month = @today.month
      @day = @today.day
      @signed_in_user = current_user.id
	  end
  end


  def show
    render :text => "id = #{params[:id]}"
    render :text => " #{params[:title]}, #{params[:num]}"
  end
end
