namespace :db do
  desc "Import Category"
  task categories: [:environment] do
    ["山", "川", "平野"].each do |category|
      Category.create! name: category
    end
  end
end
