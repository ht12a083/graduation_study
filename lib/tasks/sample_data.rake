namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_microposts
		make_relationships
	end
end

def make_users
	admin = User.create!(name: "miyakozima",
						email: "miyakozima@gmail.com",
						labo: "久松研",
						password: "miyakozima",
						password_confirmation: "miyakozima",
						admin: true)
	99.times do |n|
		random = rand(1..6)
		if random == 1 then
			labo = "久松研"
		else 
			labo = "その他"
		end
		name = "miyakozima#{n+1}"
		if n+1 < 10
			student_id = "ht12a00#{n+1}"
		else
			student_id = "ht12a0#{n+1}"
		end
		email = "miyakozima#{n+1}@gmail.com"
		password = "miyakozima#{n+1}"
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