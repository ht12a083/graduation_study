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
      if @today.month < 10
        @month = "0" + @today.month.to_s
      else
        @month = @today.month
      end

      if @today.day < 10
        @day = "0" + @today.day.to_s
      else
        @day = @today.day
      end
      @signed_in_user = current_user.id
      @button = current_user.microposts.build
	  end
  end


  def show
    render :text => "id = #{params[:id]}"
    render :text => " #{params[:title]}, #{params[:num]}"
  end
end
