class CalendarsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def index
	  @array = []
      @calendar = Calendar.find_by(date: params[:date],user_id: params[:id])
      @user = User.find(params[:id])
      Micropost.where(:user_id => params[:id]).find_each do |micropost|
      	if micropost.created_at.strftime('%Y%m%d') == params[:date]
      		@array << micropost.created_at.strftime('%H%M%S').insert(2, ":").insert(5, ":")
      		@array << micropost.content
      	end
      end
    end

    def show

    end

    def calendar
    	@date = params[:year] + params[:month] + params[:day]
    	@array = []
    		Micropost.where(:user_id => current_user.id).find_each do |micropost|
		      	if micropost.created_at.strftime('%Y%m%d') == @date
		      		@array << micropost.created_at.strftime('%H%M%S').insert(2, ":").insert(5, ":")
		      		@array << micropost.content
		      	end
     		 end
 		if Calendar.where(:user_id => current_user.id).find_by date: @date
    		@calendar = Calendar.where(:user_id => current_user.id).find_by date: @date
    		
    	else
    		@calendar = Calendar.new(:date => @date,:user_id => current_user.id)
    	end

    end

    def edit
    	 @date = params[:year] +params[:month] + params[:day]
   
    	if Calendar.where(:user_id => current_user.id).find_by date: @date
    		@calendar = Calendar.where(:user_id => current_user.id).find_by date: @date
    	else
    		@calendar = Calendar.new(:date => @date,:user_id => current_user.id)
    	end
    end

    def update
	@calendar = current_user.calendars.build(calendar_params)
	if @calendar.update_attributes(calendar_params)
		flash[:success] = "#{@calendar.date} を更新しました"
		redirect_to root_url
	else
		render 'edit'
	end
  end

    def new
    	@calednar = Calendar.new
    	
    end

	def create
		@calendar = current_user.calendars.build(calendar_params)
		if @calendar.save
			flash[:success] = "#{@calendar.date} を作成しました"
			
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def destroy
		@calendar.destroy
		redirect_to root_url
	end

	private
	
		def calendar_params
			params.require(:calendar).permit(:content,:date,:time)
		end

		def correct_user
			@calendar = current_user.calendars.find_by(id: params[:id])
			redirect_to root_url if @calendar.nil?
		end
end