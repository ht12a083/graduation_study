class Test
  def self.hoge
  	user = 1
  	today = Date.today.to_s.gsub("-", "")
  	User.all.each do |id|
    	Calendar.create(user_id: user, date: today, time: 3)
    	user += 1
	end
  end
end