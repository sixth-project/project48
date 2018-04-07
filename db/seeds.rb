# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#管理ユーザー
user1 = User.create!(name:  "arthur",
             email: "arthur5138@gmail.com",
             password:              "1234567",
             password_confirmation: "1234567",
             admin:     true)
             user1.skip_confirmation! #Deviseのactivation(メール承認)をスキップしてる。
             user1.save!

#4人のサンプルユーザー
             4.times do |n|
               name  = Faker::Name.name
               email = "example-#{n+1}@railstutorial.org"
               password = "password"
               user = User.create!(name:  name,
                            email: email,
                            password:              password,
                            password_confirmation: password)
                            user.skip_confirmation!
                            user.save!
             end

#Blogのサンプルポスト

users = User.order(:created_at).take(3)

7.times do
  #image = Rails.root.join("test/fixtures/images/slug.jpg").open   /seedを入れるとmount_uploadersの為エラーが出る？
  title = "タイトル"
  text = "これは、テスト投稿です！！"
  users.each { |user| user.blogs.create!(title: title, text: text) }
end
