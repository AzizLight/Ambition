class Admin::SampleDataController < Admin::BaseController
  before_filter :admin?

  # Generate sample data in the database
  def reset
    10.times do
      # Here we will generate a random password.
      temp = [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
      password = (0..50).map{temp[rand(temp.length)]}.join

      User.create(
        :username => Faker::Internet.user_name.gsub(/\./, ''),
        :email => Faker::Internet.email,
        :password => password,
        :password_confirmation => password,
        :admin => false,
        :active => false
      )
    end

    100.times do
      Post.create(
        :title => Faker::Lorem.sentence(rand(1..10)),
        :body => Faker::Lorem.paragraphs(rand(2..5)).join(" "),
        :published => rand(1..10).even?,
        :user_id => rand(1..11)
      )
    end

    ActivityLog.create!(
      :name => "Generated sample data",
      :description => "#{current_user.username} generated sample data.",
      :entity => "content",
      :user_id => current_user.id,
      :ip_address => request.remote_ip
    )
    flash[:success] = "Successfully generated sample data"
    redirect_back_or_to admin_dashboard_index_url
  end
end
