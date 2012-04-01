namespace :db do
  desc "Fill the database with sample data"
  task :populate => :environment do
    # Reset the database
    Rake::Task['db:reset'].invoke

    if Rails.env.production?
      # Here we will generate a random password.
      temp = [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
      password = (0..50).map{temp[rand(temp.length)]}.join
    else
      password = "password"
    end

    User.create!(:username => "admin",
                 :email => "aziz@azizlight.me",
                 :password => password,
                 :password_confirmation => password,
                 :admin => true,
                 :active => true)

    User.create!(:username => "user",
                 :email => "user@example.com",
                 :password => password,
                 :password_confirmation => password,
                 :admin => false,
                 :active => true)

    #10.times do
      #user_name = Faker::Internet.user_name.gsub(/\./, '')
      #User.create!(:username => user_name,
                 #:email => Faker::Internet.email,
                 #:password => password,
                 #:password_confirmation => password,
                 #:admin => false,
                 #:active => false)
    #end

    #100.times do
      #Post.create!(:title => Faker::Lorem.sentence(rand(1...10)),
                   #:body => Faker::Lorem.paragraphs(rand(2...5)).join(" "),
                   #:published => rand(1...10).even?,
                   #:user_id => rand(1..12))
    #end
  end
end
