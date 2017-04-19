namespace :db do
  desc "Import User"
  task users: [:environment] do

    5.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@gmail.com"
      password = "123456"
      User.create!(full_name: name, email: email, password: password,
        password_confirmation: password)
    end
  end
end
