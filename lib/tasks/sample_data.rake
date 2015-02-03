namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
#		make_microposts
#		make_relationships
	end
end

def make_users
#	admin = User.create!(name: "miyakozima",
#						email: "miyakozima@gmail.com",
#						labo: "久松研",
#						password: "miyakozima",
#						password_confirmation: "miyakozima",
#						admin: true)
	11.times do |n|
		if n == 0 then
			name = "なわてん"
			labo = "なわてん"
		elsif n == 1 then
			name = "大西"
			labo = "大西研"
		elsif n == 2 then
			name = "兼宗"
			labo = "兼宗研"
		elsif n == 3 then
			name = "北嶋"
			labo = "北嶋研"
		elsif n == 4 then
			name = "鴻巣"
			labo = "鴻巣研"
		elsif n == 5 then
			name = "小枝"
			labo = "小枝研"
		elsif n == 6 then
			name = "南角"
			labo = "南角研"
		elsif n == 7 then
			name = "登尾"
			labo = "登尾研"
		elsif n == 8 then
			name = "久松"
			labo = "久松研"
		elsif n == 9 then
			name = "升谷"
			labo = "升谷研"
		elsif n == 10 then
			name = "渡邊"
			labo = "渡邊研"
		end

		if n+1 < 10
			student_id = "ht00a00#{n+1}"
		else
			student_id = "ht00a0#{n+1}"
		end
		email = "miyakozima#{n+1}@gmail.com"
		password = "miyakozima"
		User.create!(name: name,
					student_id: student_id,
					email: email,
					labo: labo,
					password: password,
					password_confirmation: password)
	end
end

def make_microposts
	users = User.all(limit: 6)
	50.times do
		content = Faker::Lorem.sentence(5)
		users.each { |user| user.microposts.create!(content: content) }
	end
end

def make_relationships
	users = User.all
	user = users.first
	followed_users = users[2..50]
	followers = users[3..40]
	followed_users.each { |followed| user.follow!(followed) }
	followers.each { |follower| follower.follow!(user) }
end