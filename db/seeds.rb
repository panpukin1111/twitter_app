puts 'seed 実行'
puts 'TRUNCATE tables'
ActiveRecord::Base.connection.execute("set foreign_key_checks = 0")
truncate_ignore = ['schema_migrations']
ActiveRecord::Base.connection.tables.each do |table|
  unless truncate_ignore.include?(table)
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table}")
  end
end
ActiveRecord::Base.connection.execute("set foreign_key_checks = 1")

puts 'create User'
100.times do |i|
  name  = "Example-user#{i+1}"
  email = "example-#{i+1}@railstutorial.org"
  password = "password"
  User.create!(
    name:  name,
    email: email,
    password: password,
    password_confirmation: password,
    admin: false,
    activated: true,
    activated_at: Time.zone.now
    )
end

puts 'create content'

users = User.order(:created_at).take(6)
50.times do |i|
  content = "content-#{i+1}"
  users.each { |user| user.microposts.create!(content: content) }
end

puts 'create relationship'
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

puts 'create group'
100.times do |i|
  name = "group-#{i+1}"
  description = "description-#{i+1}"
  Group.create!(
    name:  name,
    description: description
    )
end
Group.create!(name: "group_half", description: "1-50" )

puts 'create group_user'
100.times do |i|
  GroupUser.create!(
    user_id: i+1,
    group_id: 1
  )
end
group_id = 1
1000.times do |i|
  if group_id > 100
    group_id = 1
  end
  user_id = i.div(10) + 1
  GroupUser.create!(
    user_id: user_id,
    group_id: group_id
  )
  group_id += 1
end
50.times do |i|
  GroupUser.create!(
    user_id: i+1,
    group_id: 101
  )
end