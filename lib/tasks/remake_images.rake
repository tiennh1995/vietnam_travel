namespace :db do
  desc "Import Image"
  task images: [:environment] do
    (1..5).each do |index|
      image = Image.new user_id: 1, category_id: 1, address: "ハノイ",
        description: "良い所です。景色がとてもきれいです。毎年、たくさん客はここへ行きます。
        良い所です。景色がとてもきれいです。毎年、たくさん客はここへ行きます。
        良い所です。景色がとてもきれいです。毎年、たくさん客はここへ行きます。",
        image: Rails.root.join("app/assets/images/portfolio-#{index}.jpg").open
      image.save!
    end
    (6..7).each do |index|
      image = Image.new user_id: 2, category_id: 1, address: "ハノイ",
        description: "良い所です。景色がとてもきれいです。毎年、たくさん客はここへ行きます。
        良い所です。景色がとてもきれいです。毎年、たくさん客はここへ行きます。
        良い所です。景色がとてもきれいです。毎年、たくさん客はここへ行きます。",
        image: Rails.root.join("app/assets/images/portfolio-#{index}.jpg").open
      image.save!
    end
  end
end
