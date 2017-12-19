
namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    100.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
      opening_hours: FFaker::Time.datetime,
      tel: FFaker::PhoneNumber.short_phone_number,
      address: FFaker::Address.street_address,
      description: FFaker::Lorem.paragraph,
      category: Category.all.sample)
    end
    puts "Finished!"
    puts "Now you have #{Restaurant.count} restaurants"
  end

  task fake_user: :environment do
    User.all.each do |i|
      if i.role != "admin"
        i.destroy
      end
    end

    20.times do |i|
      User.create!(email: FFaker::InternetSE.free_email,
      password: "123456")
    end
    puts "Finished!"
    puts "Now you have #{User.count} public users"
  end

  task fake_comment: :environment do
    Comment.destroy_all

    Restaurant.all.each do |i|
      3.times do |j|
        i.comments.create!(content: FFaker::Lorem.paragraph,
        score: Random.rand(1..5),
        restaurant_id: i.id,
        user_id: User.all.sample.id)
      end
    end
    puts "Finished!"
    puts "Now the comments are created"
  end
end
