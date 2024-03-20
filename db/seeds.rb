require 'faker'

14.times do |index|
  name = Faker::JapaneseMedia::CowboyBebop.character
  while Profile.exists?(username: name) do
    name = Faker::JapaneseMedia::CowboyBebop.character
  end
  user = User.create(email: Faker::Internet.email(name: name, separators: [''], domain: 'gmail.com'), password: '123456')
  puts "Creating user..."
  profile = Profile.new(username: name, bio: Faker::JapaneseMedia::CowboyBebop.quote, user: user)
  profile.profile_picture.attach(
    io:  File.open(File.join(Rails.root,"/app/assets/images/profile_pictures/profile_picture#{index}.jpg")),
    filename: "profile_picture#{index}.jpg"
  )
  profile.save
  puts "Creating profile..."
end
