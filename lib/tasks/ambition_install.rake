namespace :ambition do
  desc "Fill the database with sample data"
  task :install => :environment do
    admin = User.find_by_username("admin")

    if admin
      puts "The admin user already exists"
    else
      puts "Creating the admin user"

      if Rails.env.production?
        # Here we will generate a random password.
        temp = [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
        password = (0..50).map{temp[rand(temp.length)]}.join
      else
        password = "admin"
      end

      User.create!(:username => "admin",
                   :email => "aziz@azizlight.me",
                   :password => password,
                   :password_confirmation => password,
                   :admin => true,
                   :active => true)
    end
  end
end
