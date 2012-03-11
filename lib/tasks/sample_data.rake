namespace :db do
  desc "Fill the database with sample data"
  task :populate => :environment do
    # Reset the database
    Rake::Task['db:reset'].invoke

    User.create!(:username => "admin",
                 :email => "admin@example.com",
                 :password => "admin",
                 :password_confirmation => "admin")

    10.times do
      user_name = Faker::Internet.user_name.gsub(/\./, '')
      User.create!(:username => user_name,
                 :email => Faker::Internet.email,
                 :password => user_name,
                 :password_confirmation => user_name)
    end

    100.times do
      Post.create!(:title => Faker::Lorem.sentence(rand(1...10)),
                   :body => Faker::Lorem.paragraphs(rand(2...5)).join(" "),
                   :published => rand(1...10).even?,
                   :user_id => rand(1..11))
    end
  end
end
